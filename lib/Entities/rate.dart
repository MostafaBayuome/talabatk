import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../Screens/customer/customer_requests_layout.dart';
import 'global.dart';
import 'package:http/http.dart' as http;
class Rate{
int id ;
String title_en;
String title_ar;
Color selected ;

Rate( this.id, this.title_en, this.title_ar,this.selected);
  static Future <List<Rate>> getRates () async {
   List<Rate>rateList=[];
    String url = Global.url+"Rate/GetAllRate";
    final response = await http.get(url,headers:{"Content-Type": "application/json"});
    var jsonData = json.decode(response.body);

    for(var i in jsonData)
    {
      Rate rate = Rate(i['id'],i['title_en'],i['title_ar'],Colors.black);
     rateList.add(rate);
    }
    return rateList;
  }
}