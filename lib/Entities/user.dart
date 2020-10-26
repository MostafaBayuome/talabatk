 import 'dart:convert';
 import 'package:http/http.dart' as http;
import 'global.dart';

class User {

  int id;
  String mobileNumber;
  num latitude;
  num longitude;
  String userName;
  String password;
  String note;
  int mapAppear;
  int merchant_id;

  User.empty();
  User(this.id, this.mobileNumber, this.latitude, this.longitude, this.userName,
      this.password, this.mapAppear,this.merchant_id);
  // get all nearest shops
   static Future <List<User>> getNearestShops(String apiName,String phone) async {
     String url =Global.url+apiName+"?mobileNumber="+phone;
     final response = await http.get(url,headers:{"Content-Type": "application/json"});
     var jsonData = json.decode(response.body);
     List<User> nearestShop =[];
     for(var i in jsonData)
     {
       User user = User(i['id'],i['phone'],i['latitude'],i['longitude'],i['username'],i['password'],i['map_Appear'],i['merchant_id']);
       nearestShop.add(user);
     }
     return nearestShop;
   }

   static Future <List<User>> getUserByMerchantId(int merchant_id) async {
     String url =Global.url+"Talabatk/GetUserByMerchantId?merchant_id="+merchant_id.toString();
     final response = await http.get(url,headers:{"Content-Type": "application/json"});
     var jsonData = json.decode(response.body);
     List<User> deliveryMen =[];
     for(var i in jsonData)
     {
       try{
         User user = User(i['id'],i['phone'],i['latitude'],i['longitude'],i['username'],i['password'],i['map_Appear'],i['merchant_id']);
         deliveryMen.add(user);
       }
       catch(Exception)
       {
         print(Exception);
       }

     }

     return deliveryMen;
   }

}