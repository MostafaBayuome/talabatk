import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:talabatk_flutter/Entities/constants.dart';
import 'package:talabatk_flutter/Entities/global.dart';
import 'package:talabatk_flutter/Entities/request.dart';
import 'file:///C:/Users/Etch/OneDrive/Desktop/WORK/Talbatk/Talabatk-GitHub/lib/Screens/shop/shop_request_information.dart';
import '../signup.dart';



class ShopHomePage extends StatefulWidget {

  @override
  State<StatefulWidget> createState() => _State();

}

class _State extends State<ShopHomePage>{

  List<Request> customerRequest=[];

  @override
  Widget build(BuildContext context) {
    getAllRequests();
    return Scaffold(
      appBar:AppBar(
        backgroundColor: Color(int.parse(Global.primaryColor)),
        title: Text(Global.appName),
        automaticallyImplyLeading: false,
        actions: [
          PopupMenuButton<String>(
            onSelected: choiceAction,
            itemBuilder: (BuildContext context){
              return Constants.choices.map((String choice){
                return PopupMenuItem<String>(
                  value: choice,
                  child: Text(choice),
                );
              }).toList();
            },
          )
        ],
      ),body:ListView.builder(
          padding: EdgeInsets.all(20),
          itemCount: customerRequest.length,
          itemBuilder: (BuildContext context,int index){
            return ListTile(
              title:Center(
                child: Container(
                      child: Material(
                        color: Colors.white,
                        elevation: 8.0,
                        borderRadius: BorderRadius.circular(24.0),
                        shadowColor: Color(int.parse(Global.primaryColor)),
                        child: Column(

                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(customerRequest[index].request_date.toString(), style: TextStyle(
                                          fontFamily: Global.fontFamily,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 15,
                                          color: Color(int.parse(Global.primaryColor))
                                      )),
                                    ),
                                  ),
                                  Container(
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(customerRequest[index].request_time.toString()  +"الوقت ", style: TextStyle(
                                          fontFamily: Global.fontFamily,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 15,
                                          color: Color(int.parse(Global.primaryColor))
                                      )),
                                    ),
                                  ),

                                  Container(
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(customerRequest[index].details, style: TextStyle(
                                          fontFamily: Global.fontFamily,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 12,
                                          color: Color(int.parse(Global.primaryColor))
                                      )),
                                    ),
                                  ),
                                  RaisedButton(
                                      onPressed: () {
                                      /*** send user to information/chat screen ***/
                                        Navigator.of(context).push(MaterialPageRoute(
                                            builder: (context) => RequestInfromation()
                                        ));

                                      },
                                      elevation: 2.0,
                                      color: Color(int.parse(Global.primaryColor)),
                                      textColor: Colors.white,
                                      padding: const EdgeInsets.all(0.0),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(20.0),
                                      ),
                                      child: Container(
                                        padding: const EdgeInsets.all(10.0),
                                        child: const Text(
                                            "تفاصيل الطلب",
                                            style: TextStyle(fontSize: 15)
                                        ),
                                      )
                                  ),
                                ]
                            ),
                      ),)),
        );
      },
    )
    );
  }

  Future getAllRequests() {
    return  Future.delayed(const Duration(seconds: 5), () {
      Request.getCustomerRequests().then((value)
        {
          setState(() {
            if(value.length!=customerRequest.length)
              {
                customerRequest=value;
              }
          });
        }
        );

    });
  }

   Future<void>  choiceAction(String choices) async {

    if(choices.contains('تسجيل الخروج')){
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.remove('FirstEnter');
      prefs.remove('phone');
      prefs.remove('map_Appear');
      prefs.remove('id');
      prefs.remove('password');
      prefs.remove('userName');
      prefs.remove('latitude');
      prefs.remove('longitude');


      Navigator.of(context).pop();
      Navigator.of(context).push(MaterialPageRoute(
          builder: (context) =>SignUp()
      ));
    }

  }

}