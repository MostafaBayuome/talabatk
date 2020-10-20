import 'package:Talabatk/Entities/request.dart';
import 'package:flutter/material.dart';
import 'package:Talabatk/Entities/global.dart';


class ChatPage extends StatefulWidget{

  Request request;
  ChatPage({Key key, @required this.request}) : super(key: key);
  @override
  State<StatefulWidget> createState() =>_ChatPage(request);


}
class _ChatPage extends State<ChatPage>
{

  Request request;
  _ChatPage(this.request);

  var _controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    print(request.id);
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
        body: Container(
          height: MediaQuery.of(context).size.height,
          padding: EdgeInsets.all(10),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                IconButton(
                  icon: Icon(Icons.photo),
                  iconSize: 25.0,
                  color: Theme.of(context).primaryColor,
                  onPressed: () {

                  },
                ),
                Expanded(
                  child: TextField(
                    controller: _controller,
                    textCapitalization: TextCapitalization.sentences,

                    onChanged: (value) {

                    },
                    decoration: InputDecoration (
                      suffixIcon: IconButton(
                        onPressed: () => _controller.clear(),
                        icon: Icon(Icons.clear),
                      ),
                      hintText: 'Send a message...',
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.send),
                  iconSize: 25.0,
                  color: Theme.of(context).primaryColor,
                  onPressed: () {
                    //send postReq to reply
                   print (_controller.toString());
                    setState(() {
                      _controller.clear();
                    });

                  },
                ),
              ],
            ),

       )


    );

  }

}