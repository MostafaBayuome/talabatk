import 'package:Talabatk/Screens/delivery/delivery_home_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Entities/app_localizations.dart';
import 'Entities/global.dart';
import 'Entities/user.dart';
import 'Screens/app_info.dart';
import 'Screens/customer/customer_home_page.dart';
import 'Screens/shop/shop_home_page.dart';
import 'Screens/signup.dart';


Future<void> main()  async {

    WidgetsFlutterBinding.ensureInitialized();

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

    await Global.appLanguage.fetchLocale();
    final AppLanguage appLanguage=Global.appLanguage;
    runApp(
        ChangeNotifierProvider<AppLanguage>(
          create: (_) => appLanguage,
          child: Consumer<AppLanguage>(builder: (context, model, child) {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              locale: model.appLocal,
              supportedLocales: [
                Locale('ar', 'EG'),
                Locale('en', 'US'),
              ],
              localizationsDelegates: [
                AppLocalizations.delegate,
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
              ],
              home:  FirstEnter==null? app_info(): phone ==null ? SignUp() : (map_Appear == 1 || map_Appear == 2) ? ShopHomePage() : (map_Appear!=9) ? CustomerHomePage() : DeliveryHomePage(),
            );
          }),
        )
   );



}
