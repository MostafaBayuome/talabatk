import 'package:Talabatk/Screens/delivery/delivery_home_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Entities/global.dart';
import 'Entities/user.dart';
import 'Screens/app_info.dart';
import 'Screens/customer/customer_home_page.dart';
import 'Screens/shop/shop_home_page.dart';
import 'Screens/signup.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
Future<void> main()  async {
   WidgetsFlutterBinding.ensureInitialized();
   sendNotification();
    Global.prefs =await SharedPreferences.getInstance();


  // if mobileNumber and check not null then it will redirect to the correct homepage
   var FirstEnter=Global.prefs.getInt('FirstEnter');

   var phone=Global.prefs.getString('phone');
   var map_Appear=Global.prefs.getInt('map_Appear');
   var user_id=Global.prefs.getInt('id');
   var password = Global.prefs.getString('password');
   var user_name=Global.prefs.getString('userName');
   var latitude=Global.prefs.getDouble('latitude');
   var longitude=Global.prefs.getDouble('longitude');
   var merchant_id=Global.prefs.getInt('merchant_id');

   if(phone!=null)
     {
       User user =new User(user_id,phone,latitude,longitude,user_name,password,map_Appear,merchant_id);
       Global.loginUser=user;
     }
    runApp(
      MaterialApp(
        debugShowCheckedModeBanner: false,
          home:FirstEnter==null? app_info(): phone ==null ? SignUp() : (map_Appear == 1 || map_Appear == 2) ? ShopHomePage() : (map_Appear!=9) ? CustomerHomePage() : DeliveryHomePage(),
      )
   );



}


void sendNotification() async {
  try{
    await _demoNotification();
  }catch(e){
    String ee=e.toString();
    print(ee);
  }

}

Future<void> _demoNotification() async {
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  new FlutterLocalNotificationsPlugin();
  var initializationSettingsAndroid;
  var initializationSettingsIOS;
  var initializationSettings;
  var androidPlatformChannelSpecifics = AndroidNotificationDetails(
      '1', 'Channel Name', 'desc',
      importance: Importance.Max,
      priority: Priority.High,
      ticker: 'test ticker',);

  var iOSChannelSpecifics = IOSNotificationDetails();
  var platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics, iOS: iOSChannelSpecifics);

  await flutterLocalNotificationsPlugin.show(1, 'Hello, buddy',
      'A message from flutter buddy', platformChannelSpecifics,
      payload: 'test oayload');
}
Future onDidReceiveLocalNotification(
    int id, String title, String body, String payload) async {

      String ss=body;
}