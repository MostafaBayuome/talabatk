import 'package:Talabatk/Entities/global.dart';
import 'package:Talabatk/Entities/user.dart';
import 'package:Talabatk/Entities/validation.dart';
import 'package:Talabatk/Widgets/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class DisplayAllDeliveryMen extends StatefulWidget{
  @override
  _State createState() => _State();
}
class _State extends State<DisplayAllDeliveryMen> with Validation
{
  List<User> delivery_men=[];

  TextEditingController _userName =  new TextEditingController();
  TextEditingController _password =  new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Utils.appBar(20),
      body: Container(
        child: FutureBuilder(
          future: User.getUserByMerchantId(Global.loginUser.id),
          builder:(BuildContext context,AsyncSnapshot snapshot){
            if(snapshot.data == null) {
              return Container(
                child: Center(
                  child: Text("Loading...."  ,style: TextStyle(
                      fontFamily: Global.fontFamily,
                      fontWeight: FontWeight.w600,
                      fontSize: 25,
                      color: Color(int.parse(Global.primaryColor))
                  ),),
                ),
              );
            }
            else{
              delivery_men = snapshot.data;
              return ListView.builder(

                itemCount: delivery_men.length,
                itemBuilder: (BuildContext context,int index){
                 return Padding(
                   padding: EdgeInsets.all(15),
                   child:   Row (
                     mainAxisAlignment: MainAxisAlignment.center,
                     children: [
                       Expanded(
                         flex: 4,
                         child: Padding(
                           padding: EdgeInsets.all(20),
                           child: Column(
                             children: [
                               Text(
                                   delivery_men[index].userName,
                                   style: TextStyle(
                                       fontFamily: Global.fontFamily,
                                       fontWeight: FontWeight.w600,
                                       fontSize: 16,

                                   )
                               ),
                               Text(
                                   delivery_men[index].mobileNumber,
                                   style: TextStyle(
                                       fontFamily: Global.fontFamily,
                                       fontWeight: FontWeight.w600,
                                       fontSize: 14,

                                   )
                               )
                             ],
                           ),
                         ),
                       ),
                       SizedBox.fromSize(
                         size: Size(40, 40), // button width and height
                         child: ClipOval(
                           child: Material(
                             color:  Colors.lightGreen, // button color
                             child: InkWell(
                               splashColor: Color(int.parse(Global.secondaryColor)), // splash color
                               onTap: () {
                                 launch('tel://${delivery_men[index].mobileNumber}');
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
                         size: Size(50, 50), // button width and height
                         child: ClipOval(
                           child: Material(
                             color: Color(int.parse(Global.primaryColor)), // button color
                             child: InkWell(
                               splashColor: Color(int.parse(Global.secondaryColor)), // splash color
                               onTap: () {
                                 showDialog(
                                     child: new Dialog(
                                       child: Padding(
                                         padding: EdgeInsets.all(10),
                                         child: new Column(
                                           mainAxisSize: MainAxisSize.min,
                                           children: <Widget>[
                                             Utils.title(50.0,50.0),
                                             Directionality(
                                               textDirection: TextDirection.rtl,
                                               child: nameField(),
                                             ),
                                             Directionality(
                                               textDirection: TextDirection.rtl,
                                               child: passwordField(),
                                             ),
                                             Container(margin: EdgeInsets.only(top:15.0),),
                                             new RaisedButton(
                                               color:Color(int.parse(Global.primaryColor)),
                                               child: new Text("تحديث" ,style:TextStyle(
                                                 color: Colors.white,
                                                 fontFamily: Global.fontFamily,
                                                 fontWeight: FontWeight.w500,
                                               )),
                                               onPressed: (){
                                                 String username = _userName.text;
                                                 String password = _password.text;
                                                 if(username.length>=6 && password.length>=6){
                                                   Utils.toastMessage("جاري تحديث البيانات");
                                                   User.updateUserWithPassUserStatus(delivery_men[index].id, delivery_men[index].mobileNumber, username, password, true).then((value) {
                                                     setState((){
                                                              delivery_men[index].userName=username;
                                                              delivery_men[index].password=password;
                                                     });
                                                     _password.clear();
                                                     _userName.clear();
                                                     Utils.toastMessage("تم تحديث البيانات");
                                                     Navigator.pop(context);
                                                   });
                                                 }
                                                 else{
                                                   Utils.toastMessage("من فضلك ادخل البيانات صحيحه");
                                                 }
                                               },
                                             )
                                           ],
                                         ),
                                       ),

                                     ), context: context);
                               }, // button pressed
                               child: Column(
                                 mainAxisAlignment: MainAxisAlignment.center,
                                 children: <Widget>[
                                   Icon(Icons.update,color: Colors.white,size: 15,), // icon
                                   Text("تحديث البيانات"  , style: TextStyle(
                                     fontSize:8,
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
                                 // update delivery status to false
                                 User.updateUserWithPassUserStatus(delivery_men[index].id, delivery_men[index].mobileNumber,  delivery_men[index].userName, delivery_men[index].password, false).then((value){
                                   if(value=="updated_successfully")
                                   {
                                     Utils.toastMessage("تم المسح");
                                     setState(() {
                                       delivery_men.removeAt(index);
                                     });
                                   }
                                 });
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



  Widget nameField(){

    return TextFormField(
      textAlign: TextAlign.right,
      keyboardType: TextInputType.text,
      controller:_userName,
      decoration: InputDecoration(
        labelText: 'الاسم',
        hintText: 'محمد',
      ),

    );
  }

  Widget passwordField() {
    return  TextFormField(
      controller: _password,

      textAlign: TextAlign.right,
      decoration: InputDecoration(
        labelText: 'كلمه المرور',
        hintText: 'كلمه المرور',
      ),
      validator: validatePassword ,

    );
  }
}