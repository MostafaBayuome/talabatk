import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:talabatk_flutter/Entities/constants.dart';
import 'package:talabatk_flutter/Entities/global.dart';
import 'package:talabatk_flutter/Entities/request.dart';
import 'file:///C:/Users/Etch/OneDrive/Desktop/WORK/Talbatk/Talabatk-GitHub/lib/Screens/shop/shop_request_information.dart';
import '../signup.dart';



class ShopHomePage extends StatefulWidget {

  @override
  State<StatefulWidget> createState() => _State();

}

class _State extends State<ShopHomePage>{

  BuildContext currContext=null;
  List<Request> customerRequest=[];

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
              child: WaitedRequests(Icons.timer,'Waited'),
            ),
            new Container(
              child: WaitedRequests(Icons.motorcycle,'Processing'),
            ),
            new Container(
              child: WaitedRequests(Icons.done,'Delevired',
              ),
            ),
            new Container(
              child: WaitedRequests(Icons.close,'Rejected'),
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
  WaitedRequests(IconData icon,String title) {

    return   ListView.builder(
      padding: EdgeInsets.all(20),
      itemCount: waitingList.length,
      itemBuilder: (BuildContext context,int index){
        return ListTile(
          title:Center(
              child: Container(
                child: Material(
                  color: Colors.white,
                  elevation: 8.0,
                  borderRadius: BorderRadius.circular(24.0),
                  shadowColor: Color(int.parse(Global.primaryColor)),
                  child: Column(

                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(waitingList[index].request_date.toString(), style: TextStyle(
                                fontFamily: Global.fontFamily,
                                fontWeight: FontWeight.w600,
                                fontSize: 15,
                                color: Color(int.parse(Global.primaryColor))
                            )),
                          ),
                        ),
                        Container(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(waitingList[index].request_time.toString()  +"الوقت ", style: TextStyle(
                                fontFamily: Global.fontFamily,
                                fontWeight: FontWeight.w600,
                                fontSize: 15,
                                color: Color(int.parse(Global.primaryColor))
                            )),
                          ),
                        ),

                        Container(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(waitingList[index].details, style: TextStyle(
                                fontFamily: Global.fontFamily,
                                fontWeight: FontWeight.w600,
                                fontSize: 12,
                                color: Color(int.parse(Global.primaryColor))
                            )),
                          ),
                        ),
                        RaisedButton(
                            onPressed: () {

                            },
                            elevation: 2.0,
                            color: Color(int.parse(Global.primaryColor)),
                            textColor: Colors.white,
                            padding: const EdgeInsets.all(0.0),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            child: Container(
                              padding: const EdgeInsets.all(10.0),
                              child: const Text(
                                  "تفاصيل الطلب",
                                  style: TextStyle(fontSize: 15)
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
      Request.getCustomerRequests().then((value)
        {
          setState(() {
            if(value.length!=customerRequest.length)
              {
                customerRequest=value;
                arrangeRequestsWithState();
              }
          });
        }
        );

    });
  }
  void arrangeRequestsWithState()
  {
    for(int i=0;i<customerRequest.length;i++)
      {
        if(customerRequest[i].state==1)
           waitingList.add(customerRequest[i]);
        else if(customerRequest[i].state==2)
          processingList.add(customerRequest[i]);
        else if(customerRequest[i].state==3)
          deliveredList.add(customerRequest[i]);
        else
          rejectedList.add(customerRequest[i]);
      }
  }
  Future<void>  choiceAction(String choices) async {

    if(choices.contains('تسجيل الخروج')){
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.remove('FirstEnter');
      prefs.remove('phone');
      prefs.remove('map_Appear');
      prefs.remove('id');
      prefs.remove('password');
      prefs.remove('userName');
      prefs.remove('latitude');
      prefs.remove('longitude');


      Navigator.of(context).pop();
      Navigator.of(context).push(MaterialPageRoute(
          builder: (context) =>SignUp()
      ));
    }

  }

}