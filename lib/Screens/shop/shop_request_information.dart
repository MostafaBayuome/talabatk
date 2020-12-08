import 'dart:convert';
import 'dart:typed_data';
import 'package:Talabatk/Entities/app_localizations.dart';
import 'package:Talabatk/Entities/location.dart';
import 'package:Talabatk/Entities/user.dart';
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
  String address="";
  String arrbytes;
  String arrbytes2;
  Uint8List arrBytes;
  Uint8List arrBytes2;
  @override
  void initState() {
    super.initState();
    Location.GetLocationsById(request.location_id).then((value) {
      setState(() {
        address=value.note;
      });
    } );
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

      appBar: Utils.appBarusers(context,AppLocalizations.of(context).translate('orders')),
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
                     fontSize: 14,

                 )),
               ],
             ),
             SizedBox(height: 5,),
             Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(request.request_time.toString(), style: TextStyle(
                      fontFamily: Global.fontFamily,
                      fontWeight: FontWeight.w600,
                      fontSize: 14,

                  )),
                  SizedBox(width: 20,),
                  Text(AppLocalizations.of(context).translate('time'), style: TextStyle(
                      fontFamily: Global.fontFamily,
                      fontWeight: FontWeight.w600,
                      fontSize: 12,
                  )),
                ],
              ),
             SizedBox(height: 5,),
             Text(request.details, style: TextStyle(
                 fontFamily: Global.fontFamily,

                 fontSize: 15,

             )),
             SizedBox(height: 10,),
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
                                     width: 380,
                                      child:Image.memory(arrBytes),
                                 ),
                                 SizedBox(width:7 ,),
                                 if(arrBytes2!=null)
                                 Container(
                                     width: 380,
                                    child: Image.memory(arrBytes2),
                                 )

                               ] ),
                         ])
                 ),

               ],

             ),
             SizedBox(height: 10,),
             Container(
               child: Text(
                  address
               ),
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
                     child: Text(AppLocalizations.of(context).translate('dont_agree'),style: TextStyle(
                         fontFamily: Global.fontFamily,
                         fontWeight: FontWeight.w600,
                         fontSize: 14,
                         color: Colors.white
                     ),),
                     onPressed:  () {
                       Utils.toastMessage(AppLocalizations.of(context).translate('running'));
                        //update state of request to 3
                       Request.editRequest(request, 3).then((value) {
                         Navigator.of(context).pop();
                         Navigator.of(context).push(MaterialPageRoute(
                             builder: (context) => ShopHomePage()
                         ));
                       });
                     },
                   ),
                   /*
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
                   ), */
                   SizedBox(width: 20,),
                   RaisedButton(
                     elevation: 2.0,
                     color: Colors.lightGreen,
                     textColor: Colors.white,
                     padding:   EdgeInsets.all(10.0),
                     shape: RoundedRectangleBorder(
                       borderRadius: BorderRadius.circular(20.0),
                     ),
                     child: Text( AppLocalizations.of(context).translate('accept_request') ,style: TextStyle(
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

                                    title: Text(AppLocalizations.of(context).translate('choose_delivery') ,
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

   // display all deliverymen to assign the request to one of them
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
