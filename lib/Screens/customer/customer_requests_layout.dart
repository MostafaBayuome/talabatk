import 'package:Talabatk/Entities/constants.dart';
import 'package:Talabatk/Entities/request.dart';
import 'package:Talabatk/Screens/chat_page.dart';
import 'package:Talabatk/Screens/signup.dart';
import 'package:flutter/material.dart';
import 'package:Talabatk/Entities/global.dart';
import 'package:Talabatk/Screens/customer/customer_request_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CustomerRequestLayout extends StatefulWidget{
  @override
  _State createState() => _State();
}

class _State extends State<CustomerRequestLayout>
{

  List<Request> allCustomerRequest=[];
  String title="الطلبات تحت التنفيذ";
  List<Request> waitingList=[];
  List<Request> processingList=[];
  List<Request> deliveredList=[];
  List<Request> rejectedList=[];
  BuildContext currContext=null;

  @override
  Widget build(BuildContext context) {
    currContext=context;
    getAllRequests();
    return DefaultTabController(
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
              child: allRequests(Icons.motorcycle,'Processing', processingList),
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
                            child: Text(listItem[index].id.toString(), style: TextStyle(
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
                            child: Text(listItem[index].request_date.toString(), style: TextStyle(
                                fontFamily: Global.fontFamily,
                                fontWeight: FontWeight.w600,
                                fontSize: 17,
                                color: Color(int.parse(Global.primaryColor))
                            )),
                          ),
                        ),
                        SizedBox(height: 10,),
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
                        if(listItem[index].state == 0 || listItem[index].state == 1)
                           Container(

                            child: Center(
                                child: SizedBox.fromSize(
                                  size: Size(60, 60), // button width and height
                                  child: ClipOval(
                                    child: Material(
                                      color:  Color(int.parse(Global.primaryColor)), // button color
                                      child: InkWell(
                                        splashColor: Color(int.parse(Global.secondaryColor)), // splash color
                                        onTap: () {
                                          //Send User to chat page
                                          Navigator.of(context).push(MaterialPageRoute(
                                              builder: (context) =>ChatPage()
                                          ));
                                        }, // button pressed
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: <Widget>[
                                            Icon(Icons.chat,color: Colors.white,), // icon
                                            Text("محادثه", style: TextStyle(
                                              color: Colors.white,
                                            )), // text
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                            )),
                        SizedBox(height : 5),

                      ]
                  ),
                ),)),
        );
      },
    );
  }
  Future getAllRequests() {
    return  Future.delayed(const Duration(seconds: 2), () {
      Request.getCustumerRequests().then((value)
      {
        setState(() {

          allCustomerRequest=value;
          arrangeRequestsWithState();

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

}
