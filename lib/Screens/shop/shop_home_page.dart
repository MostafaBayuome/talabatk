import 'dart:async';
import 'package:Talabatk/Entities/app_localizations.dart';
import 'package:Talabatk/Entities/notification_details.dart';
import 'package:Talabatk/Entities/global.dart';
import 'package:Talabatk/Screens/shop/add_delivery.dart';
import 'package:Talabatk/Screens/shop/shop_request_layout.dart';
import 'package:Talabatk/Widgets/utils.dart';
import 'package:flutter/material.dart';
import 'display_all_delivery_men.dart';
class ShopHomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _State();
}

class _State extends State<ShopHomePage>{

  @override
  void initState() {
    super.initState();
    getNotifications();
  }

  @override
  void dispose() {
    Global.notification_timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String _title= AppLocalizations.of(context).translate('home_page');
    return  Scaffold (
        appBar: Utils.appBarusers(context,_title),
        body: Center(
          child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[

                Expanded(flex: 2,
                  child: Row(
                    children: [
                      Expanded(child: Container(),flex: 3),

                      Expanded(child: Utils.title(120, 120),flex:3),

                      Expanded(child: Container(),flex:3)

                    ],
                  ),
                ),
                Expanded(flex:1,child: Container()),
                Expanded(flex: 3,child: Column(
                  children: [

                    InkWell(
                      onTap: (){
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) =>addDeliveryman()
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
                                child: Center(
                                  child:Text( AppLocalizations.of(context).translate('add_delivery'),style: TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w800,
                                      color: Colors.white
                                  ),),
                                ),
                                decoration: BoxDecoration (
                                    color:Color(int.parse(Global.secondaryColor)),
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(98.0),
                                        bottomRight: Radius.circular(200)
                                    )
                                ),
                              ),
                              Icon(Icons.add_circle,size:30.0)
                            ],
                          )

                      ),
                    ),

                    SizedBox(height: 30),
                    InkWell(
                      onTap: (){
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) =>DisplayAllDeliveryMen()
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
                                padding: EdgeInsets.symmetric(vertical:14.0,horizontal: 5.0 ),
                                height: 50,
                                width: 110.0,
                                child: Center(
                                  child: Text(  AppLocalizations.of(context).translate('show_all_delivery_men'),style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w800,
                                      color: Colors.white
                                  ),),
                                ),
                                decoration: BoxDecoration (
                                    color:Color(int.parse(Global.secondaryColor)),
                                    borderRadius: BorderRadius.only(

                                        topLeft: Radius.circular(98.0),
                                        bottomRight: Radius.circular(200)
                                    )
                                ),
                              ),
                              Icon(Icons.list,size:30.0)

                            ],
                          )

                      ),
                    ),

                    SizedBox(height: 30),
                    InkWell(
                      onTap: (){
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => ShopRequestLayout()
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
                                padding: EdgeInsets.symmetric(vertical:12.0,horizontal: 15.0 ),
                                height: 50,
                                width: 110.0,
                                child: Center(
                                  child: Text( AppLocalizations.of(context).translate('orders'),style: TextStyle(
                                      fontSize: 11,
                                      fontWeight: FontWeight.w800,
                                      color: Colors.white
                                  ),),
                                ),
                                decoration: BoxDecoration (
                                    color:Color(int.parse(Global.secondaryColor)),
                                    borderRadius: BorderRadius.only(

                                        topLeft: Radius.circular(98.0),
                                        bottomRight: Radius.circular(200)
                                    )
                                ),
                              ),
                              Icon(Icons.arrow_forward,size:30.0)

                            ],
                          )
                      ),
                    ),
                  ],
                ),)

              ]
          ),
        )
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