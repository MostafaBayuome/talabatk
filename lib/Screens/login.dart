import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:talabatk_flutter/Entities/api_manger.dart';
import 'package:talabatk_flutter/Entities/validation.dart';
import 'package:talabatk_flutter/Entities/global.dart';
import 'package:talabatk_flutter/Screens/shop_home_page.dart';
import 'package:talabatk_flutter/Screens/signup.dart';
import 'package:talabatk_flutter/Widgets/utils.dart';
import 'customer_home_page.dart';
import 'forget_pass.dart';

class Login extends StatefulWidget {

  @override
  _State createState() => _State();
}

class _State extends State<Login>  with Validation {

  String mobileNumber='';
  String password='';
  Position position;
  final formKey = GlobalKey <FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color(int.parse(Global.primaryColor)),
          centerTitle: true,
          title:Text(Global.appName,
            style: TextStyle(
                fontFamily: Global.fontFamily,
                fontWeight: FontWeight.w900,
                fontSize: 30
            ),),
          automaticallyImplyLeading: false,
        ),
        body: Padding(
            padding: EdgeInsets.all(10),
            child: ListView(
              children: <Widget>[

                Align(

                  child:  Container(
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
                        'الدخول',
                        style: TextStyle(
                            color: Colors.white,
                            fontFamily: Global.fontFamily,
                            fontWeight: FontWeight.w900,
                            fontSize: 18),
                      )),
                ),

                Container(
                  margin: EdgeInsets.all(20.0),
                  child: Form(
                    key: formKey,
                    child: Column(
                      children: [
                        Directionality(
                          textDirection: TextDirection.rtl,
                          child: mobileField(),
                      ),
                        Directionality(
                          textDirection: TextDirection.rtl,
                          child:passwordField(),
                      ),
                        forgetPasswordButton(),
                        Container(margin: EdgeInsets.only(top:25.0),),
                        submitButton()


                      ],
                    ),
                  ),
                ),
                Container(
                    child: Row(
                      children: <Widget>[

                        FlatButton(
                          textColor: Color(int.parse(Global.primaryColor)),
                          child: Text(
                            'تسجيل الدخول',
                            style: TextStyle(fontSize: 20),
                          ),
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) =>SignUp()
                            ));
                          },
                        ),
                        Text('انشاء حساب؟'),
                      ],
                      mainAxisAlignment: MainAxisAlignment.center,
                    ))
              ],
            )));
  }


  Widget mobileField(){

    return TextFormField(
      textDirection: TextDirection.rtl,
      textAlign: TextAlign.right,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        labelText: 'رقم الموبيل',
        hintText: '',
      ),
      validator:validateMobileNumber ,
      onSaved: (String value){
        mobileNumber=value;
      },
    );
  }

  Widget passwordField() {
    return  TextFormField(
      obscureText: true,
      textDirection: TextDirection.rtl,
      textAlign: TextAlign.right,
      decoration: InputDecoration(
        labelText: 'كلمه المرور',
        hintText: 'كلمه المرور',
      ),
      validator: validatePassword ,
      onSaved: (String value){
        password=value;
      },
    );
  }

  Widget forgetPasswordButton() {
    return FlatButton(
      onPressed: (){
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) =>ForgetPassword()
        ));
      },
      textColor: Color(int.parse(Global.primaryColor)),
      child: Text('هل نسيت كلمة المرور؟'),
    );
  }

  
  Widget submitButton() {
    if(Global.visible_progress){
      return CircularProgressIndicator();

    }
    else
    return RaisedButton(
      color: Color(int.parse(Global.primaryColor)),
      child: Text('دخول',
      style: TextStyle(
        color: Colors.white,
      ),),
      onPressed: () {

        if(formKey.currentState.validate())
        {
          setState(() {
            Global.visible_progress=true;
          });

          formKey.currentState.save();
          loginUser("Talabatk/GetUserByConditionPhone",mobileNumber, password).then((value) async {
            setState(() {
              Global.visible_progress=false;
            });
            if(value != null)
              {

                try{
                  var data =value;
                  SharedPreferences prefs = await SharedPreferences.getInstance();


                  prefs.setInt('id',data["id"]);
                  prefs.setString('phone', data["phone"]);
                  prefs.setInt('map_Appear', data["map_Appear"]);

                  if(value["map_Appear"]>0)
                    {
                      Navigator.of(context).pop();
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) =>ShopHomePage()
                      ));
                    }
                  else{
                    Navigator.of(context).pop();
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) =>CustomerHomePage()
                    ));
                  }
                }
              catch (Excepetion)
              {
                  print(Excepetion);
              }
              }
            else{
              Utils.toastMessage("البيانات خطاء");
            }
          });



        }},
    );

  }




}