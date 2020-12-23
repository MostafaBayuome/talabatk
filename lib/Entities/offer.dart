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

}