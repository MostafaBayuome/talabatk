import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:geolocator/geolocator.dart';
import 'package:talabatk_flutter/Entities/api_manger.dart';
import 'package:talabatk_flutter/Entities/validation.dart';
import 'package:talabatk_flutter/Entities/global.dart';
import 'package:talabatk_flutter/Screens/shop_home_page.dart';
import 'package:talabatk_flutter/Widgets/utils.dart';
import 'customer_home_page.dart';
import 'login.dart';


class SignUp extends StatefulWidget {
  @override
  _State createState() => _State();
}

class _State extends State<SignUp> with Validation  {

  // true signup => SHOP  false => CUSTOMER

  bool map_Appear=false;
  String userName='';
  String phone='';
  String password='';
  Position position=null;
  final formKey = GlobalKey <FormState>();

  @override
  void initState()  {
    _getCurrentLocation();
    super.initState();
  }

    void _getCurrentLocation() async {
    try{
      position =  await getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
      print(position.latitude);
      print(position.longitude);
    }on Exception{
      print(Exception);
    }
  }

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
                _title(),
                Container(margin: EdgeInsets.only(top:25.0),),
                Container(
                  margin: EdgeInsets.all(20.0),
                  child: Form(
                    key: formKey,
                    child: Column(
                      children: [

                       Directionality(
                        textDirection: TextDirection.rtl,
                         child: nameField(),
                         ),
                       Directionality(
                          textDirection: TextDirection.rtl,
                          child: mobileField(),
                        ),
                       Directionality(
                          textDirection: TextDirection.rtl,
                          child: passwordField(),
                        ),
                        Container(margin: EdgeInsets.only(top:10.0),),
                        Text(
                          'موقعك',
                          style: TextStyle(fontSize: 20,
                            color:Color(int.parse(Global.primaryColor)),
                            fontFamily: Global.fontFamily,
                            fontWeight: FontWeight.w500,),
                        ),
                        getLocation(),
                        Container(margin: EdgeInsets.only(top:25.0),),
                        submitButton(),

                      ],
                    ),
                  ),
                ),
                checkBox(),
                SizedBox(height: 10),
                sentToLogin(),
              ],
            )));
  }



  Widget _title() {
    return Align(

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
            'سجل حسابك',
            style: TextStyle(
                color: Colors.white,
                fontFamily: Global.fontFamily,
                fontWeight: FontWeight.w900,
                fontSize: 18),
          )),
    );
  }

  Widget nameField(){

    return TextFormField(
      textAlign: TextAlign.right,
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        labelText: 'الاسم',
        hintText: 'محمد',
      ),
      validator: validateUserName,
      onSaved: (String value){
        userName=value;
      },
    );
  }

  Widget mobileField(){
    return TextFormField(
      textAlign: TextAlign.right,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        labelText: 'رقم الموبيل',
        hintText: '',
      ),
      validator: validateMobileNumber,
      onSaved: (String value){
        phone=value;
      },
    );
  }

  Widget passwordField() {
    return  TextFormField(
      obscureText: true,
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

  Widget submitButton()  {

    return RaisedButton(
      color:Color(int.parse(Global.primaryColor)),
      child: Text('تسجيل الدخول',style:TextStyle(
        color: Colors.white,
        fontFamily: Global.fontFamily,
        fontWeight: FontWeight.w500,
      ),),
      onPressed: () async {
        if(formKey.currentState.validate()) {
          formKey.currentState.save();
          if (map_Appear){   // Sign up as shop
            if (position == null) {
              _getCurrentLocation();
            }
            else {
              
              signUp("Talabatk/AddUser", phone, password, userName ,position.latitude, position.longitude, true, map_Appear).then((value) async {
                if(!value.contains("user_exist"))
                {
                  SharedPreferences prefs = await SharedPreferences.getInstance();
                  prefs.setString('id',value);
                  prefs.setString('phone', phone);
                  prefs.setBool('map_Appear', map_Appear);


                  Navigator.of(context).pop();
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => ShopHomePage()
                  ));
                }
                else{
                  Utils.toastMessage("من فضلك ادخل البيانات صحيحه");
                }}
              );

            }
          }
          else { // sign up as customer

            if (position == null) {
              _getCurrentLocation();
            }
            else {
              signUp("Talabatk/AddUser", phone, password,userName, position.latitude, position.longitude, true, map_Appear).then((value) async {
                if(!value.contains("user_exist"))
                {
                  SharedPreferences prefs = await SharedPreferences.getInstance();
                  prefs.setString('id',value);
                  prefs.setString('phone', phone);
                  prefs.setBool('map_Appear', map_Appear);


                  Navigator.of(context).pop();
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => CustomerHomePage()
                  ));
                }
                else{
                  Utils.toastMessage("من فضلك ادخل البيانات صحيحه");
                }}
              );

            }
          }
        }
      },
    );
  }

  Widget getLocation (){
    return Ink(
      decoration: const ShapeDecoration(
        color: Colors.white,
        shape: CircleBorder(),
      ),
      child: IconButton(
        icon: Icon(Icons.location_on),
        color: Color(int.parse(Global.primaryColor)),
        onPressed: () {
          position =  _getLocation() as Position;
        },
      ),
    );
  }

  // get current location of user
  Future<Position> _getLocation() async{
    Position position = await getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    print(position);
    return position;
  }

  Widget checkBox() {
    return   Container(
        child: Row(
          children: <Widget>[
            Text(
              'التسجيل كصاحب محل تجاري',
              style: TextStyle(fontSize: 10,
                fontFamily: Global.fontFamily,
                fontWeight: FontWeight.w500,),
            ),
            Checkbox(
              value: map_Appear,
              onChanged: (bool value)
              {
                setState(() {
                  map_Appear=value;
                });
              },
            )
          ],
          mainAxisAlignment: MainAxisAlignment.center,
        )
    );
  }

  Widget sentToLogin(){
    return Container(
        child: Row(
          children: <Widget>[
            FlatButton(
              textColor: Color(int.parse(Global.primaryColor)),
              child: Text(
                ' الدخول',
                style: TextStyle(fontSize: 20,
                  fontFamily: Global.fontFamily,
                  fontWeight: FontWeight.w500,),
              ),
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) =>Login()
                ));
              },
            ),
            Text('لديك حساب؟' ,style: TextStyle(
              fontFamily: Global.fontFamily,
              fontWeight: FontWeight.w500,),),
          ],
          mainAxisAlignment: MainAxisAlignment.center,
        ));
  }

}