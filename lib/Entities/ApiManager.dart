import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'global.dart';



Future<String> signUp (String apiName,String phone,String password,String username,double latitude,double longitude,bool state,bool map_Appear) async {
  try{

    String url= Global.url+apiName;
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
    return  convertDatatoJson;

  }catch(Excepetion)
  {
    print(Excepetion);
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


