import 'dart:async';
import 'package:Talabatk/Entities/Notifications.dart';
import 'package:Talabatk/Entities/global.dart';
import 'package:Talabatk/Screens/shop/add_delivery.dart';
import 'package:Talabatk/Screens/shop/shop_request_layout.dart';
import 'package:Talabatk/Widgets/utils.dart';
import 'package:flutter/material.dart';
import 'display_all_delivery_men.dart';

class ShopHomePage extends StatefulWidget {
  static const reprat_time = const Duration(seconds:20);
  var timer=new Timer.periodic(reprat_time, (Timer t) => Notifications.getMyNotification());
  @override
  State<StatefulWidget> createState() => _State();

}

class _State extends State<ShopHomePage>{
  String _title="الصفحه الرئيسيه";
  @override
  Widget build(BuildContext context) {


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






}