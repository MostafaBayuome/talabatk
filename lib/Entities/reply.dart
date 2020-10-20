import 'dart:convert';

import 'package:Talabatk/Entities/global.dart';
import 'package:http/http.dart' as http;


class Reply {

int request_id;
int user_id;
String reply_detail;
String reply_date;
String reply_time;
String image_url;
bool state;

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
  //future work return int to work on requests
}

}

