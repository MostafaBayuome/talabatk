import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomSpinner extends StatefulWidget{
@override
CustomSpinnerWidget createState() => CustomSpinnerWidget();
}

class CustomSpinnerWidget extends State {
  String dropdownValue = 'مستخدم';

  List <String> spinnerItems = [
    'مستخدم',
    'محل تجاري',
    'صيدلية'
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child :
        Column(children: <Widget>[
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