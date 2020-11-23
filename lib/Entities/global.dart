import 'dart:async';
import 'package:Talabatk/Entities/notification_details.dart';
import 'package:Talabatk/Entities/user.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'app_localizations.dart';
import 'rate.dart';
class  Global {

static SharedPreferences prefs;
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
  static Timer chat_timer;
  static Timer location_timer;
  static Timer delivery_timer;
  static List<NotificationDetails> userNotifications =new List<NotificationDetails>();
  static String selectedRate="اختر تقييم";
  static int selectedRateID=0;
  static int selectedRequestID=0;
  static List<Rate> rateList=[];


  // appLanguage for changing application language
  static AppLanguage appLanguage = AppLanguage();

}


