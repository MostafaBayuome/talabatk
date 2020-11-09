import 'dart:async';
import 'package:Talabatk/Entities/Rate.dart';
import 'package:Talabatk/Entities/notification_details.dart';
import 'package:Talabatk/Widgets/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:Talabatk/Entities/global.dart';
import 'package:Talabatk/Screens/customer/customer_requests_layout.dart';
import 'gmap.dart';
import 'customer_location_editor.dart';
import 'package:Talabatk/Entities/location.dart';


class CustomerHomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _State();
}


class _State extends State<CustomerHomePage> {
  bool opened=true;
  List<Location> Locations =[];


  @override
  void initState() {

    super.initState();
    getNotifications();
    Rate.getRates();

  }

  @override
  void dispose() {
    Global.notification_timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {


   String _title="الصفحه الرئيسيه";
    return Scaffold (
        appBar: Utils.appBarusers(context,_title),
        body: customerMenuWidget()

    );
  }

  Widget customerMenuWidget() {
    return Center(

      child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Utils.title(120, 120),
             SizedBox(height: 150),
            InkWell(
              onTap: (){
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => LocationEditor()
                ));
              },
              child: Container(

                  width: 150,
                  decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                            offset: Offset(0.0,20.0),
                            blurRadius: 30.0,
                            color: Colors.black12
                        )
                      ],
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(22.0)
                  ),
                  child:Row(
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(vertical:10.0,horizontal: 3.0 ),
                        height: 50,
                        width: 110.0,
                        child: Text('اضافه موقع جديد',style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w800,
                            color: Colors.white
                        ),),
                        decoration: BoxDecoration (
                            color:Color(int.parse(Global.secondaryColor)),
                            borderRadius: BorderRadius.only(

                                topLeft: Radius.circular(98.0),
                                bottomRight: Radius.circular(200)
                            )
                        ),
                      ),
                      Icon(Icons.location_on,size:30.0)

                    ],
                  )

              ),
            ),
             SizedBox(height: 40),
            InkWell(
              onTap: (){
                // get all location of user display it after user choose  redirect to gmap with exact latlng
                Location.getByIdLocation("Location/GetByIdLocation").then((value) {
                  Locations=value;
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text(' مكان التوصيل',
                            style : TextStyle(
                                color: Color(int.parse(Global.primaryColor)),
                                fontFamily: Global.fontFamily,
                                fontWeight: FontWeight.w700,
                                fontSize: 20),
                            textAlign: TextAlign.center,
                          ),
                          content: setupAlertDialogContainer(),
                        );});

                });
              },
              child: Container(
                  width: 150,
                  decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                            offset: Offset(0.0,20.0),
                            blurRadius: 30.0,
                            color: Colors.black12
                        )
                      ],
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(22.0)
                  ),
                  child:Row(
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(vertical:10.0,horizontal: 20.0 ),
                        height: 50,
                        width: 110.0,
                        child: Text('لطلب اوردر',style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w800,
                            color: Colors.white
                        ),),
                        decoration: BoxDecoration (
                            color:Color(int.parse(Global.secondaryColor)),
                            borderRadius: BorderRadius.only(

                                topLeft: Radius.circular(98.0),
                                bottomRight: Radius.circular(200)
                            )
                        ),
                      ),
                      Icon(Icons.home,size:30.0)

                    ],
                  )

              ),
            ),
             SizedBox(height: 40),
            InkWell(
              onTap: (){
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => CustomerRequestLayout()
                ));
              },
              child: Container(
                  width: 150,
                  decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                            offset: Offset(0.0,20.0),
                            blurRadius: 30.0,
                            color: Colors.black12
                        )
                      ],
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(22.0)
                  ),
                  child:Row(
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(vertical:10.0,horizontal: 20.0 ),
                        height: 50,
                        width: 110.0,
                        child: Text(' طلباتي',style: TextStyle(
                          fontSize: 18,
                            fontWeight: FontWeight.w800,
                          color: Colors.white
                        ),),
                        decoration: BoxDecoration (
                            color:Color(int.parse(Global.secondaryColor)),
                            borderRadius: BorderRadius.only(

                                topLeft: Radius.circular(98.0),
                                bottomRight: Radius.circular(200)
                            )
                        ),
                      ),
                      Icon(Icons.shopping_cart,size:30.0)

                    ],
                  )

              ),
            ),
          ]
      ),
    );
  }

  Widget setupAlertDialogContainer() {
    return Container(
      height: 200.0,
      width: 200.0,
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: Locations.length,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            onTap: () {
              LatLng latlng = new LatLng( Locations[index].latitude,  Locations[index].longitude);
              Global.userLocationIdDeliever=Locations[index].id;
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => Gmap(currentPosition : latlng),
              ));
            },
            title:Text(Locations[index].title.toString(),textAlign: TextAlign.center,
              style: TextStyle(fontSize: 15,
                fontFamily: Global.fontFamily,
                fontWeight: FontWeight.w400,), ),
          );
        },
      ),
    );
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

  }