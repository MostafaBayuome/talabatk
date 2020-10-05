import 'package:flutter/material.dart';
import 'chatpage.dart';


class UserRequest extends StatefulWidget
{
  @override
  State<StatefulWidget> createState() =>_State();
}
class _State extends State<UserRequest>{
  @override
  Widget build(BuildContext context) {
          return Scaffold(
              appBar:AppBar(
                title: Text('APP NAME'),
                automaticallyImplyLeading: false,
              ),
            body: Padding(
                padding: EdgeInsets.all(30),
              child: Column(
                children: [
                  Text('User number : 0111123455',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
                  Container(margin: EdgeInsets.only(top:25.0),),
                  Text('User Description  need 1 litre milk 10 eggs etc ......... plus new things will be added  plus new things will be added  and plus new things adddeded hererereererer',style: TextStyle(fontSize: 15)),
                  Container(margin: EdgeInsets.only(top:25.0),),
                  Container(
                              height: 50,
                              padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                              child: RaisedButton(
                                textColor: Colors.white,
                                color: Colors.blue,
                                child: Text('Chat'),
                                onPressed: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) =>ChatPage()
                                  ));
                                },
                              )),
                  Container(
                      height: 50,
                      padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                      child: RaisedButton(
                        textColor: Colors.white,
                        color: Colors.blue,
                        child: Text('Call User'),
                        onPressed: () {

                        },
                      )),
                          FlatButton(
                            child: IconButton(
                              icon: Icon(Icons.place),
                              color: Colors.red,
                              onPressed: () {
                                // here we send location of user
                              },
                            ),
                          ),
                  Container(
                      height: 60,
                      padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                      child: RaisedButton(
                        textColor: Colors.white,
                        color: Colors.blue,
                        child: Text('Submit'),
                        onPressed: () {
                        },
                      ))
                ],
              ),
            ),
          );
  }

}
