import 'package:Talabatk/Widgets/utils.dart';
import 'package:flutter/material.dart';
import 'package:Talabatk/Entities/global.dart';
import 'use_policy.dart';


class app_info extends StatefulWidget   {
  @override
  _State createState() => _State();
}

class _State extends State<app_info> with TickerProviderStateMixin {
  AnimationController controller;
  Animation growAnimation;


  @override
  void initState(){
    super.initState();
    controller= AnimationController(vsync: this,duration: const Duration(seconds: 3))
      ..addListener(() { setState(() {
      });});
    growAnimation = Tween<double>(begin: 0,end: 200).animate(controller);
    controller.forward();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 40),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              SizedBox(height: 10),
            Align(

              child:Hero(
                  tag:'title',
                  child: Utils.title(growAnimation.value, growAnimation.value)),
           ),
              Padding(
                padding: const EdgeInsets.all(0),
                child: RaisedButton(

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
                    'Next',
                    style: TextStyle(
                        fontSize: 18,
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