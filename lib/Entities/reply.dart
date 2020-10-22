import 'dart:convert';
import 'package:Talabatk/Entities/global.dart';
import 'package:http/http.dart' as http;

class Reply {
int id;
int request_id;
int user_id;
String reply_detail;
String reply_date;
String reply_time;
String image_url;
bool state;

Reply( this.request_id, this.user_id, this.reply_detail, this.reply_date,
      this.reply_time, this.image_url, this.state);
Reply.id(this.id,this.request_id, this.user_id, this.reply_detail, this.reply_date,
    this.reply_time, this.image_url, this.state);
  static Future<void> addReply(Reply reply) async {

  String url = Global.url+"Reply/AddReply";
  final response= await  http.post(url,
      headers: {"Content-Type": "application/json"},
      body:json.encode( {
        "request_id": reply.request_id,
        "user_id": reply.user_id,
        "reply_detail":reply.reply_detail,
        "image_url": reply.image_url,
        "state": true
      } ) );
  response.toString();
  }

  static Future <List<Reply>> getRepliesByRequestID (int requestid)
  async {

    String url = Global.url+"Reply/GetRepliesByRequestID?RequestId="+requestid.toString();
    final response = await http.get(url,headers:{"Content-Type": "application/json"});
    var jsonData = json.decode(response.body);
    List<Reply> usersReply =[];
    for(var i in jsonData)
    {

      String date =i['reply_date'].toString().substring(0,10);
      //String time = i['reply_time'].toString().substring(0,5);
      //merchant_id equals Global.loginUser.id
      Reply reply = Reply.id(i['id'],i['request_id'],i['user_id'],i['reply_detail'],date,"",i['image_url'],i['state']);
      usersReply.add(reply);
    }

    return usersReply;
  }

}

