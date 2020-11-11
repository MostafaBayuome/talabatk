import 'dart:convert';
import 'package:Talabatk/Entities/global.dart';
import 'package:http/http.dart' as http;
import 'dart:typed_data';
// states of Request
// 0 = waiting, 1 = on delivery, 2 = delivered/done, 3 = deleted/canceled
class Request {

  int id;
  int user_id;
  String user_name;
  int merchant_id;
  String merchantname;
  int location_id;
  String request_date;
  String request_time;
  String details;
  String image_url;
  String image_url2;
  Uint8List imagebyte;
  Uint8List imagebyte2;
  int state;
  int delivery_id;

  Request.empty();
  Request(this.id, this.user_id,this.merchant_id, this.location_id, this.request_date, this.request_time, this.details ,this.image_url,this.image_url2,this.state,this.user_name,this.delivery_id);

  static Future<void> addRequest(String apiName,int user_id,int merchant_id,int location_id,
      String request_data,String request_time,String details, String image_url, String image_url2, Uint8List imagebyte,Uint8List imagebyte2) async {

    String url = Global.url+apiName;
    final response= await  http.post(url,
        headers: {"Content-Type": "application/json"},
         body:json.encode( {
           "user_id": user_id,
           "merchant_id": merchant_id,
           "location_id":location_id,
           "details": details,
           "image_url":  image_url,
           "image_url2": image_url2,
           "image_bytel":base64.encode(imagebyte),
           "image_byte2":base64.encode(imagebyte2),
           "state": 0
         } ) );

      response.toString();
      //future work return int to work on requests
  }

  static Future<void> addRequest1(String apiName,int user_id,int merchant_id,int location_id,
      String request_data,String request_time,String details, String image_url, String image_url2, Uint8List imagebyte,Uint8List imagebyte2) async {

    String url = Global.url+apiName;
    final response= await  http.post(url,
        headers: {"Content-Type": "application/json"},
        body:json.encode( {
          "user_id": user_id,
          "merchant_id": merchant_id,
          "location_id":location_id,
          "details": details,
          "image_url":  image_url,
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

  // get all requests for shop with its id
  static Future <List<Request>> getShopRequests  () async {
    String url =Global.url+"Request/GetByMerchantId?merchantid="+Global.loginUser.id.toString();
    final response = await http.get(url,headers:{"Content-Type": "application/json"});
    var jsonData = json.decode(response.body);
    List<Request> customerRequest =[];
    for(var i in jsonData)
    {

      String date =i['request_Date'].toString().substring(0,10);
      String time = i['request_Time'].toString().substring(0,5);
      // merchant_id equals Global.loginUser.id
      Request request = Request(i['request_id'],i['request_user_id'],i['request_merchant_id'],i['request_location_id'],date,time,i['request_details'],i['request_image_url'],i['request_image_url2'],i['request_state'],i['user_name'],i['request_delivery_id']);
      customerRequest.add(request); }
      return customerRequest;

     }

  //get all Customers request with all its states
  static Future <List<Request>> getCustumerRequests  () async {
    String url =Global.url+"Request/GetByUserId?userid="+Global.loginUser.id.toString();
    final response = await http.get(url,headers:{"Content-Type": "application/json"});
    var jsonData = json.decode(response.body);
    List<Request> customerRequest =[];
    for(var i in jsonData)
    {

     String date =i['request_Date'].toString().substring(0,10);
     String time = i['request_Time'].toString().substring(0,5);
      // merchant_id equals Global.loginUser.id
      Request request = Request(i['request_id'],i['request_user_id'],i['request_merchant_id'],i['request_location_id'],date,time,i['request_details'],i['request_image_url'],i['request_image_url2'],i['request_state'],i['user_name'],i['request_delivery_id']);
      customerRequest.add(request);
    }
    return customerRequest;
  }

  // state 0 = waiting, 1 = on delivery, 2 = delivered/done, 3 = deleted/canceled
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
         "state": state,
         "delivery_id":request.delivery_id,
         "request_date":request.request_date,
         "request_time":request.request_time
       } ) );
  response.toString();
  }

  // get all requests attached to deliveryMan
  static Future <List<Request>> getRequestsAttachedToDeliveryMan  () async {

    String url =Global.url+"Request/GetByDeliveryId?deliveryid="+Global.loginUser.id.toString();
    final response = await http.get(url,headers:{"Content-Type": "application/json"});
    var jsonData = json.decode(response.body);
    List<Request> customerRequest =[];
    for(var i in jsonData)
    {
      String date =i['request_Date'].toString().substring(0,10);
      String time = i['request_Time'].toString().substring(0,5);
      Request request = Request(i['request_id'],i['request_user_id'],i['request_merchant_id'],i['request_location_id'],date,time,i['request_details'],i['request_image_url'],i['request_image_url2'],i['request_state'],i['user_name'],i['delivery_id']);
      customerRequest.add(request);
    }
     return customerRequest;
  }

  static Future <String> drawImageFromServer  (String image_url) async {
    String url =Global.url+"Request/api/DrawImage_FromServer?imgurl="+image_url;
    final response = await http.get(url,headers:{"Content-Type": "application/json"});
    var jsonData = json.decode(response.body);
    var temp =jsonData;
    return temp;
  }
}

