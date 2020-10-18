import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:talabatk_flutter/Entities/constants.dart';
import 'package:talabatk_flutter/Entities/global.dart';
import 'package:talabatk_flutter/Entities/request.dart';
import 'package:talabatk_flutter/Screens/shop/shop_request_information.dart';
import '../signup.dart';

class ShopHomePage extends StatefulWidget {

  @override
  State<StatefulWidget> createState() => _State();

}

class _State extends State<ShopHomePage>{

  BuildContext currContext=null;
  List<Request> allCustomerRequest=[];
  //all Customer Request divided into 4 Lists
  List<Request> waitingList=[];
  List<Request> processingList=[];
  List<Request> deliveredList=[];
  List<Request> rejectedList=[];

  @override
  Widget build(BuildContext context) {
    currContext=context;
    getAllRequests();
    return  DefaultTabController(
      length: 4,
      child: new Scaffold(
        appBar: AppBar(
          backgroundColor: Color(int.parse(Global.primaryColor)),
          centerTitle: true,
          title:Text(Global.appName,
            style: TextStyle(
                fontFamily: Global.fontFamily,
                fontWeight: FontWeight.w900,
                fontSize: 25
            ),),
          automaticallyImplyLeading: false,
          actions: [
            PopupMenuButton<String>(
              onSelected: choiceAction,
              itemBuilder: (BuildContext context){
                return Constants.choices.map((String choice){
                  return PopupMenuItem<String>(
                    value: choice,
                    child: Text(choice),
                  );
                }).toList();
              },
            )
          ],
        ),
        body: TabBarView(
          children: [
            new Container(
              child: allRequests(Icons.timer,'Waited',waitingList),
            ),
            new Container(
              child: allRequests(Icons.motorcycle,'Processing',processingList),
            ),
            new Container(
              child: allRequests(Icons.done,'Delevired',deliveredList),
            ),
            new Container(
              child: allRequests(Icons.close,'Rejected',rejectedList),
            ),
          ],
        ),
        bottomNavigationBar: new TabBar(
          tabs: [
            Tab(
              icon: new Icon(Icons.timer),
            ),
            Tab(
              icon: new Icon(Icons.motorcycle),
            ),
            Tab(
              icon: new Icon(Icons.done),
            ),
            Tab(icon: new Icon(Icons.close),
            )
          ],
          labelColor: Color(int.parse(Global.secondaryColor)),
          unselectedLabelColor: Colors.blue,
          indicatorSize: TabBarIndicatorSize.label,
          indicatorPadding: EdgeInsets.all(5.0),
          indicatorColor: Color(int.parse(Global.primaryColor)),
        ),

      ),
    );

  }
  allRequests(IconData icon,String title,List<Request> listItem) {


    return   ListView.builder(
      padding: EdgeInsets.all(20),
      itemCount: listItem.length,
      itemBuilder: (BuildContext context,int index){
        return Container(
          child:Padding(
              padding: const EdgeInsets.all(5.0),
              child: Container(
                child: Material(
                  color: Colors.white,
                  elevation: 8.0,
                  borderRadius: BorderRadius.circular(30.0),
                  shadowColor: Color(int.parse(Global.primaryColor)),
                  child: Column(

                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          child: Padding(
                            padding: const EdgeInsets.all(0.0),
                            child: Text(listItem[index].request_date.toString(), style: TextStyle(
                                fontFamily: Global.fontFamily,
                                fontWeight: FontWeight.w600,
                                fontSize: 17,
                                color: Color(int.parse(Global.primaryColor))
                            )),
                          ),
                        ),
                        Container(
                          child: Padding(
                            padding: const EdgeInsets.all(0.0),
                            child: Text(listItem[index].request_time.toString()  +"الوقت ", style: TextStyle(
                                fontFamily: Global.fontFamily,
                                fontWeight: FontWeight.w600,
                                fontSize: 15,
                                color: Color(int.parse(Global.primaryColor))
                            )),
                          ),
                        ),
                        Container(
                          child: Padding(
                            padding: const EdgeInsets.all(0.0),
                            child: Text(listItem[index].details, style: TextStyle(
                                fontFamily: Global.fontFamily,
                                fontWeight: FontWeight.w600,
                                fontSize: 15,
                                color: Color(int.parse(Global.primaryColor))
                            )),
                          ),
                        ),
                       if (listItem[index].state==0)
                          RaisedButton(
                            onPressed: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) =>ShopRequestInfromation(request: listItem[index])
                              ));

                            },
                            elevation: 2.0,
                            color: Color(int.parse(Global.primaryColor)),
                            textColor: Colors.white,
                            padding:   EdgeInsets.all(0.0),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            child: Container(
                              padding:   EdgeInsets.all(10.0),
                              child:   Text(
                                  "تفاصيل الطلب",
                                  style: TextStyle(
                                      fontFamily: Global.fontFamily,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 15,

                                  )
                              ),
                            )
                        ),
                      ]
                  ),
                ),)),
        );
      },
    );
  }

  Future getAllRequests() {
    return  Future.delayed(const Duration(seconds: 5), () {
      Request.getShopRequests().then((value)
        {
          setState(() {
            if(value.length!=allCustomerRequest.length)
              {
                allCustomerRequest=value;

                arrangeRequestsWithState();
              }
          });
        }
        );

    });
  }
  void arrangeRequestsWithState()
  {
    waitingList.clear();
    processingList.clear();
    deliveredList.clear();
    rejectedList.clear();
    for(int i=0;i<allCustomerRequest.length;i++)
      {
        if(allCustomerRequest[i].state==0)
           waitingList.add(allCustomerRequest[i]);
        else if(allCustomerRequest[i].state==1)
          processingList.add(allCustomerRequest[i]);
        else if(allCustomerRequest[i].state==2)
          deliveredList.add(allCustomerRequest[i]);
        else
          rejectedList.add(allCustomerRequest[i]);
      }
  }
  Future<void>  choiceAction(String choices) async {

    if(choices.contains('تسجيل الخروج')){
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.remove('phone');
      prefs.remove('map_Appear');
      prefs.remove('id');
      prefs.remove('password');
      prefs.remove('userName');
      prefs.remove('latitude');
      prefs.remove('longitude');


      Navigator.of(context).pushAndRemoveUntil(  MaterialPageRoute(
          builder: (context) =>SignUp()
      ),ModalRoute.withName("/Home"));
    }

  }

  //Alert Dialog
  /*
  showAlertDialog(BuildContext context,int index) {

    // set up the buttons
    Widget cancelButton = RaisedButton(
      elevation: 2.0,
      color: Color(int.parse("0xffFF6C6C")),
      textColor: Colors.white,
      padding:   EdgeInsets.all(10.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: Text("لا اوافق" ,style: TextStyle(
        fontFamily: Global.fontFamily,
        fontWeight: FontWeight.w600,
        fontSize: 14,
        color: Colors.white
      ),),
      onPressed:  () {


      },
    );
    Widget continueButton = RaisedButton(
      elevation: 2.0,
      color: Colors.lightGreen,
      textColor: Colors.white,
      padding:   EdgeInsets.all(10.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
       ),
      child: Text("تنفيذ الطلب" ,style: TextStyle(
          fontFamily: Global.fontFamily,
          fontWeight: FontWeight.w600,
          fontSize: 14,
          color: Colors.white
      )),
      onPressed:  () {


      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text(waitingList[index].request_time , style: TextStyle(
          fontFamily: Global.fontFamily,
          fontWeight: FontWeight.w600,
          fontSize: 15,
          color: Color(int.parse(Global.primaryColor))
      )),
      content:Text(waitingList[index].details, style: TextStyle(
          fontFamily: Global.fontFamily,
          fontWeight: FontWeight.w600,
          fontSize: 15,
          color: Color(int.parse(Global.primaryColor))
      ) ),
      actions: [
        cancelButton,
        continueButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  } */

}