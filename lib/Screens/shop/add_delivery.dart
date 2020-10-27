import 'package:Talabatk/Entities/api_manger.dart';
import 'package:Talabatk/Entities/global.dart';
import 'package:Talabatk/Entities/validation.dart';
import 'package:Talabatk/Screens/shop/shop_home_page.dart';
import 'package:Talabatk/Widgets/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class addDeliveryman extends StatefulWidget{
  @override
  _State createState() => _State();
}
class _State extends State<addDeliveryman> with Validation
{
  int map_Appear=9;
  String userName='';
  String phone='';
  String password='';
  String confirmPassword='';
  final formKey = GlobalKey <FormState>();
  final TextEditingController _confirmPass = TextEditingController();
  final TextEditingController _pass = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return  Scaffold(

        body: Padding(
            padding: EdgeInsets.all(10),
            child: ListView(
              children: <Widget>[
                //future update remove _title() and put CircleAvatar()

                Container(margin: EdgeInsets.only(top:25.0),),
                Container(
                  margin: EdgeInsets.all(20.0),
                  child: Form(
                    key: formKey,
                    child: Column(
                      children: [
                        Utils.title(100.0,100.0),
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
                        Directionality(
                          textDirection: TextDirection.rtl,
                          child: passwordFieldConfirmation(),
                        ),


                        Container(margin: EdgeInsets.only(top:30.0),),
                        submitButton(),

                      ],
                    ),
                  ),
                ),


              ],
            )));
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
      controller: _pass,
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

  Widget passwordFieldConfirmation() {
    return  TextFormField(
      controller:_confirmPass,
      obscureText: true,
      textAlign: TextAlign.right,
      decoration: InputDecoration(
        labelText: 'تاكيد كلمه المرور',
        hintText: 'تاكيد كلمه المرور',
      ),
        validator: (val){
          if(val.isEmpty)
            return 'Empty';
          if(val != _pass.text)
            return 'Not Match';
          return null;
        },
      onSaved: (String value){
        confirmPassword=value;
      },
    );
  }

  Widget submitButton()  {
    if(Global.visible_progress){
      return CircularProgressIndicator();
    }
    else
      return RaisedButton(
        color:Color(int.parse(Global.primaryColor)),
        child: Text('اضافه طيار',style:TextStyle(
          color: Colors.white,
          fontFamily: Global.fontFamily,
          fontWeight: FontWeight.w500,
        ),),
        onPressed: () async {
          setState(() {
            Global.visible_progress=true;
          });

          if(formKey.currentState.validate()) {
            formKey.currentState.save();
            signUp("Talabatk/AddUser", phone, password, userName ,Global.loginUser.latitude, Global.loginUser.longitude, true, map_Appear,Global.loginUser.id).then((value) async {
              setState(() {
                 Global.visible_progress=false;
                  });
            if(value != null)
                {
                  Utils.toastMessage('لقد تم اضافه طيار');
                  Navigator.of(context).pop();
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => ShopHomePage()
                  ));

                }
            else{
              Utils.toastMessage("من فضلك ادخل البيانات صحيحه");
            }
          });


            }
          else{
            setState(() {
              Global.visible_progress=false;
            });
          }

        },
      );
  }
}