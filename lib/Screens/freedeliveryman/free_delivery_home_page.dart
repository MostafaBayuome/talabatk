import 'package:Talabatk/Entities/app_localizations.dart';
import 'package:Talabatk/Widgets/utils.dart';
import 'package:flutter/material.dart';


class FreeDeliveryHomePage extends StatefulWidget {
  @override
  _FreeDeliveryHomePageState createState() => _FreeDeliveryHomePageState();
}

class _FreeDeliveryHomePageState extends State<FreeDeliveryHomePage> {

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    String _title=AppLocalizations.of(context).translate('home_page');
    return Scaffold(
      appBar: Utils.appBarusers(context,_title),
      body: Container(

      ),
    );
  }

}
