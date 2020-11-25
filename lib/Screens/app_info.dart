import 'package:Talabatk/Entities/app_localizations.dart';
import 'package:Talabatk/Widgets/utils.dart';
import 'package:flutter/material.dart';
import 'package:Talabatk/Entities/global.dart';
import 'package:provider/provider.dart';
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
    var appLanguage = Provider.of<AppLanguage>(context);
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
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(0),
                  child: RaisedButton(

                    elevation: 10,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30)
                    ),
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) =>use_policy(username: "shop",)
                      ));
                    },
                    color: Color(int.parse(Global.primaryColor)),
                    child: Text(
                      AppLocalizations.of(context).translate('shop'),
                      style: TextStyle(
                          fontSize: 18,
                          color: Colors.white
                      ),
                    ),
                  ),

                ),
              SizedBox(width: 20,),
              Padding(
                  padding: const EdgeInsets.all(0),
                  child: RaisedButton(

                    elevation: 10,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30)
                    ),
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) =>use_policy(username: "customer",)
                      ));
                    },
                    color: Color(int.parse(Global.primaryColor)),
                    child: Text(
                        AppLocalizations.of(context).translate('customer'),
                      style: TextStyle(
                          fontSize: 18,
                          color: Colors.white
                      ),
                    ),
                  ),

                ),
              ],
            ),
                Container(),
              Container(margin: EdgeInsets.only(top:10.0),),

              Column(
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
                 ),
               ],
              )
            ],

          ),
        ),

      ),
    );
  }

}