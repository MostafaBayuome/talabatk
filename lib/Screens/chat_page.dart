import 'package:Talabatk/Entities/reply.dart';
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
  List<Reply> replyDetails=[];
  Request request;
  _ChatPage(this.request);
  var _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    getAllRequests();
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
        body: Column(
          children: <Widget>[
            Expanded(
              flex: 9,
              child: Container(
                  child: allReply() ,
              )
            ),
            Expanded(
              flex: 2,
              child: Container(
                height: MediaQuery.of(context).size.height,
                padding: EdgeInsets.all(10),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    IconButton(
                      icon: Icon(Icons.photo,color: Color(int.parse(Global.primaryColor))),
                      iconSize: 25.0,
                      color: Theme.of(context).primaryColor,
                      onPressed: () {
                        // Get Image from Gallery
                      },
                    ),
                    Expanded(
                      child: TextField(
                        controller: _controller,

                        textCapitalization: TextCapitalization.sentences,
                        decoration: InputDecoration (
                          border:  InputBorder.none,
                          suffixIcon: IconButton(

                            onPressed: () => _controller.clear(),
                            icon: Icon(Icons.clear ,color: Color(int.parse(Global.primaryColor)),),
                          ),
                          hintText: 'Send a message...',
                        ),
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.send,color: Color(int.parse(Global.primaryColor))),
                      iconSize: 25.0,
                      color: Theme.of(context).primaryColor,
                      onPressed: () {
                        if(_controller.text.length != 0)
                        {
                          //send postReq to reply
                          print (_controller.text);

                          Reply reply = new Reply(request.id , Global.loginUser.id, _controller.text, "", "" , "",true);
                          Reply.addReply(reply);
                          setState(() {
                            _controller.clear();
                          });
                        }

                      },
                    ),
                  ],
                ),

              )
            ),
          ],
        )


    );
  }
  Future getAllRequests() {
    return  Future.delayed(const Duration(seconds: 2), () {
      Reply.getRepliesByRequestID(request.id).then((value)
      {
        setState(() {
          replyDetails = value;
        });
      }
      );

    });
  }
  Widget allReply()
  {

    return ListView.builder(
      padding: EdgeInsets.all(8.0),
      itemCount: replyDetails.length,
      itemBuilder: (BuildContext context,int index){
        if(Global.loginUser.id==replyDetails[index].user_id) {
          return Container(
            child:Padding(
                padding: const EdgeInsets.all(5.0),
                child: Container(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Container(
                          child: Padding(
                            padding: const EdgeInsets.all(0.0),
                            child:
                            RaisedButton(
                                onPressed: () {

                                },
                                color: Color(int.parse(Global.primaryColor)),
                                elevation: 10.0,
                                textColor: Colors.white,
                                padding: const EdgeInsets.all(0.0),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(18.0),
                                ),
                                child: Container(
                                  padding: const EdgeInsets.all(10.0),
                                  child:   Text(
                                      replyDetails[index].reply_detail,

                                  ),
                                )),
                          ),
                        ),
                      ]
                  ),)),
          );
        }
        else{
          return Container(

            child:Padding(
                padding: const EdgeInsets.all(5.0),
                child: Container(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        RaisedButton(
                            onPressed: () {

                            },
                            color: Colors.grey[150],
                            elevation: 10.0,
                            textColor: Colors.black,
                            padding: const EdgeInsets.all(0.0),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18.0),
                            ),
                            child: Container(
                              padding: const EdgeInsets.all(10.0),
                              child:   Text(
                                  replyDetails[index].reply_detail,

                              ),
                            )),
                      ]
                  ),)),
          );
        }

      },
    );

  }
}