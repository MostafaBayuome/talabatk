import 'package:Talabatk/Entities/global.dart';
import 'package:flutter/material.dart';
import 'package:Talabatk/Widgets/utils.dart';
import 'package:Talabatk/Entities/app_localizations.dart';

class Profile extends StatefulWidget{
  @override
  _State createState() => _State();
}
class _State extends State<Profile>
{
  String userType="";
  @override
  void initState() {

    setState(() {
      var check=Global.loginUser.mapAppear;
      if(check==0)
        userType="Customer";
      else if (check==1)
        userType="Shop";
      else if(check==2)
        userType="Pharmacy";
      else if(check==9)
        userType="Delivery Man";
      else if(check==10)
        userType="Free Delivery Man";
    });
    super.initState();
  }
  //MapAppear 0 Customer, 1 Shop, 2 Pharmacy, 9 DeliveryMan,10 Free DeliveryMan
  @override
  Widget build(BuildContext context) {
    String _title= AppLocalizations.of(context).translate('profile');
    return Scaffold(
      appBar: Utils.appBarusers(context,_title),
      body:  Column(
        children: <Widget> [

            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.redAccent,Colors.pinkAccent],
                )
              ),
              child: Container(
                width: double.infinity,
                height: 250,
                child: Center(
                  child: Column(
                     crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                       CircleAvatar(
                         radius: 50.0,
                         backgroundImage:  AssetImage("images/profile_image.png"),
                       ),
                      SizedBox(height: 20.0,),
                      Text(Global.loginUser.userName,style: TextStyle(
                        color: Colors.white,
                          fontFamily: Global.fontFamily,
                          fontWeight: FontWeight.w700,
                          fontSize: 22
                      ),),
                      SizedBox(height: 10.0,),

                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 25,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
                 children: [
                   Text( AppLocalizations.of(context).translate('mobile_field')+" :",style: TextStyle(
                       color: Colors.black,
                       fontFamily: Global.fontFamily,
                       fontWeight: FontWeight.bold,
                       fontSize: 18
                   ),),
                   SizedBox(width: 10,),
                   Text(Global.loginUser.mobileNumber.toString(),style: TextStyle(
                       color: Colors.black,
                       fontFamily: Global.fontFamily,
                       fontSize: 16
                   ),),
                 ],
            ),
            Padding(
              padding: EdgeInsets.all(0.0),
              child: Divider(thickness: 1,),
            ),
            SizedBox(height: 15,),
            Row(
             mainAxisAlignment: MainAxisAlignment.center,
             children: [
               Text("User ID :",style: TextStyle(
                  fontWeight: FontWeight.bold,
                   fontFamily: Global.fontFamily,
                   fontSize: 18
               ),),
               SizedBox(width: 10,),
               Text(Global.loginUser.id.toString(),style: TextStyle(

                   fontFamily: Global.fontFamily,
                   fontSize: 16
               ),)
             ],
           ),
            Padding(
              padding: EdgeInsets.all(0.0),
              child: Divider(thickness: 1,),
            ),
            SizedBox(height: 15,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Account Type: ",style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontFamily: Global.fontFamily,
                    fontSize: 18
                ),),
                SizedBox(width: 10,),
                Text(userType,style: TextStyle(

                    fontFamily: Global.fontFamily,
                    fontSize: 16
                ),)
              ],
            ),
            Padding(
              padding: EdgeInsets.all(0.0),
              child: Divider(thickness: 1,),
            ),

        ],
      )
    );
  }




}

