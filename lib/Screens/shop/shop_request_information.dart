import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:talabatk_flutter/Entities/constants.dart';
import 'package:talabatk_flutter/Entities/global.dart';
import 'package:talabatk_flutter/Entities/request.dart';
import 'package:talabatk_flutter/Screens/signup.dart';


class ShopRequestInfromation extends StatefulWidget {
  Request request;
  ShopRequestInfromation({Key key, @required this.request}) : super(key: key);
  @override
  _ShopRequestInfromationState createState() => _ShopRequestInfromationState(request);
}

class _ShopRequestInfromationState extends State<ShopRequestInfromation> {
  Request request;
  _ShopRequestInfromationState(this.request);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor:  Color(int.parse(Global.primaryColor)),
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
      ),

      body: Padding(
        padding: const EdgeInsets.all(20.0),
         child: Column(

           children: [
             Text(request.request_date.toString(), style: TextStyle(
                 fontFamily: Global.fontFamily,
                 fontWeight: FontWeight.w600,
                 fontSize: 25,
                 color: Color(int.parse(Global.primaryColor))
                 )),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(request.request_time.toString(), style: TextStyle(
                      fontFamily: Global.fontFamily,
                      fontWeight: FontWeight.w600,
                      fontSize: 20,
                      color: Color(int.parse(Global.primaryColor))
                  )),
                  SizedBox(width: 20,),
                  Text("الوقت", style: TextStyle(
                      fontFamily: Global.fontFamily,
                      fontWeight: FontWeight.w600,
                      fontSize: 20,
                      color: Color(int.parse(Global.primaryColor))
                  )),

                ],
              ),
             SizedBox(height: 20,),
             Text(request.details, style: TextStyle(
                 fontFamily: Global.fontFamily,
                 fontWeight: FontWeight.w600,
                 fontSize: 20,
                 color: Color(int.parse(Global.primaryColor))
             )),
             SizedBox(height: 20,),
             /*** IMAGES WIDGET WILL BE ADDED HERE FUTURE WORK ***/
             Expanded(
               child: Row(
                 crossAxisAlignment: CrossAxisAlignment.end,
                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                 children: [
                   RaisedButton(
                     elevation: 2.0,
                     color: Color(int.parse("0xffFF6C6C")),
                     textColor: Colors.white,
                     padding:   EdgeInsets.all(10.0),
                     shape: RoundedRectangleBorder(
                       borderRadius: BorderRadius.circular(20.0),
                     ),
                     child: Text("لا اوافق" ,style: TextStyle(
                         fontFamily: Global.fontFamily,
                         fontWeight: FontWeight.w600,
                         fontSize: 14,
                         color: Colors.white
                     ),),
                     onPressed:  () {
                        //update state of request to 3

                     },
                   ),
                   SizedBox(width: 20,),
                   RaisedButton(
                     elevation: 2.0,
                     color: Colors.lightGreen,
                     textColor: Colors.white,
                     padding:   EdgeInsets.all(10.0),
                     shape: RoundedRectangleBorder(
                       borderRadius: BorderRadius.circular(20.0),
                     ),
                     child: Text("تنفيذ الطلب" ,style: TextStyle(
                         fontFamily: Global.fontFamily,
                         fontWeight: FontWeight.w600,
                         fontSize: 14,
                         color: Colors.white
                     )),
                     onPressed:  () {
                       // update state of request to  4

                     },
                   )
                 ],
               ),
             )
              ],
         ),
      ),
    );
  }

    Future<void> choiceAction(String choices) async {

    if(choices.contains('تسجيل الخروج')){
      SharedPreferences prefs = await SharedPreferences.getInstance();

      prefs.remove('phone');
      prefs.remove('map_Appear');
      prefs.remove('id');
      prefs.remove('password');
      prefs.remove('userName');
      prefs.remove('latitude');
      prefs.remove('longitude');

      Navigator.of(context).pushAndRemoveUntil(  MaterialPageRoute(
          builder: (context) =>SignUp()
      ),ModalRoute.withName("/Home"));

    }


  }


}
