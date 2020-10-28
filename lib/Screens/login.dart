import 'package:Talabatk/Screens/delivery/delivery_home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:Talabatk/Entities/api_manger.dart';
import 'package:Talabatk/Entities/user.dart';
import 'package:Talabatk/Entities/validation.dart';
import 'package:Talabatk/Entities/global.dart';
import 'package:Talabatk/Screens/shop/shop_home_page.dart';
import 'package:Talabatk/Screens/signup.dart';
import 'package:Talabatk/Widgets/utils.dart';
import 'customer/customer_home_page.dart';
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

        body: Padding(
            padding: EdgeInsets.all(10),
            child: ListView(
              children: <Widget>[
                Align(
                  child: Utils.title(100.0, 100.0)
                ),

                Container(margin: EdgeInsets.only(top:25.0),),
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
                        ' انشاء حساب',
                        style: TextStyle(fontSize: 20,
                        fontFamily: Global.fontFamily,
                        fontWeight: FontWeight.w500,),
                        ),
                        onPressed: () {
                        Navigator.of(context).pop();
                        Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) =>SignUp()
                        ));
                        },
                        ),
                          Text('ليس لديك حساب؟ ' ,style: TextStyle(
                          fontFamily: Global.fontFamily,
                          fontWeight: FontWeight.w500,),),
                          ],
                    mainAxisAlignment: MainAxisAlignment.center,
                    )),

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
            if(value != null  && value['state'] == true){

                try{
                  var data =value;

                  SharedPreferences prefs = await SharedPreferences.getInstance();
                  User user =new User(data['id'],data['phone'],data['latitude'],data['longitude'],data['username'],data['password'],data['map_Appear'],data['merchant_id']);
                  Global.loginUser=user;


                  prefs.setInt('id',data["id"]);
                  prefs.setString('phone', data["phone"]);
                  prefs.setInt('map_Appear', data["map_Appear"]);
                  prefs.setString('userName', data["userName"]);
                  prefs.setString('password', data["password"]);
                  prefs.setDouble('latitude',data["latitude"]);
                  prefs.setDouble('longitude', data["longitude"]);
                  prefs.setInt('merchant_id', data['merchant_id']);

                  if(value["map_Appear"]== 1 ||value["map_Appear"]== 2 ){
                      Navigator.of(context).pop();
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) =>ShopHomePage()
                      ));
                    }
                  else if (value["map_Appear"]== 0 ){
                    Navigator.of(context).pop();
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) =>CustomerHomePage()
                    ));
                  }
                  else if(value["map_Appear"]== 9 )
                    {
                      Navigator.of(context).pop();
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) =>DeliveryHomePage()
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