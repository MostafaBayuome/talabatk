import 'dart:convert';
import 'dart:typed_data';

import 'package:Talabatk/Entities/user.dart';
import 'package:Talabatk/Screens/chat_page.dart';
import 'package:Talabatk/Screens/shop/shop_home_page.dart';
import 'package:Talabatk/Widgets/utils.dart';
import 'package:flutter/material.dart';
import 'package:Talabatk/Entities/global.dart';
import 'package:Talabatk/Entities/request.dart';




class ShopRequestInformation extends StatefulWidget {
  Request request;
  ShopRequestInformation({Key key, @required this.request}) : super(key: key);
  @override
  _ShopRequestInformationState createState() => _ShopRequestInformationState(request);
}

class _ShopRequestInformationState extends State<ShopRequestInformation> {
  Request request;
  List<User> delivery_men;
  _ShopRequestInformationState(this.request);
  String _title="الطلبات";
  String arrbytes;
  String arrbytes2;
  Uint8List arrBytes;
  Uint8List arrBytes2;
  @override
  void initState() {
    super.initState();

    try{
      if(request.image_url != "NotImage" )
      {

        Request.drawImageFromServer(request.image_url).then((value) {
          setState(() {
            if(value!=null)
              arrbytes= value;
              arrBytes =base64.decode(arrbytes);
          });
        });
        if(request.image_url2 != "NotImage")
        {
          Request.drawImageFromServer(request.image_url2).then((value){
            setState(() {
              if(value!=null)
                arrbytes2= value;
              arrBytes2=base64.decode(arrbytes2);
            });
          });
        }
      }

    }
    catch (Ex)
    {
      print(Ex);
    }


  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Utils.appBarusers(context,_title),
      body: Padding(
        padding: const EdgeInsets.all(5.0),
         child: Column(

           children: [
             Row(
               mainAxisAlignment: MainAxisAlignment.spaceAround,
               children: [
                 Text(request.request_date.toString(), style: TextStyle(
                     fontFamily: Global.fontFamily,
                     fontWeight: FontWeight.w600,
                     fontSize: 18,

                 )),
               ],
             ),
              SizedBox(
                height: 5,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(request.request_time.toString(), style: TextStyle(
                      fontFamily: Global.fontFamily,
                      fontWeight: FontWeight.w600,
                      fontSize: 16,

                  )),
                  SizedBox(width: 20,),
                  Text("الوقت", style: TextStyle(
                      fontFamily: Global.fontFamily,
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                  )),
                ],
              ),
             SizedBox(height: 5,),
             Text(request.details, style: TextStyle(
                 fontFamily: Global.fontFamily,

                 fontSize: 20,

             )),
             SizedBox(height: 20,),
             Column(
               mainAxisAlignment: MainAxisAlignment.spaceBetween,
               children: <Widget>[

                 if(request.image_url != '' )
                 Container(
                     height: 450,
                     width: 400,
                     child:  ListView(
                         scrollDirection: Axis.horizontal,
                         children: <Widget>[
                           Row(
                               children: <Widget>[
                                if(arrBytes!=null)
                                 Container(
                                     width: 250,
                                      child:Image.memory(arrBytes),
                                 ),
                                 SizedBox(width:7 ,),
                                 if(arrBytes2!=null)
                                 Container(
                                     width: 250,
                                    child: Image.memory(arrBytes2),
                                 )

                               ] ),
                         ])
                 ),

               ],

             ),


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

                        User.getUserByMerchantId( Global.loginUser.id).then((value) {
                          if(value!=null){
                            delivery_men=value;
                            // PopMenuWidget();
                            showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(Radius.circular(50.0)),
                                    ),

                                    title: Text('اختار الطيار',
                                      style : TextStyle(
                                          color: Color(int.parse(Global.primaryColor)),
                                          fontFamily: Global.fontFamily,
                                          fontWeight: FontWeight.w700,
                                          fontSize: 22),
                                      textAlign: TextAlign.center,
                                    ),
                                    content: setupAlertDialogContainer(),
                                  );});
                          }
                       });
                        /*
                       Utils.toastMessage("جاري تنفيذ");
                       //edit state to 1 to be on delivery
                       Request.editRequest(request, 1).then((value) {
                         Navigator.of(context).pop();
                         Navigator.of(context).push(MaterialPageRoute(
                             builder: (context) => ShopHomePage()
                         ));
                            });

                        */


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

   // display all dilevry main to assign to one the request
  Widget setupAlertDialogContainer() {
    return Container(

      height: 200.0,
      width: 200.0,
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: delivery_men.length,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(

            onTap: () {
              request.delivery_id=delivery_men[index].id;
              Request.editRequest(request, 1).then((value) {
                Navigator.of(context).pop();
                Navigator.of(context).pop();
              });
            },
            title:Text(delivery_men[index].userName.toString(),textAlign: TextAlign.center,
              style: TextStyle(fontSize: 18,
                fontFamily: Global.fontFamily,
                fontWeight: FontWeight.w400,), ),
            subtitle: Text(delivery_men[index].mobileNumber.toString(),textAlign: TextAlign.center,
              style: TextStyle(fontSize: 18,
                fontFamily: Global.fontFamily,
                fontWeight: FontWeight.w400,), ),
          );
        },
      ),
    );
  }


}
