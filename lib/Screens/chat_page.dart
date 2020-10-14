import 'package:flutter/material.dart';


class ChatPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() =>_State();


}
class _State extends State<ChatPage>
{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('App Name'),
          automaticallyImplyLeading: false,
        ),
        body: Padding(
          padding: EdgeInsets.all(10),
       )


    );

  }

}