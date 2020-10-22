import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:Talabatk/Entities/global.dart';
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
  static Widget appBar(double fontsize)   // Signup and login
  {
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

}