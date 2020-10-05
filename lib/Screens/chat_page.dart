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
          child:    Column(
            children: [
              Text(
                'USER ID: Hello,  How are you?',
                overflow: TextOverflow.ellipsis,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(

                'MARKET NAME: Hello,  How are you?',

                overflow: TextOverflow.ellipsis,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(

                'USER ID: can you add some orange?',

                overflow: TextOverflow.ellipsis,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(

                'MARKET NAME: OK',

                overflow: TextOverflow.ellipsis,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),


            ],
          ),)


    );

  }

}