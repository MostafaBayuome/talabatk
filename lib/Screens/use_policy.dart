import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:talabatk_flutter/Entities/global.dart';
import 'package:talabatk_flutter/Widgets/Utils.dart';
import 'login.dart';
import 'use_policy.dart';


class use_policy extends StatefulWidget {
  @override
  _State createState() => _State();
}

class _State extends State<use_policy>  {

  // true signup => SHOP  false => CUSTOMER
  @override
  void initState()  {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: new BoxDecoration(
          image: new DecorationImage(
            image: new AssetImage('images/shooping.PNG'),
            fit: BoxFit.fill,
            colorFilter:
            ColorFilter.mode(Colors.black.withOpacity(0.7),
                BlendMode.dstATop),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 40),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                  'Talabatk',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 40,
                      fontStyle: FontStyle.italic
                  )
              ),
              Padding(
                padding: const EdgeInsets.all(16),
                child: RaisedButton(
                  splashColor: Colors.orange,
                  elevation: 10,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30)
                  ),
                  onPressed: () async {
                    try{
                      SharedPreferences prefs = await SharedPreferences.getInstance();
                      prefs.setInt('FirstEnter',1);
                    }
                    catch (Excepetion)
                    {}
                    Navigator.of(context).pop();
                    Navigator.of(context).pop();
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) =>Login()
                    ));
                  },
                  color: Color(int.parse(Global.primaryColor)),
                  child: Text(
                    'التالي --->',
                    style: TextStyle(
                        fontSize: 23,
                        color: Colors.white
                    ),
                  ),
                ),
              )
            ],

          ),
        ),

      ),
    );
  }

}