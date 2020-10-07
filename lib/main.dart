import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:talabatk_flutter/screens/customer_home_page.dart';
import 'package:talabatk_flutter/screens/shop_home_page.dart';
import 'package:talabatk_flutter/screens/signup.dart';

import 'Screens/app_info.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs =await SharedPreferences.getInstance();


  // if mobileNumber and check not null then it will redirect to the correct homepage
  var FirstEnter=prefs.getString('FirstEnter');
  var phone=prefs.getString('phone');
  var map_Appear=prefs.getBool('map_Appear');
  var user_id=prefs.getInt('id');

  runApp(
      MaterialApp(
        debugShowCheckedModeBanner: false,
        home:FirstEnter==null? app_info(): phone ==null ? SignUp() : map_Appear == true ? ShopHomePage() : CustomerHomePage() ,
      )
  );
}