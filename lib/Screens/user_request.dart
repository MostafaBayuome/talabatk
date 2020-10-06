import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:talabatk_flutter/Entities/global.dart';
import 'package:talabatk_flutter/Entities/user.dart';
import 'package:url_launcher/url_launcher.dart';
import 'chat_page.dart';


class UserRequest extends StatefulWidget
{
  User shop;
  UserRequest({Key key, @required this.shop}) : super(key: key);

  @override
  State<StatefulWidget> createState() =>_State(shop);
}

class _State extends State<UserRequest>{
  User shop;
  _State(this.shop);

  @override
  Widget build(BuildContext context) {
          return Scaffold(
              appBar:AppBar(
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
              child: Column(

                children: [
                  Container(
                      height: 50,
                      child: RaisedButton(
                          onPressed: () {
                            launch('tel://${shop.mobileNumber}');
                          },
                          elevation: 2.0,
                          color: Color(int.parse(Global.primaryColor)),
                          textColor: Colors.white,
                          padding: const EdgeInsets.all(0.0),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),
                          ),
                          child: Container(
                            padding: const EdgeInsets.all(10.0),
                            child: const Text('اتصال  ',
                                style: TextStyle(fontSize: 20)
                            ),
                          )
                      ),),
                ],
              ),
            ),
          );
  }

}
