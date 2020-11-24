import 'package:Talabatk/Entities/app_localizations.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomSpinner extends StatefulWidget{
@override
CustomSpinnerWidget createState() => CustomSpinnerWidget();
}

class CustomSpinnerWidget extends State {



  @override
  Widget build(BuildContext context) {
    String dropdownValue = AppLocalizations.of(context).translate('customer');
    List <String> spinnerItems = [
      AppLocalizations.of(context).translate('customer'),
      AppLocalizations.of(context).translate('super_market'),
      AppLocalizations.of(context).translate('pharmacy'),
      AppLocalizations.of(context).translate('restaurant'),
      AppLocalizations.of(context).translate('atara'),
    ];
    return Scaffold(
      body: Center(
        child : Column(children: <Widget>[
          DropdownButton<String>(
            value: dropdownValue,
            onChanged: (String data) {
              setState(() {
                dropdownValue = data;
              });
            },
            items: spinnerItems.map<DropdownMenuItem<String>>((String value) {
              return new DropdownMenuItem<String>(
                value: value,
                child: new  Text(value),
              );
            }).toList(),
          ),
        ]),
      ),
    );
  }


}