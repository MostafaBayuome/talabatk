import 'dart:convert';
import 'package:Talabatk/Entities/global.dart';
import 'package:http/http.dart' as http;

class Request {

  int id;
  int user_id;
  int merchant_id;
  int location_id;
  String request_date;
  String request_time;
  String details;
  String image_url;
  String image_url2;
  int state;

  Request.empty();
  Request(this.id, this.user_id,this.merchant_id, this.location_id, this.request_date, this.request_time, this.details ,this.image_url,this.image_url2,this.state);

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

      response.toString();
      //future work return int to work on requests
  }

  static Future <List<Request>> getRequestsByUser(int id) async {

    String url =Global.url+"Request/GetAllRequestuest?UserId="+Global.loginUser.id.toString();
    final response = await http.get(url,headers:{"Content-Type": "application/json"});
    var jsonData = json.decode(response.body);
    List<Request> Requests=(jsonData as List).map((i) => Request.fromJson(i)).toList();
    return Requests;
  }

  static fromJson(Map model) {
    Request req=new Request.empty();
    req.id=model['id'];
    req.user_id=model['user_id'];
    req.merchant_id=model['merchant_id'];
    req.location_id=model['location_id'];
    req.request_date=model['request_date'];
    req.request_time=model['request_time'];
    req.details=model['details'];
    req.image_url=model['image_url'];
    req.state=model['state'];
    return req;
  }

  // get all requests for exact shop to display requests to shop_home_page
  static Future <List<Request>> getShopRequests  () async
  {
    String url =Global.url+"Request/GetByMerchantId?merchantid="+Global.loginUser.id.toString();
    final response = await http.get(url,headers:{"Content-Type": "application/json"});
    var jsonData = json.decode(response.body);
    List<Request> customerRequest =[];
    for(var i in jsonData)
    {

      String date =i['request_date'].toString().substring(0,10);
      String time = i['request_time'].toString().substring(0,5);
      // merchant_id equals Global.loginUser.id
      Request request = Request(i['id'],i['user_id'],i['merchant_id'],i['location_id'],date,time,i['details'],i['image_url'],i['image_url2'],i['state']);
      customerRequest.add(request);
    }
    
    return customerRequest;

  }
  static Future <List<Request>> getCustumerRequests  () async
  {
    String url =Global.url+"Request/GetByUserId?userid="+Global.loginUser.id.toString();
    final response = await http.get(url,headers:{"Content-Type": "application/json"});
    var jsonData = json.decode(response.body);
    List<Request> customerRequest =[];
    for(var i in jsonData)
    {

      String date =i['request_date'].toString().substring(0,10);
      String time = i['request_time'].toString().substring(0,5);
      // merchant_id equals Global.loginUser.id
      Request request = Request(i['id'],i['user_id'],i['merchant_id'],i['location_id'],date,time,i['details'],i['image_url'],i['image_url2'],i['state']);
      customerRequest.add(request);
    }

    return customerRequest;



  }

  static Future <void> editRequest (Request request, int state) async {
   String url = Global.url+"Request/EditRequest";
   final response= await  http.put(url,
       headers: {"Content-Type": "application/json"},
       body:json.encode( {
         "id": request.id,
         "user_id": request.user_id,
         "merchant_id": request.merchant_id,
         "location_id":request.location_id,
         "details": request.details,
         "image_url": request.image_url,
         "image_url2": request.image_url2,
         "state": state
       } ) );
  response.toString();
  }


}

