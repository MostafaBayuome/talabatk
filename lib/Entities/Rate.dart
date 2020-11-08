import 'dart:convert';
import 'global.dart';
import 'package:http/http.dart' as http;
class Rate{
int id ;
String title_en;
String title_ar;
static List<Rate>rateList=[];
Rate( this.id, this.title_en, this.title_ar);
  static Future <List<Rate>> getRates () async {
    if(rateList.length>0)return rateList;
    String url = Global.url+"Rate/GetAllRate";
    final response = await http.get(url,headers:{"Content-Type": "application/json"});
    var jsonData = json.decode(response.body);

    for(var i in jsonData)
    {
      Rate rate = Rate(i['id'],i['title_en'],i['title_ar']);
     rateList.add(rate);
    }
    return rateList;
  }
}