import 'package:Talabatk/Entities/constants.dart';
import 'package:Talabatk/Screens/signup.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:Talabatk/Entities/global.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Utils {

  //global toast_message send message in an argument
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

    if(choices.contains('تسجيل الخروج')){
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
          builder: (context) =>SignUp()
      ),ModalRoute.withName("/Home"));
    }
  }

  // appbar for all users shop, customer, delivery
  static Widget  appBarusers(BuildContext context,String title ){
    int counter =0;
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
          /*   new Positioned(  // draw a red marble
                  top: 8.0,
                  right: 0.0,
                  left: 12.0,
                  child: Container(
                    padding: EdgeInsets.all(2),
                    decoration: new BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    constraints: BoxConstraints(
                      minWidth: 10,
                      minHeight: 10,
                    ),
                    child: Text(
                      Global.userNotifications.length.toString(),
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 8,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                )*/
          IconButton(icon:Stack(
              children: [
                Icon(Icons.notifications),
                counter == 0 ?
                Positioned(
                  left: 12,
                  child: CircleAvatar(
                    radius: 6,
                    backgroundColor: Colors.red,
                    child: Center(
                      child: Text(
                        "1",
                        style: TextStyle(color: Colors.white,fontSize: 8),
                      ),
                    ),
                  ),
                     ) :
                    Container()
                  ],
              ),
              onPressed: () {

                }),
          PopupMenuButton<String>(
            onSelected: (value){
              Utils.choiceAction(value, context);
            },
            itemBuilder: (BuildContext context){
              return Constants.singleChoice.map((String choice){
                return PopupMenuItem<String>(
                  value: choice,
                  child: Text(choice,style: TextStyle(
                      color:Color(int.parse(Global.primaryColor))
                  ),),
                );
              }).toList();
            },
          )

        ],
      ),
    );
  }

}