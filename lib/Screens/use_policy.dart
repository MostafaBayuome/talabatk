import 'package:Talabatk/Screens/login.dart';
import 'package:Talabatk/Widgets/utils.dart';
import 'package:flutter/material.dart';
import 'package:Talabatk/Entities/global.dart';
import 'package:shared_preferences/shared_preferences.dart';



class use_policy extends StatefulWidget {
  String username;
  use_policy({Key key, @required this.username}): super(key: key);

  @override
  _State createState() => _State(username);
}

class _State extends State<use_policy>  {

   String username;
   _State(this.username);

  @override
  void initState()  {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 40),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Align(

                child:Hero(
                    tag:'title',
                    child: Utils.title(50, 50)),
              ),
           Container(
             height: 500,
             width: 350,
             child:  ListView(
                 scrollDirection: Axis.horizontal,
                 children: <Widget>[
             Row(
             children: <Widget>[

               Container(
                 width: 250,
                   decoration: BoxDecoration(
                       image: DecorationImage(
                           image : AssetImage("images/screens/${username}1.png"),
                           fit:BoxFit.fitHeight
                       )
                   )
               ), SizedBox(width:7 ,),
               Container(
                   width: 250,
                   decoration: BoxDecoration(
                       image: DecorationImage(
                           image : AssetImage("images/screens/${username}2.png"),
                           fit:BoxFit.fitHeight
                       )
                   )
               ), SizedBox(width: 7,),
               Container(
                   width: 250,
                   decoration: BoxDecoration(
                       image: DecorationImage(
                           image : AssetImage("images/screens/${username}3.png"),
                           fit:BoxFit.fitHeight
                       )
                   )
               ), SizedBox(width: 7,),
               Container(
                   width: 250,
                   decoration: BoxDecoration(
                       image: DecorationImage(
                           image : AssetImage("images/screens/${username}4.png"),
                           fit:BoxFit.fitHeight
                       )
                   )
               ), SizedBox(width:7 ,),
               Container(
                   width: 250,
                   decoration: BoxDecoration(
                       image: DecorationImage(
                           image : AssetImage("images/screens/${username}5.png"),
                           fit:BoxFit.fitHeight
                       )
                   )
               ), SizedBox(width: 5,),



               Container(
                   width: 250,
                   decoration: BoxDecoration(
                       image: DecorationImage(
                           image : AssetImage("images/screens/${username}6.png"),
                           fit:BoxFit.fitHeight
                       )
                   )
               ), SizedBox(width: 5,),
               Container(
                   width: 250,
                   decoration: BoxDecoration(
                       image: DecorationImage(
                           image : AssetImage("images/screens/${username}7.png"),
                           fit:BoxFit.fitHeight
                       )
                   )
               ), SizedBox(width: 5,),
               Container(
                   width: 250,
                   decoration: BoxDecoration(
                       image: DecorationImage(
                           image : AssetImage("images/screens/${username}8.png"),
                           fit:BoxFit.fitHeight
                       )
                   )
               ),
               SizedBox(width: 5,),
               if(username=="shop")
                 Container(
                     width: 250,
                     decoration: BoxDecoration(
                         image: DecorationImage(
                             image : AssetImage("images/screens/${username}9.png"),
                             fit:BoxFit.fitHeight
                         )
                     )
                 ),

            ] ),
           ])
          ),
              Padding(
                padding: const EdgeInsets.all(0),
                child: RaisedButton(

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
                   'التالي',
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