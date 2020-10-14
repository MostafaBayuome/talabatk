import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:talabatk_flutter/Entities/constants.dart';
import 'package:talabatk_flutter/Entities/global.dart';
import 'package:talabatk_flutter/Entities/request.dart';
import 'package:talabatk_flutter/Screens/signup.dart';


class RequestInfromation extends StatefulWidget {
  Request request;
  RequestInfromation({Key key, @required this.request}) : super(key: key);
  @override
  _RequestInfromationState createState() => _RequestInfromationState(request);
}

class _RequestInfromationState extends State<RequestInfromation> {
  Request request;
  _RequestInfromationState(this.request);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor:  Color(int.parse(Global.primaryColor)),
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
      ),

      body: Container(
        //page for displaying request with accepting and refusing it
      ),
    );
  }

  Future<void> choiceAction(String choices) async {

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
    // for future features example settings user etc...

  }
}
