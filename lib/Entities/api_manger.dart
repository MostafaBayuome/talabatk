import 'package:http/http.dart' as http;
import 'location.dart';
import 'dart:convert';
import 'global.dart';


// merchant_id = 0 if its (shop, pharmacy, customer)
Future<Map<String, dynamic>> signUp (String apiName,String phone,String password,String username,double latitude,double longitude,bool state,int  map_Appear,int merchant_id) async {
  try{

    String url = Global.url+apiName;
    final response= await  http.post(url,
        headers: {"Content-Type": "application/json"},
        body:json.encode( {
          "phone": phone,
          "password": password,
          "username":username,
          "latitude": latitude,
          "longitude": longitude,
          "state": state,
          "map_Appear": map_Appear,
          "merchant_id":merchant_id
        } )
    );
    var convertDatatoJson =  response.body;
    Map<String, dynamic> convert;
    if(!convertDatatoJson.contains("user_exist")) {
        convert =json.decode(response.body);
       if (map_Appear > 0)
          Location.addLocation("Location/AddLocation", convert['id'], latitude, longitude, username, " ");
       else
          Location.addLocation("Location/AddLocation", convert['id'], latitude, longitude, "المكان الرئيسي", " ");

    }
    else{
      return null;
    }
    return convert;

  }catch(Excepetion)
  {
    print(Excepetion);
    return Excepetion;
  }
}

Future<Map<String, dynamic>> loginUser (String apiName, String mobileNumber , String password) async {

  try{
    String url =Global.url+apiName;
    final response = await http.get(url+"?mobileNumber="+mobileNumber,headers:{"Content-Type": "application/json"} );
    Map<String, dynamic> convertDatatoJson =  json.decode(response.body);
    if(password==convertDatatoJson["password"])
    {
      return  convertDatatoJson;
    }
    return null;
  }
  catch (Excepetion)
  {
    print(Excepetion);
    return null;
  }

}



