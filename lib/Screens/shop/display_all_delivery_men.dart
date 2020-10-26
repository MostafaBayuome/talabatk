import 'package:Talabatk/Entities/global.dart';
import 'package:Talabatk/Entities/user.dart';
import 'package:Talabatk/Widgets/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


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
                padding: EdgeInsets.all(20),
                itemCount: snapshot.data.length,
                itemBuilder: (BuildContext context,int index){
                 return Padding(
                   padding: EdgeInsets.all(20),
                   child: Row (
                     mainAxisAlignment: MainAxisAlignment.center,
                     children: [
                       Padding(
                         padding: EdgeInsets.all(20),
                         child: Material(
                           color: Colors.white,
                           elevation: 8.0,
                           borderRadius: BorderRadius.circular(30.0),
                           child: Column(
                             children: [
                               Text(
                                   snapshot.data[index].userName,

                               ),
                               Text(
                                   snapshot.data[index].mobileNumber,

                               )
                             ],
                           ),
                         ),
                       ),
                       SizedBox.fromSize(
                         size: Size(50, 50), // button width and height
                         child: ClipOval(
                           child: Material(
                             color:  Colors.redAccent, // button color
                             child: InkWell(
                               splashColor: Color(int.parse(Global.secondaryColor)), // splash color
                               onTap: () {

                               }, // button pressed
                               child: Column(
                                 mainAxisAlignment: MainAxisAlignment.center,
                                 children: <Widget>[
                                   Icon(Icons.delete,color: Colors.white,), // icon
                                   Text("مسح"  , style: TextStyle(
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