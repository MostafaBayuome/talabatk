import 'package:geolocator/geolocator.dart';
import 'global.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class DeliveryLocation {
   int id;
   int user_id;
   double latitude;
   double longitude;
   String record_date;
   String record_time;
   DeliveryLocation(this.id, this.user_id, this.latitude, this.longitude, this.record_date, this.record_time);
   DeliveryLocation.empty();
  // Add location to Location table
  static Future<Map<String, dynamic>> addCurrentLocation (int user_id) async {
    try{
     var position =  await getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
      String url= Global.url+"deleviry_location/add_DeleviryLocation";
      final response= await  http.post(url,
          headers: {"Content-Type": "application/json"},
          body:json.encode( {
            "user_id": user_id,
            "latitude": position.latitude,
            "longitude": position.longitude,
            "record_date": "",
            "record_time": "",

          } )
      );
      Map<String, dynamic> convert =  json.decode(response.body);
      return  convert;
    }catch(Excepetion)
    {
      print(Excepetion);
    }
  }


  // get all user locations from Location table
  static Future <DeliveryLocation> getLastLocation(int User_id) async {
     String url =Global.url+"deleviry_location/getLastLocationByUserId?Id="+User_id.toString();
    final response = await http.get(url,headers:{"Content-Type": "application/json"});
    var jsonData = json.decode(response.body);
     DeliveryLocation location ;
     location=fromJson(jsonData);
    return location;
  }
  static  fromJson(Map model) {
    DeliveryLocation location=new DeliveryLocation.empty();
    location.id=model['id'];
    location.user_id=model['user_id'];
    location.latitude=model['merchant_id'];
    location.longitude=model['location_id'];
    location.record_date=model['request_date'];
    location.record_time=model['request_time'];
    return location;
  }

}