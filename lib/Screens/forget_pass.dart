import 'dart:io';
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
      appBar: AppBar(
        title: Text('App Name'),
        automaticallyImplyLeading: false,
      ),
      body: Padding(
      padding: EdgeInsets.all(10),
      child: ListView(
          children: <Widget>[
            Container(
                alignment: Alignment.center,
                padding: EdgeInsets.all(10),
                child: Text(
                  'SuperMarket',
                  style: TextStyle(
                      color: Colors.blue,
                      fontWeight: FontWeight.w500,
                      fontSize: 30),
                )),
                Container(
                  padding: EdgeInsets.all(20),
                  child: Column(
                    children: [
                      mobileField(),
                      Container(margin: EdgeInsets.only(top:25.0),),
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
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        labelText: 'Mobile Number',
        hintText: '01+  ',
      ),
      onSaved: (String value){
      },
    );
  }
  Widget submitButton() {
    return RaisedButton(
      color: Colors.blue,
      child: Text('Login',
        style: TextStyle(
          color: Colors.white,
        ),),
      onPressed: () {
      },
    );
  }

}