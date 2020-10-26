import 'package:Talabatk/Entities/global.dart';
import 'package:Talabatk/Entities/user.dart';
import 'package:Talabatk/Widgets/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';


class DisplayAllDeliveryMen extends StatefulWidget{
  @override
  _State createState() => _State();
}
class _State extends State<DisplayAllDeliveryMen>
{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Utils.appBar(30),
      body: Container(
        child: FutureBuilder(
          future: User.getUserByMerchantId(Global.loginUser.id),
          builder:(BuildContext context,AsyncSnapshot snapshot){
            if(snapshot.data == null)
            {
              return Container(
                child: Center(
                  child: Text("Loading...."  ,style: TextStyle(
                      fontFamily: Global.fontFamily,
                      fontWeight: FontWeight.w600,
                      fontSize: 18,
                      color: Color(int.parse(Global.primaryColor))
                  ),),
                ),
              );
            }
            else{
              return ListView.builder(

                itemCount: snapshot.data.length,
                itemBuilder: (BuildContext context,int index){
                 return Padding(
                   padding: EdgeInsets.all(15),
                   child: Row (
                     mainAxisAlignment: MainAxisAlignment.center,
                     children: [
                       Padding(
                         padding: EdgeInsets.all(20),
                         child: Column(
                           children: [
                             Text(
                                 snapshot.data[index].userName,
                                 style: TextStyle(
                                     fontFamily: Global.fontFamily,
                                     fontWeight: FontWeight.w600,
                                     fontSize: 19,
                                     color: Color(int.parse(Global.primaryColor))
                                 )
                             ),
                             Text(
                                 snapshot.data[index].mobileNumber,
                                 style: TextStyle(
                                     fontFamily: Global.fontFamily,
                                     fontWeight: FontWeight.w600,
                                     fontSize: 16,
                                     color: Color(int.parse(Global.primaryColor))
                                 )
                             )
                           ],
                         ),
                       ),
                       SizedBox.fromSize(
                         size: Size(40, 40), // button width and height
                         child: ClipOval(
                           child: Material(
                             color:   Color(int.parse(Global.primaryColor)), // button color
                             child: InkWell(
                               splashColor: Color(int.parse(Global.secondaryColor)), // splash color
                               onTap: () {
                                 launch('tel://${snapshot.data[index].mobileNumber}');
                               }, // button pressed
                               child: Column(
                                 mainAxisAlignment: MainAxisAlignment.center,
                                 children: <Widget>[
                                   Icon(Icons.call,color: Colors.white,size: 15,), // icon
                                   Text("اتصال"  , style: TextStyle(
                                     fontSize: 10,
                                     color: Colors.white,
                                   ),), // text
                                 ],
                               ),
                             ),
                           ),
                         ),
                       ),
                       SizedBox(width: 20),
                       SizedBox.fromSize(
                         size: Size(40, 40), // button width and height
                         child: ClipOval(
                           child: Material(
                             color:  Colors.redAccent, // button color
                             child: InkWell(
                               splashColor: Color(int.parse(Global.secondaryColor)), // splash color
                               onTap: () {
                                // DELETE user Delivery
                               }, // button pressed
                               child: Column(
                                 mainAxisAlignment: MainAxisAlignment.center,
                                 children: <Widget>[
                                   Icon(Icons.delete,color: Colors.white,size: 15,), // icon
                                   Text("مسح"  , style: TextStyle(
                                     fontSize: 10,
                                     color: Colors.white,
                                   ),), // text
                                 ],
                               ),
                             ),
                           ),
                         ),
                       )
                     ],

                   )
                 );
                },
              );
            }
          },
        ),
      ),
    );
  }


}