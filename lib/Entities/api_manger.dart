import 'package:http/http.dart' as http;
import 'location.dart';
import 'dart:convert';
import 'global.dart';

Future<Map<String, dynamic>> signUp (String apiName,String phone,String password,String username,double latitude,double longitude,bool state,int  map_Appear) async {
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
          "map_Appear": map_Appear
        } )
    );
    var convertDatatoJson =  response.body;

    if(!convertDatatoJson.contains("user_exist"))
    {
      Map<String, dynamic> convert =  json.decode(response.body);
      if(map_Appear>0)
        Location.addLocation("Location/AddLocation",convert['id'],latitude,longitude,username," ");
      else
        Location.addLocation("Location/AddLocation",convert['id'],latitude,longitude,"المكان الرئيسي"," ");

      return convert;
    }

    return  null;

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


