import 'package:flutter/material.dart';

class StringWidget extends StatelessWidget {

   bool vi;
   StringWidget({ Key key, this.vi}):super(key: key);


  @override
  Widget build(BuildContext context) {
    return Center(
      child:
        CircularProgressIndicator()
    );
  }
}