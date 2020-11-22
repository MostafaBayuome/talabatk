import 'package:Talabatk/Entities/app_localizations.dart';
import 'package:Talabatk/Screens/login.dart';
import 'package:Talabatk/Screens/notification_page.dart';
import 'package:Talabatk/Widgets/change_lan.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:Talabatk/Entities/global.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class Utils {

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
      //old title
      /*Container(
          decoration: BoxDecoration(
              border: Border.all(color:Color(int.parse(Global.primaryColor)) , width: 4.0),
              borderRadius: new BorderRadius.all(Radius.elliptical(100, 50)),
              color:Color(int.parse(Global.secondaryColor))
          ),
          width: 140.0,
          height: 70.0,
          alignment: Alignment.center,
          padding: EdgeInsets.all(10),
          child: Text(
            'سجل حسابك',
            style: TextStyle(
                color: Colors.white,
                fontFamily: Global.fontFamily,
                fontWeight: FontWeight.w900,
                fontSize: 18),
          )) */

  }

  // for sign out deleting all prefrences for user
  static Future<void>  choiceAction(String choices,BuildContext context) async {


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
    else if(choices.contains('الاعدادات')||choices.contains("Settings")){
      Navigator.of(context).push(MaterialPageRoute(
          builder: (context) =>Settings()
      ));
    }

  }

  // appbar for all users shop, customer, delivery
  static Widget  appBarusers(BuildContext context,String title ){
    String SignOut=AppLocalizations.of(context).translate('sign_out');
    String settings=AppLocalizations.of(context).translate('settings');

    List<String> singleChoice = <String> [
      settings,
      SignOut
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
        if(_title != "Notifications" || _title != "تنبيه")
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
              Utils.choiceAction(value, context);
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