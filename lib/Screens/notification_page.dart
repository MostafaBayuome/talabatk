import 'dart:async';
import 'package:Talabatk/Entities/app_localizations.dart';
import 'package:Talabatk/Entities/global.dart';
import 'package:Talabatk/Entities/notification_details.dart';
import 'package:Talabatk/Screens/customer/customer_requests_layout.dart';
import 'package:Talabatk/Screens/delivery/delivery_home_page.dart';
import 'package:Talabatk/Screens/shop/shop_request_layout.dart';
import 'package:Talabatk/Widgets/utils.dart';
import 'package:flutter/material.dart';

class Notification_Page extends StatefulWidget {

  @override
  _State createState() => _State();

}
class _State extends State<Notification_Page> {
  List<NotificationDetails> notifications = [];
  Timer request_timer;
  @override
  Widget build(BuildContext context) {
    String _notification=AppLocalizations.of(context).translate('notification');
    return Scaffold(
        appBar: Utils.appBarusers(context, _notification),
        body: FutureBuilder(
          future: NotificationDetails.getMyNotification(),
          builder:(BuildContext context,AsyncSnapshot snapshot){
            if(snapshot.data == null) {
              return Container(
                child: Center(
                  child: Container(
                    child: Text(AppLocalizations.of(context).translate('no_notification_here'),style: TextStyle(
                      fontFamily: Global.fontFamily,
                      fontWeight: FontWeight.w300,
                      fontSize: 20,
                      color: Color(int.parse(Global.primaryColor)),
                     ),
                    ),
                  ),
                ),
              );
            }
            else{
              notifications = snapshot.data;
              edit_all_notification();
              return ListView.builder(
                itemCount: notifications.length,
                itemBuilder: (BuildContext context,int index){
                  return Padding(
                      padding: EdgeInsets.all(15),
                      child:   Card(
                        elevation: 5.0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: InkWell(
                          onTap: () {
                            // send to page plus remove notification
                              if(notifications[index].type=="request")
                                {
                                  NotificationDetails.editNotification(notifications[index]).then((value) {
                                  setState(() {
                                    notifications.removeAt(index);
                                   Global.userNotifications=notifications;
                                });
                                Navigator.of(context).pop();
                                if(Global.loginUser.mapAppear == 1 || Global.loginUser.mapAppear == 2){
                                Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) =>ShopRequestLayout()
                                ));
                                }
                                else if(Global.loginUser.mapAppear == 0) {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) =>CustomerRequestLayout()
                                  ));
                                }
                                else {
                                Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) =>DeliveryHomePage()
                                ));
                                }});

                                }
                          },
                          child: Row (
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Expanded(
                                flex: 4,
                                child: Padding(
                                  padding: EdgeInsets.all(20),
                                  child: Column(
                                    children: [
                                      Container(
                                        width: 55.0,
                                        height: 55.0,
                                        child: CircleAvatar(
                                          backgroundColor: Colors.white,
                                          child: Utils.title(55,55),
                                        ),
                                      ),
                                      SizedBox(height: 10.0),
                                      Text(
                                          notifications[index].description,
                                          style: TextStyle(
                                            fontFamily: Global.fontFamily,
                                            fontWeight: FontWeight.w500,
                                            fontSize: 13,

                                          )
                                      ),
                                      Text(
                                          notifications[index].record_Date,
                                          style: TextStyle(
                                            fontFamily: Global.fontFamily,
                                            fontSize: 11,
                                          )
                                      ),
                                      Text(
                                          notifications[index].record_Time,
                                          style: TextStyle(
                                            fontFamily: Global.fontFamily,

                                            fontSize: 11,

                                          )
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                  );
                },
              );
            }
          },
        ),

    );
  }

  @override
  void dispose() {
    request_timer?.cancel();
    super.dispose();
  }

  Future edit_all_notification() {

    request_timer = Timer.periodic(Duration(seconds: 10), (Timer t) async {
       for(int i =0;i<notifications.length;i++){
         NotificationDetails.editNotification(notifications[i]).then((value) {
           setState(() {
             notifications.removeAt(i);
             Global.userNotifications=notifications;
           });
         });
       }
    });

  }
}