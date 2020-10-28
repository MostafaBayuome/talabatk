import 'package:Talabatk/Entities/user.dart';
import 'package:Talabatk/Screens/chat_page.dart';
import 'package:Talabatk/Screens/shop/shop_home_page.dart';
import 'package:Talabatk/Widgets/utils.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:Talabatk/Entities/constants.dart';
import 'package:Talabatk/Entities/global.dart';
import 'package:Talabatk/Entities/request.dart';
import 'package:Talabatk/Screens/signup.dart';


class ShopRequestInfromation extends StatefulWidget {
  Request request;
  ShopRequestInfromation({Key key, @required this.request}) : super(key: key);
  @override
  _ShopRequestInfromationState createState() => _ShopRequestInfromationState(request);
}

class _ShopRequestInfromationState extends State<ShopRequestInfromation> {
  Request request;
  List<User> delivery_men;
  _ShopRequestInfromationState(this.request);
  String _title="Request Information";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Utils.appBarusers(context,_title),

      body: Padding(
        padding: const EdgeInsets.all(20.0),
         child: Column(

           children: [
             Row(
               mainAxisAlignment: MainAxisAlignment.spaceAround,
               children: [
                 Text(request.request_date.toString(), style: TextStyle(
                     fontFamily: Global.fontFamily,
                     fontWeight: FontWeight.w600,
                     fontSize: 25,
                     color: Color(int.parse(Global.primaryColor))
                 )),

               ],
             )
             ,
              SizedBox(
                height: 35,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(request.request_time.toString(), style: TextStyle(
                      fontFamily: Global.fontFamily,
                      fontWeight: FontWeight.w600,
                      fontSize: 22,
                      color: Color(int.parse(Global.primaryColor))
                  )),
                  SizedBox(width: 20,),
                  Text("الوقت", style: TextStyle(
                      fontFamily: Global.fontFamily,
                      fontWeight: FontWeight.w600,
                      fontSize: 22,
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
                       Utils.toastMessage("جاري تنفيذ");
                        //update state of request to 3
                       Request.editRequest(request, 3).then((value) {
                         Navigator.of(context).pop();
                         Navigator.of(context).push(MaterialPageRoute(
                             builder: (context) => ShopHomePage()
                         ));
                       });
                     },
                   ),
                   SizedBox(width: 20,),
                   SizedBox.fromSize(
                     size: Size(60, 60), // button width and height
                     child: ClipOval(
                       child: Material(
                         color:  Color(int.parse(Global.primaryColor)), // button color
                         child: InkWell(
                           splashColor: Color(int.parse(Global.secondaryColor)), // splash color
                           onTap: () {
                             Navigator.of(context).push(MaterialPageRoute(
                                 builder: (context) =>ChatPage(request :  request)
                             ));
                           }, // button pressed
                           child: Column(
                             mainAxisAlignment: MainAxisAlignment.center,
                             children: <Widget>[
                               Icon(Icons.chat,color: Colors.white,), // icon
                               Text("محادثه", style: TextStyle(
                                 color: Colors.white,
                               )), // text
                             ],
                           ),
                         ),
                       ),
                     ),
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

                        User.getUserByMerchantId( Global.loginUser.id).then((value) => {
                          if(value!=null){
                            delivery_men=value.toList(),
                            PopMenu(delivery_men),

                          }



                       });
                       Utils.toastMessage("جاري تنفيذ");
                       //edit state to 1 to be on delivery
                       Request.editRequest(request, 1).then((value) {
                         Navigator.of(context).pop();
                         Navigator.of(context).push(MaterialPageRoute(
                             builder: (context) => ShopHomePage()
                         ));
                            });


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
