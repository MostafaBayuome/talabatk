import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';



class LocalNotificationState   {
   FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  AndroidInitializationSettings androidInitializationSettings;
  IOSInitializationSettings iosInitializationSettings;
  InitializationSettings initializationSettings;

    String title;
    String body;
    int id;


    LocalNotificationState(this.title, this.body, this.id);

  @override
  void initState() {
    initializing();
  }
  void initializing() async {
    androidInitializationSettings = AndroidInitializationSettings('');
    iosInitializationSettings = IOSInitializationSettings(onDidReceiveLocalNotification: onDidReceiveLocalNotification);
    initializationSettings = InitializationSettings(  androidInitializationSettings,  iosInitializationSettings);
    await flutterLocalNotificationsPlugin.initialize(initializationSettings,onSelectNotification: onSelectNotification);
  }

    void showNotification() async{
    await notification();
  }

    Future<void> notification() async {
    AndroidNotificationDetails androidNotificationDetails =AndroidNotificationDetails(
        "Channel _ID",
        "Channel title",
        "Channel body",
        priority: Priority.High,
        importance: Importance.Max,
        ticker: 'test');
    IOSNotificationDetails iosNotificationDetails = IOSNotificationDetails();
    NotificationDetails notificationDetails=NotificationDetails(  androidNotificationDetails,  iosNotificationDetails);
    await flutterLocalNotificationsPlugin.show(id, title, body, notificationDetails);

  }

  Future onSelectNotification(String payloud){
    if(payloud!=null)
      print(payloud);
    //we can set navigator to navigate to another screen
  }
  Future onDidReceiveLocalNotification(int id,String title, String body, String paylouad)async {
    return CupertinoAlertDialog(
      title: Text(title),
      content: Text(body),
      actions: [
        CupertinoDialogAction(
            isDefaultAction: true,
            onPressed: (){
              print("");
            },
            child: Text("Okay")
        )
      ],
    );

  }
}
