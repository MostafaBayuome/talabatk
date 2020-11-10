import 'dart:convert';
import 'global.dart';
import 'package:http/http.dart' as http;
class User_rate {

  int id;
  int user_id;
  int merchant_id;
  int rate_id;
  String comment;
  String note;

User_rate(this.id, this.user_id, this.merchant_id, this.rate_id, this.comment,
      this.note);
  User_rate.empty();

  static Future <List<User_rate>> getUserRates (int user_id) async {

    String url = Global.url+"User_rate/GetAllUser-rate";
    final response = await http.get(url,headers:{"Content-Type": "application/json"});
    var jsonData = json.decode(response.body);
    List<User_rate> usersRates =[];
    for(var i in jsonData)
    {
      User_rate user_rate = User_rate(i['id'],i['user_id'],i['merchant_id'],i['rate_id'],i['comment'],i['note']);
      usersRates.add(user_rate);
    }
    return usersRates;
  }
  static Future<String> addUserRate(User_rate user_rate) async {

    String url = Global.url+"User_rate/AddUser_rate";
    final response= await  http.post(url,
        headers: {"Content-Type": "application/json"},
        body:json.encode( {
          "merchant_id": user_rate.merchant_id,
          "user_id": user_rate.user_id,
          "rate_id":user_rate.rate_id,
          "comment": user_rate.comment,
          "note": user_rate.note
        } ) );
   return response.toString();
  }
}
