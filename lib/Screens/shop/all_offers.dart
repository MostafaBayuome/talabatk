import 'package:flutter/material.dart';
import 'package:Talabatk/Widgets/utils.dart';
import 'package:Talabatk/Entities/app_localizations.dart';
class AllOffers extends StatefulWidget {
  @override
  _State createState() => _State();
}

class _State extends State<AllOffers> {


  @override
  Widget build(BuildContext context) {
    String _title= AppLocalizations.of(context).translate('all_offers');
    return Scaffold(
      appBar: Utils.appBarusers(context,_title),
      body: Padding(
          padding: EdgeInsets.all(10),
          child: ListView(
              children: <Widget>[

                Container(margin: EdgeInsets.only(top:25.0),),
                Container(
                  padding: EdgeInsets.all(20),
                  child: Column(
                    children: [



                    ],
                  ) ,
                )


              ]
          )
      ),
    );
  }
}