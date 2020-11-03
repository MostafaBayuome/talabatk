import 'dart:async';
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
  String _title="Shop Home Page";

  @override
  Widget build(BuildContext context) {

    getNotifications();
    return  Scaffold (
        appBar: Utils.appBarusers(context,_title),
        body: Center(
          child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Utils.title(120, 120),
                SizedBox(height: 150),
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
                            child: Text( 'اضافه طيار',style: TextStyle(
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
                          Icon(Icons.add_circle,size:30.0)

                        ],
                      )

                  ),
                ),
                 SizedBox(height: 40),
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
                            child: Text(   'عرض جميع الطيارين',style: TextStyle(
                                fontSize: 12,
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
                          Icon(Icons.list,size:30.0)

                        ],
                      )

                  ),
                ),
                 SizedBox(height: 40),
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
                            child: Text(  'تنفيذ الطلبات',style: TextStyle(
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
                          Icon(Icons.arrow_forward,size:30.0)

                        ],
                      )
                  ),
                ),



              ]
          ),
        )


    );

  }



  Future getNotifications(){
    return new  Future.delayed( const Duration(seconds:10) , ()
    {
      NotificationDetails.getMyNotification().then((value) {
        if(value!=null){
          Global.userNotifications.clear();
          setState(() {
            Global.userNotifications=value ;
            //  String jsonString = jsonEncode(Global.userNotifications.map((i) => i.toJson()).toList()).toString();
            //  print(jsonString);
            //  Global.prefs.setString("userNotification", jsonString);
          });
        }
      });
    });
  }


}