import 'dart:convert';

import 'package:talabatk_flutter/Entities/global.dart';
import 'package:http/http.dart' as http;

class Request {

  int id;
  int user_id;
  int merchant_id;
  int location_id ;
  String request_date;
  String request_time;
  String details;
  String image_url;
  String image_url2;
  int state;
  Request.empty();
  Request(id, user_id,merchant_id, location_id, request_date, request_time, details ,image_url,state);

  static Future<void> addRequest(String apiName,int user_id,int merchant_id,int location_id,
      String request_data,String request_time,String details, String image_url, String image_url2) async {

    String url = Global.url+apiName;
    final response= await  http.post(url,
        headers: {"Content-Type": "application/json"},
         body:json.encode( {
           "user_id": user_id,
           "merchant_id": merchant_id,
           "location_id":location_id,
           "details": details,
           "image_url": image_url,
           "image_url2": image_url2,
           "state": 0
         } ) );

     String response1= response.toString();
  }
  static Future <List<Request>> getRequestsByUser(int id) async {

    String url =Global.url+"Request/GetAllRequestuest?UserId="+Global.loginUser.id.toString();
    final response = await http.get(url,headers:{"Content-Type": "application/json"});
    var jsonData = json.decode(response.body);

    //List<Request> Requests = List<Request>.from(jsonData).map((Map model)=> Request.fromJson(model)).toList();

    List<Request> Requests=(jsonData as List).map((i) =>
        Request.fromJson(i)).toList();
    for(var i in jsonData)
    {
      Request request = Request(i['id'],i['user_id'],i['merchant_id'],i['location_id'],i['request_date'],i['request_time'],i['details'],i['image_url'],i['state']);
      Requests.add(request);
    }
    return Requests;
  }

  static fromJson(Map model) {
    Request req=new Request.empty();
    req.id=model['id'];req.user_id=model['user_id'];req.merchant_id=model['merchant_id'];
    req.location_id=model['location_id'];req.request_date=model['request_date'];
    req.request_time=model['request_time'];req.details=model['details'];
    req.image_url=model['image_url'];req.state=model['state'];
    return req;
  }


}