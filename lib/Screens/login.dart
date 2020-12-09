import 'package:Talabatk/Entities/app_localizations.dart';
import 'package:Talabatk/Screens/delivery/delivery_home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:Talabatk/Entities/api_manger.dart';
import 'package:Talabatk/Entities/user.dart';
import 'package:Talabatk/Entities/validation.dart';
import 'package:Talabatk/Entities/global.dart';
import 'package:Talabatk/Screens/shop/shop_home_page.dart';
import 'package:Talabatk/Screens/signup.dart';
import 'package:Talabatk/Widgets/utils.dart';
import 'customer/customer_home_page.dart';
import 'forget_pass.dart';
import 'package:provider/provider.dart';

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
    var appLanguage = Provider.of<AppLanguage>(context);
    return Scaffold(

        body: Padding(
            padding: EdgeInsets.all(10),
            child: ListView(
              children: <Widget>[
                Align(
                  child: Utils.title(130.0, 130.0)
                ),

                Container(margin: EdgeInsets.only(top:10.0),),
                Container(
                  margin: EdgeInsets.all(20.0),
                  child: Form(
                    key: formKey,
                    child: Column(
                      children: [
                        mobileField(),
                        passwordField(),
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

                         Text( AppLocalizations.of(context).translate('dont_have_acount')  ,style: TextStyle(
                          fontFamily: Global.fontFamily,
                          fontWeight: FontWeight.w500,),),
                         FlatButton(
                          textColor: Color(int.parse(Global.primaryColor)),
                          child: Text(
                            AppLocalizations.of(context).translate('create_account') ,
                            style: TextStyle(fontSize: 15,
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
                          ],
                    mainAxisAlignment: MainAxisAlignment.center,
                    )),

                Container(margin: EdgeInsets.only(top:40.0),),
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Center(
                      child: Text( AppLocalizations.of(context).translate('change_language')  ,style: TextStyle(
                        fontFamily: Global.fontFamily,
                        fontWeight: FontWeight.w500,),),
                    ),
                    Container(margin: EdgeInsets.only(top:5.0),),
                    Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          RaisedButton(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18.0),

                            ),
                            color: Color(int.parse(Global.primaryColor)),
                            onPressed: () {
                              appLanguage.changeLanguage(Locale("en"));
                            },
                            child: Text('English',  style: TextStyle(
                                color: Colors.white,
                                fontFamily: Global.fontFamily,
                                fontWeight: FontWeight.w700,
                                fontSize: 15
                            )),
                          ),
                          SizedBox(width: 10),
                          RaisedButton(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18.0),

                            ),
                            color: Color(int.parse(Global.primaryColor)),
                            onPressed: () {
                              appLanguage.changeLanguage(Locale("ar"));
                            },
                            child: Text('عربي' , style: TextStyle(
                                color: Colors.white,
                                fontFamily: Global.fontFamily,
                                fontWeight: FontWeight.w700,
                                fontSize: 15
                            )),
                          ) ,
                        ],
                      ) ,
                    )
                  ],
                )



              ],
            )));
  }


  Widget mobileField(){

    return TextFormField(

      keyboardType: TextInputType.number,
      decoration: InputDecoration(
       labelText: AppLocalizations.of(context).translate('mobile_field'),
        hintText: AppLocalizations.of(context).translate('mobile_field'),
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
      decoration: InputDecoration(
        labelText: AppLocalizations.of(context).translate('password_field'),
        hintText: AppLocalizations.of(context).translate('password_field'),
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
      child: Text( AppLocalizations.of(context).translate('forgetPasswordButton')),
    );
  }

  //Map_Appear   0 customer, 1 shop, 2  pharmacy, 3 restaurant , 4 atara , 9 delivery
  Widget submitButton() {
    if(Global.visible_progress){
      return CircularProgressIndicator();
    }
    else
    return Container(
      height: 40,
      width: 120,
      child:RaisedButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18.0),
        ),
        color: Color(int.parse(Global.primaryColor)),
        child: Text(AppLocalizations.of(context).translate('login') ,
          style: TextStyle(
              color: Colors.white,
              fontFamily: Global.fontFamily,
              fontWeight: FontWeight.w700,
              fontSize: 15
          ),),
        onPressed: () {
          if(formKey.currentState.validate())
          {
            setState(() {
              Global.visible_progress=true;
            });

            formKey.currentState.save();
            loginUser("Talabatk/GetUserByConditionPhoneAndPassword",mobileNumber, password).then((value) async {
              setState(() {
                Global.visible_progress=false;
              });
              if(value != null  && value['state'] == true){

                try{
                  var data =value;

                  User user =new User(data['id'],data['phone'],data['latitude'],data['longitude'],data['username'],data['password'],data['map_Appear'],data['merchant_id']);
                  Global.loginUser=user;


                  Global.prefs.setInt('id',data["id"]);
                  Global.prefs.setString('phone', data["phone"]);
                  Global.prefs.setInt('map_Appear', data["map_Appear"]);
                  Global.prefs.setString('userName', data["username"]);
                  Global.prefs.setString('password', data["password"]);
                  Global.prefs.setDouble('latitude',data["latitude"]);
                  Global.prefs.setDouble('longitude', data["longitude"]);
                  Global.prefs.setInt('merchant_id', data['merchant_id']);

                  if(value["map_Appear"]== 1 || value["map_Appear"]== 2 || value["map_Appear"]== 3 ){
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
                  else if(value["map_Appear"]== 9 ) {
                    Navigator.of(context).pop();
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) =>DeliveryHomePage()
                    ));

                  }
                }
                catch (Excepetion) {
                  print(Excepetion);
                }
              }
              else {
                Utils.toastMessage(AppLocalizations.of(context).translate('data_error') );
              }
            });
          }
          },
      ) ,
    );

  }





}