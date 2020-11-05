import 'package:flutter/cupertino.dart';
import 'package:geolocator/geolocator.dart';
import 'global.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart' as http;
import 'dart:convert';

class DeliveryLocation {
   int id;
   int user_id;
   double latitude;
   double longitude;
   String record_Date;
   String record_Time;

   DeliveryLocation(this.id, this.user_id, this.latitude, this.longitude, this.record_Date, this.record_Time);
   DeliveryLocation.empty();
  // Add location to Location table
  static Future<String> addCurrentLocation (int user_id,Position position) async {
    try{

      String url= Global.url+"delevvity_Locations/Addelevvity_Locations";
      final response= await  http.post(url,
          headers: {"Content-Type": "application/json"},
          body:json.encode( {
            "user_id": user_id,
            "latitude": position.latitude,
            "longitude": position.longitude,

          } )
      );
      return  "Done";
    }catch(Excepetion)
    {
      print(Excepetion);
    }
  }


  // get all user locations from Location table
  static Future <DeliveryLocation> GetByIdLastLocation(int User_id) async {
     String url =Global.url+"delevvity_Locations/GetByIdLastLocation?Id="+User_id.toString();
    final response = await http.get(url,headers:{"Content-Type": "application/json"});
    var data = json.decode(response.body);

     DeliveryLocation location = new DeliveryLocation(data['id'], data['user_id'],  data['latitude'], data['longitude'],  data['record_Date'], data['record_Time']);

    return location;
  }

}