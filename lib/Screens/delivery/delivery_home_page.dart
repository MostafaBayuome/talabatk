import 'dart:async';
import 'package:Talabatk/Entities/delivery_location.dart';
import 'package:Talabatk/Entities/global.dart';
import 'package:Talabatk/Entities/location.dart';
import 'package:Talabatk/Entities/notification_details.dart';
import 'package:Talabatk/Entities/request.dart';
import 'package:Talabatk/Widgets/utils.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';



class DeliveryHomePage extends StatefulWidget {
  @override
  _DeliveryHomePageState createState() => _DeliveryHomePageState();
}

class _DeliveryHomePageState extends State<DeliveryHomePage> {

  String _title="الصفحه الرئيسيه";
  List<Request> allCustomerRequest=[];
  List<Request> processingList=[];
  List<Request> deliveredList=[];
  Position position=null;
  Timer request_timer;
  @override
  void initState() {
    super.initState();
    getCurrentLocation();
    getNotifications();
    getAllRequests();
  }
  @override
  void dispose() {
    Global.notification_timer?.cancel();
    Global.location_timer?.cancel();
    request_timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: Utils.appBarusers(context, _title),
        body:  TabBarView(
          children: [
            new Container(
              child: allRequests(Icons.motorcycle,'Processing',processingList),
            ),
            new Container(
              child: allRequests(Icons.done,'Delevired',deliveredList),
            ),
          ],
        ),
        bottomNavigationBar: new TabBar(
          tabs: [
            Tab(
              icon: new Icon(Icons.motorcycle),
            ),
            Tab(
              icon: new Icon(Icons.done),
            ),
          ],
          labelColor: Color(int.parse(Global.secondaryColor)),
          unselectedLabelColor: Colors.blue,
          indicatorSize: TabBarIndicatorSize.label,
          indicatorPadding: EdgeInsets.all(5.0),
          indicatorColor: Color(int.parse(Global.primaryColor)),
        )
      ),
    );
  }

  allRequests(IconData icon,String title,List<Request> listItem) {

    return  ListView.builder(
      padding: EdgeInsets.all(20),
      itemCount: listItem.length,
      itemBuilder: (BuildContext context,int index){
        return Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          child:  Container(
            width :MediaQuery.of(context).size.width,
            padding :EdgeInsets.symmetric(horizontal: 10.0,vertical: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                  width: 55.0,
                  height: 55.0,
                  child: CircleAvatar(
                    backgroundColor: Colors.white,
                    child: Utils.title(55,55),
                  ),
                ),
                SizedBox(width: 8.0),
                Column(

                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        child: Text(  listItem[index].user_name,textAlign: TextAlign.center, style: TextStyle(
                          fontFamily: Global.fontFamily,
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                        )),
                      ),
                      Container(
                        child: Text( "Request ID: "+ listItem[index].id.toString() ,textAlign: TextAlign.center, style: TextStyle(
                          fontFamily: Global.fontFamily,
                          fontSize: 13,
                        )),
                      ),
                      SizedBox(height: 3,),
                      Container(
                        child: Text(listItem[index].request_date.toString(),
                            style: TextStyle(
                              fontSize: 13,
                              color: Colors.black,
                            )),
                      ),
                      Container(
                        child: Padding(
                          padding: const EdgeInsets.all(0.0),
                          child: Text(listItem[index].request_time.toString()  +"الوقت ", style: TextStyle(
                            fontFamily: Global.fontFamily,
                            fontSize: 12,
                          )),
                        ),
                      ),
                      SizedBox(height : 5),]
                ),
                /*
                if(listItem[index].state == 1)
                  Container(
                      width: 30.0,
                      height: 30.0,
                      alignment: Alignment.center,
                      padding: EdgeInsets.symmetric(horizontal: 3.0,vertical: 3.0),
                      child: InkWell(
                        onTap: () {
                          //Send User to chat page
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) =>ChatPage( request: listItem[index] )
                          ));
                        }, // button pressed
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Icon(Icons.chat,color: Colors.blue), // icon
                          ],
                        ),
                      )),
                */
                if(listItem[index].state == 1)
                  Container(
                    width: 30.0,
                    height: 30.0,
                    alignment: Alignment.center,
                    padding: EdgeInsets.symmetric(horizontal: 3.0,vertical: 3.0),
                    child: InkWell(

                      onTap: () {
                        //Send delivery_man to googlemaps
                        Location.GetLocationsById(listItem[index].location_id).then((value) async {
                          double lat = value.latitude;
                          double long = value.longitude;
                          Utils.openMap(lat,long);
                        });

                      }, // button pressed
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Icon(Icons.gps_fixed,color:  Color(int.parse(Global.secondaryColor))), // icon
                        ],
                      ),
                    )),
                if(listItem[index].state == 1)
                  Container(
                      width: 25.0,
                      height: 30.0,
                      alignment: Alignment.center,
                      padding: EdgeInsets.symmetric(horizontal: 3.0,vertical: 3.0),
                      child: InkWell(
                        onTap: () {
                          Request.editRequest(listItem[index], 2).then((value) {
                            Utils.toastMessage("تم تاكيد توصيل الطلب");
                          });
                        }, // button pressed
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Icon(Icons.done,color:  Colors.green), // icon
                          ],
                        ),
                      )
                  ),
              ],
            ),),
        );
      },
    );
  }

  Future getAllRequests() {

    request_timer = Timer.periodic(Duration(seconds: 10), (Timer t) async {
      Request.getRequestsAttachedToDeliveryMan().then((value)
      {
        setState(() {
          allCustomerRequest=value;
          arrangeRequestsWithState();
        });
      }
      );
    });


  }
  // 1 on delivery, 2 delivered
  void arrangeRequestsWithState() {

    processingList.clear();
    deliveredList.clear();

    for(int i=0;i<allCustomerRequest.length;i++)
    {
      setState(() {
        if(allCustomerRequest[i].state==1)
          processingList.add(allCustomerRequest[i]);
        else if(allCustomerRequest[i].state==2)
          deliveredList.add(allCustomerRequest[i]);
      });

    }
  }

  Future getNotifications(){

    Global.notification_timer = Timer.periodic(Duration(seconds: 10), (Timer t) async {
      NotificationDetails.getMyNotification().then((value) {
        if(value!=null){
          Global.userNotifications.clear();
          setState(() {
            Global.userNotifications=value ;
          });
        }
      });
    });

  }

  Future getCurrentLocation(){


     Global.location_timer = Timer.periodic(Duration(seconds: 60), (Timer t) async {
      try{
        position =  await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
        DeliveryLocation.addCurrentLocation(Global.loginUser.id,position);
      }on Exception{
        print(Exception);
      }
    });

  }


}
