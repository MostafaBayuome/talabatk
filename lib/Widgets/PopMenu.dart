import 'package:Talabatk/Entities/user.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:Talabatk/Entities/global.dart';

class PopMenu extends StatefulWidget {
  PopMenu(List<User> delivery_men);

  @override
  PopMenuWidget createState() => PopMenuWidget();
}

class PopMenuWidget extends State {
  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<User>(
      onSelected: (User value) {
        setState(() {
          Global.selectedDeleviry = value;
        });
      },
      child: ListTile(
        leading: IconButton(
          icon: Icon(Icons.two_wheeler),

        ),
        title: Text('Deleviry Men'),
        subtitle: Column(
          children: <Widget>[
            Text('Choose One'),
          ],
        ),
        trailing: Icon(Icons.account_circle),
      ),
      itemBuilder: (BuildContext context) => <PopupMenuEntry<User>>[
          
      ],
    )
  }


}