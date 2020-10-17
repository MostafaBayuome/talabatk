import 'package:flutter/material.dart';
import 'package:talabatk_flutter/Entities/global.dart';


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
          backgroundColor: Color(int.parse(Global.primaryColor)),
          centerTitle: true,
          title:Text(Global.appName,
            style: TextStyle(
                fontFamily: Global.fontFamily,
                fontWeight: FontWeight.w900,
                fontSize: 30
            ),),
          automaticallyImplyLeading: false,
        ),
        body: Padding(
          padding: EdgeInsets.all(10),

       )


    );

  }

}