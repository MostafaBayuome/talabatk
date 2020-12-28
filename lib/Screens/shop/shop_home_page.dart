import 'dart:async';
import 'package:Talabatk/Entities/app_localizations.dart';
import 'package:Talabatk/Entities/notification_details.dart';
import 'package:Talabatk/Entities/global.dart';
import 'package:Talabatk/Screens/shop/add_delivery.dart';
import 'package:Talabatk/Screens/shop/add_offer.dart';
import 'package:Talabatk/Screens/shop/all_offers.dart';
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
                Expanded(
                  flex:1,
                  child:Padding(
                    padding: EdgeInsets.all(50.0),
                    child: Divider(thickness: 1,),
                ),),
                Expanded(

                  flex: 4,
                  child: Column(
                   children: [
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
                    SizedBox(height: 20),
                    InkWell(
                      onTap: (){
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) =>AddDeliveryman()
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
                    SizedBox(height: 20),
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
                              Icon(Icons.list,size:30.0)

                            ],
                          )

                      ),
                    ),
                    SizedBox(height: 40),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        InkWell(
                          onTap: (){
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) =>AddOffer()
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
                                      child:Text( AppLocalizations.of(context).translate('add_new_offer'),style: TextStyle(
                                          fontSize: 10,
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
                                  Icon(Icons.arrow_forward_ios,size:25.0)
                                ],
                              )

                          ),
                        ),
                        SizedBox(width: 12),
                        FlatButton(
                          child: Text(AppLocalizations.of(context).translate('all_my_offers'),
                            style: TextStyle(
                              fontSize: 10,
                              fontFamily: Global.fontFamily,
                              fontWeight: FontWeight.bold,
                          ),),
                          onPressed:() {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => AllOffers()
                            ));
                          },
                        ),
                      ],
                    )

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