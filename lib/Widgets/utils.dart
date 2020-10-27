import 'package:Talabatk/Screens/signup.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:Talabatk/Entities/global.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Utils {

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

  static Widget appBar(double fontsize) {
    return AppBar(
      backgroundColor: Color(int.parse(Global.primaryColor)),
      centerTitle: true,
      title:Text(Global.appName,
        style: TextStyle(
            fontFamily: Global.fontFamily,
            fontWeight: FontWeight.w900,
            fontSize: fontsize
        ),),
      automaticallyImplyLeading: false,
    );
  }

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

  static Future<void>  choiceAction(String choices,BuildContext context) async {

    if(choices.contains('تسجيل الخروج')){
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.remove('phone');
      prefs.remove('map_Appear');
      prefs.remove('id');
      prefs.remove('password');
      prefs.remove('userName');
      prefs.remove('latitude');
      prefs.remove('longitude');


      Navigator.of(context).pushAndRemoveUntil(  MaterialPageRoute(
          builder: (context) =>SignUp()
      ),ModalRoute.withName("/Home"));
    }




  }

}