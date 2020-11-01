import 'package:Talabatk/Entities/user.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:Talabatk/Entities/global.dart';

class PopMenu extends StatefulWidget {
  List<User> delivery_men;

  @override
  PopMenuWidget createState() => PopMenuWidget();
}

class PopMenuWidget extends State {
  List<User> delivery_men;

  @override
  Widget build(BuildContext context) {

    return PopupMenuButton(
      onSelected: (User value) {
        setState(() {
          Global.selectedDeleviry = value;
        });
      },
      child: ListTile(
        leading: IconButton(
          icon: Icon(Icons.motorcycle),
        ),
        title: Text('الطيارين'),
        subtitle: Column(
          children: <Widget>[
            Text('Choose One'),
          ],
        ),
        trailing: Icon(Icons.account_circle),
      ),
        itemBuilder: (BuildContext context) {
          return delivery_men.map((User choice) {
            return PopupMenuItem(
              value: choice,
              child: Text(choice.userName , textAlign: TextAlign.center,),
            );
          }).toList();
        },

    );

  }

}