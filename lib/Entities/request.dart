import 'dart:convert';

import 'package:talabatk_flutter/Entities/global.dart';
import 'package:http/http.dart' as http;

class Request {


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
}