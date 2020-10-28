import 'package:Talabatk/Entities/global.dart';
import 'package:Talabatk/Widgets/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ForgetPassword extends StatefulWidget{
@override
_State createState() => _State();
}
class _State extends State<ForgetPassword>
{
  @override
  Widget build(BuildContext context) {

    return Scaffold(

      body: Padding(
      padding: EdgeInsets.all(10),
        child: ListView(
          children: <Widget>[
            Utils.title(100.0,100.0),
            Container(margin: EdgeInsets.only(top:25.0),),
            Container(
                  padding: EdgeInsets.all(20),
                  child: Column(
                    children: [
                      Directionality(
                        textDirection: TextDirection.rtl,
                        child: mobileField(),
                      ),
                      Container(margin: EdgeInsets.only(top:50.0),),
                      submitButton()
                    ],
                  ) ,
                )


          ]
       )
      ),
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

      onSaved: (String value){

      },
    );
  }
  Widget submitButton()  {


      return RaisedButton(
        color:Color(int.parse(Global.primaryColor)),
        child: Text('Reset Password',style:TextStyle(
          color: Colors.white,
          fontFamily: Global.fontFamily,
          fontWeight: FontWeight.w500,
        ),),
        onPressed: () async {



        },
      );
  }


}