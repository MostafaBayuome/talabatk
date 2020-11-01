import 'package:flutter/material.dart';

import 'package:Talabatk/Entities/global.dart';
import 'package:Talabatk/Widgets/Utils.dart';
import 'use_policy.dart';


class app_info extends StatefulWidget {
  @override
  _State createState() => _State();
}

class _State extends State<app_info>  {



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
                  'طلباتك',
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
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) =>use_policy()
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