import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:talabatk_flutter/Entities/constants.dart';
import 'package:talabatk_flutter/Entities/global.dart';
import 'login.dart';
import 'signup.dart';
import 'userrequest.dart';


class ShopHomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _State();

}

class _State extends State<ShopHomePage>{

  Future<void> choiceAction(String choices) async {

    if(choices.contains('تسجيل الخروج')){
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.remove('mobileNumber');
      prefs.remove('checkBoxValue');

      Navigator.of(context).pop();
      Navigator.of(context).push(MaterialPageRoute(
          builder: (context) =>SignUp()
      ));
    }

  }

  @override
  Widget build(BuildContext context) {
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
      child: ListView(
          children: <Widget>[

           Container(
             height: 140,
             child:  InkWell
               (
               onTap:(){
                 Navigator.of(context).push(MaterialPageRoute(
                     builder: (context) =>UserRequest()
                 ));
               },
               child:Card(
                   child: Column(
                     mainAxisSize: MainAxisSize.min,
                     children: <Widget>[
                       ListTile(
                         title: Text('User number : 0111123455'),
                         subtitle: Text('User Description  need 1 litre milk 10 eggs etc ......... plus new things will be added  plus new things will be added  '),
                       ),
                           FlatButton(
                             child: IconButton(
                               icon: Icon(Icons.place),
                               color: Colors.red,
                               onPressed: () {
                                 // here we send location of user
                               },
                             ),
                           ),

                     ],
                   ) ) ,
             )
           ) ,
            Container(
                height: 140,
                child:  Card(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        ListTile(
                          title: Text('User Number : 01149056691'),
                          subtitle: Text('User Description  i need to buy milk 100 orange asadas  ......... plus new things will be added  plus new things will be added  '),
                        ),
                       FlatButton(
                         child: IconButton(
                           icon: Icon(Icons.place),
                           color: Colors.red,
                           onPressed: () {
                                  // here we send location of user
                                },
                              ),
                            ),

                      ],
                    ) )
            )
          ]
      ),
    )
    );
  }

}