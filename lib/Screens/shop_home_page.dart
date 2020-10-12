import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:talabatk_flutter/Entities/constants.dart';
import 'package:talabatk_flutter/Entities/global.dart';
import 'signup.dart';



class ShopHomePage extends StatefulWidget {

  @override
  State<StatefulWidget> createState() => _State();

}

class _State extends State<ShopHomePage>{

  String response="one";


  @override
  Widget build(BuildContext context) {
    getAllRequests();
    return Scaffold(
      appBar:AppBar(
        backgroundColor: Color(int.parse(Global.primaryColor)),
        title: Text(Global.appName),
        automaticallyImplyLeading: false,
        actions: [
          PopupMenuButton<String>(
            onSelected: choiceAction,
            itemBuilder: (BuildContext context){
              return Constants.choices.map((String choice){
                return PopupMenuItem<String>(
                  value: choice,
                  child: Text(choice),
                );
              }).toList();
            },
          )
        ],
      ),body:Padding(
          padding: EdgeInsets.all(10),
          child: Text(response),
    )
    );
  }

  Future getAllRequests() {
    return new Future.delayed(const Duration(seconds: 20), () {

      setState(() {
        response+=response;
      });
    });
  }

   Future<void>  choiceAction(String choices) async {

    if(choices.contains('تسجيل الخروج')){
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.remove('FirstEnter');
      prefs.remove('phone');
      prefs.remove('map_Appear');
      prefs.remove('id');
      prefs.remove('password');
      prefs.remove('userName');
      prefs.remove('latitude');
      prefs.remove('longitude');


      Navigator.of(context).pop();
      Navigator.of(context).push(MaterialPageRoute(
          builder: (context) =>SignUp()
      ));
    }

  }

}