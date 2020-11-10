import 'dart:ui';
import 'package:Talabatk/Entities/rate.dart';
import 'package:Talabatk/Entities/delivery_location.dart';
import 'package:Talabatk/Entities/location.dart';
import 'package:Talabatk/Entities/request.dart';
import 'package:Talabatk/Screens/chat_page.dart';
import 'package:Talabatk/Widgets/alert_dailog.dart';
import 'package:Talabatk/Screens/gmap_delivery.dart';
import 'package:Talabatk/Widgets/utils.dart';
import 'package:flutter/material.dart';
import 'package:Talabatk/Entities/global.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';


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
  String _title="طلباتي";
  String selectedRate="اختر تقييم";

  int count=0;
  @override
  Widget build(BuildContext context) {


    currContext=context;
    getAllRequests();
   if(Global.rateList.length==0) Rate.getRates().then((value) => {
      Global.rateList=value
    });
    return DefaultTabController(
      length: 4,
      child: new Scaffold(
        appBar: Utils.appBarusers(context,_title),
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
        return Card(
          elevation: 5.0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Container(
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
                      child: Text(listItem[index].user_name , textAlign: TextAlign.center, style: TextStyle(
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
                            fontFamily: Global.fontFamily,

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


                    SizedBox(height : 5),
                  ]
              ),
              if(listItem[index].state == 0 || listItem[index].state == 1)
                Container(
                    width: 70.0,
                    height: 70.0,
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
                    ))
              else if (listItem[index].state == 2)
                Container(
                    width: 70.0,
                    height: 70.0,
                    alignment: Alignment.center,

                    padding: EdgeInsets.symmetric(horizontal: 3.0,vertical: 3.0),

                    child: InkWell(

                      onTap: () {
                        Global.selectedRequestID=listItem[index].id;
                        //Send User to chat page
                        showDialog(
                          context: context,
                          builder: (context) {

                            return StatefulBuilder(
                              builder: (context, setState) {
                                return MyDailog();
                              },
                            );
                          },
                        );


                      }, // button pressed
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Image.asset('images/feedback.png'), // icon

                        ],
                      ),
                    )),
              if(listItem[index].state == 1)
                Container(
                    width: 30.0,
                    height: 30.0,
                    alignment: Alignment.center,

                    padding: EdgeInsets.symmetric(horizontal: 3.0,vertical: 3.0),

                    child: InkWell(

                      onTap: () {
                        //get last location of delivery plus location of customer to deliver

                        DeliveryLocation.getByIdLastLocation(listItem[index].delivery_id).then((value) {
                          LatLng deliveryPosition = new LatLng(value.latitude,  value.longitude);
                          Location.GetLocationsById(listItem[index].location_id).then((value) {
                            LatLng customerPosition = new LatLng(value.latitude,  value.longitude);
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) =>GmapDelivery( deliveryPosition: deliveryPosition , request:listItem[index] ,customerPosition: customerPosition)
                            ));
                          });

                        });
                      }, // button pressed
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Icon(Icons.location_on,color:  Color(int.parse(Global.secondaryColor))), // icon
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

  void arrangeRequestsWithState() {
    waitingList.clear();
    processingList.clear();
    deliveredList.clear();
    rejectedList.clear();
    for(int i=0;i<allCustomerRequest.length;i++)
    {
      setState(() {

        if(allCustomerRequest[i].state==0)
          waitingList.add(allCustomerRequest[i]);
        else if(allCustomerRequest[i].state==1)
          processingList.add(allCustomerRequest[i]);
        else if(allCustomerRequest[i].state==2)
          deliveredList.add(allCustomerRequest[i]);
        else
          rejectedList.add(allCustomerRequest[i]);
      });
    }

  }


}
