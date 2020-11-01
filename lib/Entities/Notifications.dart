
import 'dart:convert';

import 'deleviry_Location.dart';
import 'global.dart';
import 'package:http/http.dart' as http;
class Notifications {
  int id;
  int user_id;
  String Type;
  String Description;
  bool seen;
  String record_date;
  String record_time;
  Notifications.empty();
  static fromJson(Map model) {
    Notifications Not=new Notifications.empty();
    Not.id=model['id'];
    Not.user_id=model['user_id'];
    Not.Type=model['Type'];
    Not.Description=model['Description'];
    Not.seen=model['seen'];
    Not.record_date=model['record_date'];
    Not.record_time=model['record_time'];

    return Not;
  }

  static getMyNotification() async {
      String url =Global.url+"GetAllNotificationsByUserId?Id="+Global.loginUser.id.toString();
      var response = await http.get(url,headers:{"Content-Type": "application/json"});
      var jsonData = json.decode(response.body);
      List<Notifications> notification=(jsonData as List).map((i) => Notifications.fromJson(i)).toList();
      if(notification.isNotEmpty){
        Global.userNotifications.addAll(notification);
        url = Global.url+"notifications/EditSeenForUser?Id="+Global.loginUser.id.toString()+"&seen=true";
        response= await  http.put(url,
            headers: {"Content-Type": "application/json"},
            body:json.encode( {"id": 1} )
        );
        Global.
      }



  }

}