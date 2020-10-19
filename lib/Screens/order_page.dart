import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:Talabatk/Entities/global.dart';

class OrderHomePage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => _State();
}

class _State extends State<OrderHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(Global.appName),
        automaticallyImplyLeading: false,
        backgroundColor: Color(int.parse(Global.primaryColor)),
      ),
      body: Padding(
        padding: EdgeInsets.fromLTRB(20, 70, 20, 20),
        child: ListView(
            children: <Widget>[
              Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.all(10),
                  child: Text(
                    'Order Page',
                    style: TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.w500,
                        fontSize: 30),
                  )),
              SizedBox(height: 25),
              Container(
                child:    TextFormField(
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: 'Description',
                  ),),
              ),
              SizedBox(height: 20),
              Container(
                  height: 50,
                  padding: EdgeInsets.fromLTRB(110, 10, 110, 10),
                  child: RaisedButton(
                    textColor: Colors.white,
                    color: Colors.blue,
                    child: Text('Upload Photo'),
                    onPressed: () {

                    },
                  )),
              SizedBox(height: 20),
              Container(
                  child: Row(
                    children: <Widget>[
                      Text('Add another Location', style: TextStyle(fontSize: 15),),
                      FlatButton(
                        child: IconButton(
                          icon: Icon(Icons.place),
                          color: Colors.red,
                          onPressed: () {

                            },
                        ),
                      )
                    ],
                    mainAxisAlignment: MainAxisAlignment.center,
                  )),
              SizedBox(height: 30),
              Container(
                  height: 50,
                  padding: EdgeInsets.fromLTRB(80, 5, 80, 5),
                  child: RaisedButton(
                    textColor: Colors.white,
                    color: Colors.blue,
                    child: Text('Confirm'),
                    onPressed: () {

                    },
                  ))
                  ]
      ),
    ));
  }
}
