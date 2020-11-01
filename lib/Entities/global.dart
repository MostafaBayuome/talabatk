import 'dart:async';

import 'package:Talabatk/Entities/notifications.dart';
import 'package:Talabatk/Entities/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class  Global {
static SharedPreferences prefs ;
  static User loginUser = new User.empty();
  static String appName='Talabatk' ;
  static String fontFamily='NotoSansJP';
  static String primaryColor='0xff27bdef';   //Cloudy
  static String secondaryColor='0xffe85c9b';   //pink
  static String url="http://talabatk.maxsystem-eg.com/api/";
  static bool visible_progress=false;
  static int userLocationIdDeliever;
  static User selectedDeleviry;
  static Timer notification_timer;
  static List<Notifications>userNotifications=new List<Notifications>();
}


