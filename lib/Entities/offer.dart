import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:Talabatk/Entities/global.dart';
import 'dart:typed_data';

class Offer {

  int shopid;
  String date;
  String dateExpired;
  String imageUrl;
  String description;
  Uint8List image_byte;

  Offer(this.shopid, this.date, this.dateExpired, this.imageUrl,
      this.description, this.image_byte);

  static Future<void> addOffer(String apiName, Offer offer) async {
    String url = Global.url+apiName;
    final response= await  http.post(url,
        headers: {"Content-Type": "application/json"},
        body:json.encode( {
          "shopId": offer.shopid,
          "date": offer.date,
          "dateExpired":offer.dateExpired,
          "image_Url": offer.imageUrl,
          "description":  offer.description,
          "image_byte":base64.encode(offer.image_byte)

        } ) );
    response.toString();
    //future work return int to work on requests
  }


  static  Future<List<Offer>> getOfferByShopId(int id) async {

    try{
      //http://talabatk.maxsystem-eg.com/api/Offer/GetByShopId?Id=11
      String url =Global.url+"Offer/GetByShopId?Id="+id.toString();
      final response = await http.get(url,headers:{"Content-Type": "application/json"});
      if(response.statusCode==200){
        var jsonData = json.decode(response.body);
        List<Offer> offers = [];
        for(var i in jsonData)
        {
          Offer offer = Offer(i['id'],i['date'],i['dateExpired'],i['image_Url'],i['description'],i['image_byte']);
          offers.add(offer);
        }
        return offers;
    }
      else{
        return null;
      }
    }
    catch(exception){
      throw exception;
    }





   }

}