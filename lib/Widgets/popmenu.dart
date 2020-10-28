import 'package:Talabatk/Entities/user.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:Talabatk/Entities/global.dart';

class PopMenu extends StatefulWidget {
  List<User> delivery_men;
  PopMenu({Key key, @required this.delivery_men}): super(key: key);

  @override
  PopMenuWidget createState() => PopMenuWidget(delivery_men);
}

class PopMenuWidget extends State {
  List<User> delivery_men;
  PopMenuWidget(this.delivery_men);
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
          icon: Icon(Icons.motorcycle),
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
    );

  }


}