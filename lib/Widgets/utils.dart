import 'package:Talabatk/Entities/app_localizations.dart';
import 'package:Talabatk/Screens/login.dart';
import 'package:Talabatk/Screens/notification_page.dart';
import 'package:Talabatk/Screens/settings.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:Talabatk/Entities/global.dart';
import 'package:Talabatk/Screens/profile.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class Utils {


  static  var fontBold = TextStyle(
      fontWeight: FontWeight.bold
  );
  // global toast_message send message in an argument
  static void toastMessage(String message){
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Color(int.parse(Global.primaryColor)),
        textColor: Colors.white,
        fontSize: 16.0
    );
  }

  // global application title
  static  Widget title(double width,double height) {
    return Align(
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
            shape: BoxShape.circle,
            image: DecorationImage(
                image : AssetImage("images/Talabatk.png"),
                fit:BoxFit.fill
            )
        ),
      ),);
    
  }

  // for sign out deleting all prefrences for user
  static Future<void>  choiceAction(String choices,BuildContext context,String title) async {


    if(choices.contains('تسجيل الخروج')|| choices.contains("SignOut")){
      SharedPreferences prefs = await SharedPreferences.getInstance();

      prefs.remove('phone');
      prefs.remove('map_Appear');
      prefs.remove('id');
      prefs.remove('password');
      prefs.remove('userName');
      prefs.remove('latitude');
      prefs.remove('longitude');
      prefs.remove('merchant_id');

      Navigator.of(context).pushAndRemoveUntil(  MaterialPageRoute(
          builder: (context) =>Login()
      ),ModalRoute.withName("/Home"));
    }
    else if((choices.contains('الاعدادات')|| choices.contains("Settings")) && (title != "Settings" && title != "الاعدادات" ) ){
      Navigator.of(context).push(MaterialPageRoute(
          builder: (context) =>Settings()
      ));
    }
    else if(choices.contains("الملف الشخصي") || choices.contains("Profile")){

      Navigator.of(context).push(MaterialPageRoute(
          builder: (context) =>Profile()
      ));
    }

  }

  // appbar for all users shop, customer, delivery
  static Widget  appBarusers(BuildContext context,String title ){

    String signOut=AppLocalizations.of(context).translate('sign_out');
    String settings=AppLocalizations.of(context).translate('settings');
    String profile=AppLocalizations.of(context).translate('profile');

    List<String> singleChoice = <String> [
      settings,
      profile,
      signOut
    ];
    String _title=title;
    return PreferredSize(
      preferredSize: Size.fromHeight(40.0),
      child: AppBar(
        backgroundColor:Color(int.parse(Global.primaryColor)),
        title: Text(title,style: TextStyle(
          color:Colors.white,
          fontSize: 15
        ),),
        automaticallyImplyLeading: false,
        //actionsIconTheme: IconThemeData(color:Color(int.parse(Global.primaryColor))),
        actions: [
        if(_title != "Notifications" && _title != "تنبيه")
           IconButton(icon:Stack(
              children: [
                Icon(Icons.notifications),
                Global.userNotifications.length > 0 ?
                Positioned(
                  left: 12,
                  child: CircleAvatar(
                    radius: 6,
                    backgroundColor: Colors.red,
                    child: Center(
                      child: Text(
                        Global.userNotifications.length.toString(),
                        style: TextStyle(color: Colors.white,fontSize: 8),
                      ),
                    ),
                  ),
                     ) :
                    Container()
                  ],
              ),
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) =>Notification_Page()
                ));
                }),

          PopupMenuButton<String>(
            onSelected: (value){
              Utils.choiceAction(value, context,title);
            },
            itemBuilder: (BuildContext context){
              return  singleChoice.map((String choice){
                return PopupMenuItem<String>(
                  value: choice,
                  child: Text(choice),
                );
              }).toList();
            },
          )

        ],
      ),
    );
  }

  // send Lat,long and it will open google maps
  static Future<void> openMap(double latitude, double longitude) async {
    String googleUrl = 'https://www.google.com/maps/search/?api=1&query=$latitude,$longitude';
    if (await canLaunch(googleUrl)) {
      await launch(googleUrl);
    } else {
      throw 'Could not open the map.';
    }
  }


}