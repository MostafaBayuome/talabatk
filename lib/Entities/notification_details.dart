import 'dart:convert';
import 'package:flutter/cupertino.dart';

import 'global.dart';
import 'package:http/http.dart' as http;
class NotificationDetails {
  int id;
  int user_id;
  String type;
  String description;
  bool seen;
  String record_Date;
  String record_Time;
  NotificationDetails.empty();

  static fromJson(Map model) {

    NotificationDetails Not=new NotificationDetails.empty();
    Not.id=model['id'];
    Not.user_id=model['user_id'];
    Not.type=model['Type'];
    Not.description=model['Description'];
    Not.seen=model['seen'];
    Not.record_Date=model['record_date'];
    Not.record_Time=model['record_time'];

    return Not;
  }

  static Future<List<NotificationDetails>> getMyNotification() async {
      String url =Global.url+"notifications/GetAllNotificationsByUserId?Id="+Global.loginUser.id.toString();
      var response = await http.get(url,headers:{"Content-Type": "application/json"});
      var jsonData = json.decode(response.body);
      List<NotificationDetails>notifications=[];
      try{
        for(var i in jsonData){
          NotificationDetails temp=new NotificationDetails.empty();
          temp.id=i['id'];
          temp.user_id=i['user_id'];
          temp.type=i['type'];
          temp.description=i['description'];
          temp.seen=i['seen'];
          temp.record_Date=i['record_Date'].toString().substring(0,10);
          temp.record_Time=i['record_Time'].toString().substring(0,5);
          notifications.add(temp);
        }
       if(notifications.length>0){
           return notifications;
      }
      return null;
      }catch(e){
        String ee=e.toString();
      }
  }

  Map<String,dynamic> toJson() {
    Map<String,dynamic> toJson(){
      return {
        "id": this.id,
        "user_id": this.user_id,
        "Type": this.type,
        "seen": this.seen,
        "Description": this.description,
        "record_date": this.record_Date,
        "record_time": this.record_Time
      };}
  }


  static Future <void> editNotification (NotificationDetails notifications) async {
    String url = Global.url+"notifications/Updatenotifications";
    final response= await  http.put(url,
        headers: {"Content-Type": "application/json"},
        body:json.encode( {
          "id": notifications.id,
          "user_id": notifications.user_id,
          "merchant_id": notifications.type,
          "description":notifications.description,
          "seen": true,
          "record_Date": notifications.record_Date,
          "record_Time": notifications.record_Time,
        } ) );
    response.toString();
  }
}