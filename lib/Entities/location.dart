import 'global.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class Location {
  final int  id;
  final int user_id;
  final double latitude;
  final double longitude;
  final String title;
  final String note;
  Location(this.id, this.user_id, this.latitude, this.longitude, this.title, this.note);


  // Add location to Location table
  static Future<Map<String, dynamic>> addLocation (String apiName,int  user_id,double latitude,double longitude,String title,String note) async {
    try{
      String url= Global.url+apiName;
      final response= await  http.post(url,
          headers: {"Content-Type": "application/json"},
          body:json.encode( {
            "user_id": user_id,
            "latitude": latitude,
            "longitude": longitude,
            "title": title,
            "note": note
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
  static Future <List<Location>> getByIdLocation(String apiName) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String url =Global.url+apiName+"?Id="+prefs.getInt('id').toString();
    final response = await http.get(url,headers:{"Content-Type": "application/json"});
    var jsonData = json.decode(response.body);
    List<Location> locations = [];
    for(var i in jsonData) {
      Location location = Location(i['id'],i['user_id'],i['latitude'],i['longitude'],i['title'],i['note']);
      locations.add(location);
    }
    return locations;
  }


  static Future <Location>GetLocationsById(int id) async {

    String url =Global.url+"Location/GetLocationsById"+"?Id="+id.toString();
    final response = await http.get(url,headers:{"Content-Type": "application/json"});
    var jsonData = json.decode(response.body);

    for(var i in jsonData) {
      Location location = Location(i['id'],i['user_id'],i['latitude'],i['longitude'],i['title'],i['note']);
      return location;
    }

  }


}