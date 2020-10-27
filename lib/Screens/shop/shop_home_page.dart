import 'package:Talabatk/Entities/constants.dart';
import 'package:Talabatk/Entities/global.dart';
import 'package:Talabatk/Screens/shop/add_delivery.dart';
import 'package:Talabatk/Screens/shop/shop_request_layout.dart';
import 'package:Talabatk/Widgets/utils.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../signup.dart';
import 'display_all_delivery_men.dart';

class ShopHomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _State();
}

class _State extends State<ShopHomePage>{

  @override
  Widget build(BuildContext context) {


    return  Scaffold (
        appBar: AppBar(
          backgroundColor:  Color(int.parse(Global.primaryColor)),
          title: Text(Global.appName),
          automaticallyImplyLeading: false,
          actions: [
            PopupMenuButton<String>(
              onSelected: (value){
                Utils.choiceAction(value, context);
              },
              itemBuilder: (BuildContext context){
                return Constants.singleChoice.map((String choice){
                  return PopupMenuItem<String>(
                    value: choice,
                    child: Text(choice,style: TextStyle(
                        color: Color(int.parse(Global.primaryColor))
                    ),),

                  );
                }).toList();
              },
            )
          ],
        ),
        body: Center(

          child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
              RaisedButton(
              onPressed: () {

                Navigator.of(context).push(MaterialPageRoute(
                builder: (context) =>addDeliveryman()
                ));
                },
                    color: Color(int.parse(Global.primaryColor)),
                    elevation: 10.0,
                    textColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0),
                    ),
                    padding: const EdgeInsets.all(0.0),
                    child: Container(
                      padding: const EdgeInsets.all(10.0),
                      child: const Text(
                          'اضافه طيار',
                          style: TextStyle(fontSize: 20)
                      ),
                    ))
                  ,
                const SizedBox(height: 100),
                RaisedButton(
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) =>DisplayAllDeliveryMen()
                      ));
                    },
                    color: Color(int.parse(Global.primaryColor)),
                    elevation: 10.0,
                    textColor: Colors.white,
                    padding: const EdgeInsets.all(0.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0),
                    ),
                    child: Container(
                      padding: const EdgeInsets.all(10.0),
                      child: const Text(
                          'عرض جميع الطيارين',
                          style: TextStyle(fontSize: 20)
                      ),
                    )) ,
                const SizedBox(height: 100),
                RaisedButton(
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => ShopRequestLayout()
                      ));
                    },
                    color: Color(int.parse(Global.primaryColor)),
                    elevation: 10.0,
                    textColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0),
                    ),
                    padding: const EdgeInsets.all(0.0),
                    child: Container(
                      padding: const EdgeInsets.all(10.0),
                      child: const Text(
                          'تنفيذ الطلبات',
                          style: TextStyle(fontSize: 20)
                      ),
                    )),


              ]
          ),
        )


    );

  }






}