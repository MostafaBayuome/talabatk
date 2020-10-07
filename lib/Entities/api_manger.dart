import 'package:http/http.dart' as http;
import 'location.dart';
import 'dart:convert';
import 'global.dart';

Future<String> signUp (String apiName,String phone,String password,String username,double latitude,double longitude,bool state,String account_type) async {
  try{
    int map_Appear=0;
    if(account_type=="صيدلية")     map_Appear=2;
    else if(account_type=="محل تجاري")     map_Appear=1;
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
      if(map_Appear>0)
        Location.addLocation("Location/AddLocation",int.parse(convertDatatoJson),latitude,longitude,username," ");
      else
        Location.addLocation("Location/AddLocation",int.parse(convertDatatoJson),latitude,longitude,"المكان الرئيسي"," ");
    }
    return  convertDatatoJson;

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


