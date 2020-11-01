import 'package:Talabatk/Screens/delivery/delivery_home_page.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Entities/global.dart';
import 'Entities/user.dart';
import 'Screens/app_info.dart';
import 'Screens/customer/customer_home_page.dart';
import 'Screens/shop/shop_home_page.dart';
import 'Screens/signup.dart';

Future<void> main()  async {
   WidgetsFlutterBinding.ensureInitialized();
   SharedPreferences prefs =await SharedPreferences.getInstance();


  // if mobileNumber and check not null then it will redirect to the correct homepage
   var FirstEnter=prefs.getInt('FirstEnter');

   var phone=prefs.getString('phone');
   var map_Appear=prefs.getInt('map_Appear');
   var user_id=prefs.getInt('id');
   var password = prefs.getString('password');
   var user_name=prefs.getString('userName');
   var latitude=prefs.getDouble('latitude');
   var longitude=prefs.getDouble('longitude');
   var merchant_id=prefs.getInt('merchant_id');

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