import 'package:Talabatk/Widgets/utils.dart';
import 'package:flutter/material.dart';


class DeliveryHomePage extends StatefulWidget {
  @override
  _DeliveryHomePageState createState() => _DeliveryHomePageState();
}

class _DeliveryHomePageState extends State<DeliveryHomePage> {

  String _title="Home Page";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Utils.appBarusers(context, _title),
      body: Padding(
        padding: EdgeInsets.all(20.0),
          child:  Text('hey'),
      ),
    );
  }

}
