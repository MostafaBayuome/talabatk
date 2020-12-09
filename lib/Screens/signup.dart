import 'package:Talabatk/Entities/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:Talabatk/Entities/user.dart';
import 'package:geocoder/geocoder.dart';
import 'package:geolocator/geolocator.dart';
import 'package:Talabatk/Entities/api_manger.dart';
import 'package:Talabatk/Entities/validation.dart';
import 'package:Talabatk/Entities/global.dart';
import 'package:Talabatk/Widgets/utils.dart';
import 'package:provider/provider.dart';
import 'customer/customer_home_page.dart';
import 'login.dart';


class SignUp extends StatefulWidget {
  @override
  _State createState() => _State();
}

class _State extends State<SignUp> with Validation  {

  String dropdownValue = "Select" ;
  int map_Appear;
  String userName='';
  String phone='';
  String password='';
  String confirmPassword='';
  Position position=null;
  Address address;
  final formKey = GlobalKey <FormState>();
  final TextEditingController _confirmPass = TextEditingController();
  final TextEditingController _pass = TextEditingController();

  @override
  void initState() {
    _getCurrentLocation();
    super.initState();
  }

  void _getCurrentLocation() async {
    try{
      position =  await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
      print(position.latitude);
      print(position.longitude);
    }on Exception{
      print(Exception);
    }
  }

  @override
    Widget build(BuildContext context) {


    return Scaffold(
        body: Padding(
            padding: EdgeInsets.all(10),
            child: ListView(
               children: <Widget>[

                Utils.title(130.0,130.0),
                Container(margin: EdgeInsets.only(top:10.0),),
                Container(
                  margin: EdgeInsets.all(10.0),
                  child: Form(
                    key: formKey,
                    child: Column(
                      children: [

                         nameField(),
                         mobileField(),
                         passwordField(),
                         passwordFieldConfirmation(),


                        Container(margin: EdgeInsets.only(top:10.0),),
                        Text(
                          AppLocalizations.of(context).translate('position'),
                          style: TextStyle(fontSize: 20,
                            color:Color(int.parse(Global.primaryColor)),
                            fontFamily: Global.fontFamily,
                            fontWeight: FontWeight.w500,),
                        ),
                        getLocation(),
                        Container(margin: EdgeInsets.only(top:15.0),),
                        DropDown(),//Account Type Spinner (user,shop,pharmacy)
                        Container(margin: EdgeInsets.only(top:15.0),),
                        submitButton(),
                        Container(margin: EdgeInsets.only(top:5.0),),

                      ],
                    ),
                  ),
                ),
                sendToLogin(),

              ],
            )));

  }

  Widget nameField(){
    return TextFormField(
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        labelText: AppLocalizations.of(context).translate('name_field'),
        hintText: AppLocalizations.of(context).translate('name_field_hint'),
      ),
      validator: validateUserName,
      onSaved: (String value){
        userName=value;
      },
    );
  }

  Widget mobileField(){
    return TextFormField(

      decoration: InputDecoration(
        labelText: AppLocalizations.of(context).translate('mobile_field'),
        hintText: AppLocalizations.of(context).translate('mobile_field'),
      ),
      validator: validateMobileNumber,
      onSaved: (String value){
        phone=value;
      },
    );
  }

  Widget passwordField() {
    return  TextFormField(
      controller: _pass,
      obscureText: true,

      decoration: InputDecoration(
        labelText:  AppLocalizations.of(context).translate('password_field'),
        hintText: '',
      ),
      validator: validatePassword ,
      onSaved: (String value){
        password=value;
      },
    );
  }

  Widget passwordFieldConfirmation() {
    return  TextFormField(
      controller:_confirmPass,
      obscureText: true,
      decoration: InputDecoration(
        labelText:  AppLocalizations.of(context).translate('password_field_confirmation') ,
        hintText: '',
      ),
      validator: (val){
        if(val.isEmpty)
          return 'Empty';
        if(val != _pass.text)
          return 'Not Match';
        return null;
      },
      onSaved: (String value){
        confirmPassword=value;
      },
    );
  }

  Widget submitButton()  {
    if(Global.visible_progress ){
      return CircularProgressIndicator();

    }
    else
    return Container(
      height: 40,
      width: 120,
      child: RaisedButton(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18.0),

        ),
        color:Color(int.parse(Global.primaryColor)),
        child: Text(AppLocalizations.of(context).translate('signup'),style:TextStyle(
          color: Colors.white,
          fontFamily: Global.fontFamily,
          fontWeight: FontWeight.w700,
          fontSize: 15
        ),),
        onPressed: () async {

          if(dropdownValue== "Select")
            {
              Utils.toastMessage(AppLocalizations.of(context).translate('select_type'));
              return;
            }
          else{

          }
          setState(() {
            Global.visible_progress=true;
          });

          if(formKey.currentState.validate()) {
            formKey.currentState.save();
            // Sign up as shop
            map_Appear=0;
            if(dropdownValue=="صيدلية" || dropdownValue=="pharmacy" )  map_Appear=2;
            else if(dropdownValue=="محل تجاري" || dropdownValue=="Super market")  map_Appear=1;
            else if(dropdownValue=="مطعم"|| dropdownValue=="restaurant") map_Appear=3;
            else if(dropdownValue=="عطاره"|| dropdownValue=="Atara") map_Appear=4;

            if (map_Appear>0){
              if (position == null) {
                _getCurrentLocation();
              }
              else {
                final coordinates= new Coordinates( position.latitude,position.longitude);
                convertCoordinatesToAddress(coordinates).then((value){
                  address=value;
                  signUp("Talabatk/AddUser", phone, password, userName ,position.latitude, position.longitude, true, map_Appear,-1,address.addressLine).then((value) async {
                    setState(() {
                      Global.visible_progress=false;
                    });
                    if(value != null)
                    {

                      User user =new User(value['id'],phone,position.latitude,position.longitude,userName,password,map_Appear,-1);
                      Global.loginUser=user;

                      //save all user data
                      Global.prefs.setInt('id',user.id);
                      Global.prefs.setString('phone', phone);
                      Global.prefs.setInt('map_Appear', map_Appear);
                      Global.prefs.setString('password', password);
                      Global.prefs.setString('userName', userName);
                      Global.prefs.setDouble('latitude',position.latitude);
                      Global.prefs.setDouble('longitude', position.longitude);

                      Navigator.of(context).pop();
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => Login()
                      ));
                    }
                    else{
                      Utils.toastMessage(AppLocalizations.of(context).translate('right_info'));
                    }}
                  );
                });


              }
            }
            // sign up as customer
            else {

              if (position == null) {
                setState(() {
                  Global.visible_progress=false;
                });
                _getCurrentLocation();
              }
              else {
                final coordinates= new Coordinates( position.latitude,position.longitude);
                convertCoordinatesToAddress(coordinates).then((value){
                  address=value;
                  signUp("Talabatk/AddUser", phone, password,userName, position.latitude, position.longitude, true, map_Appear,-1,address.addressLine).then((value) async {
                    setState(() {
                      Global.visible_progress=false;
                    });
                    if(value != null)
                    {


                      User user =new User(value['id'],phone,position.latitude,position.longitude,userName,password,map_Appear,-1);
                      Global.loginUser=user;

                      //save all user data
                      Global.prefs.setInt('id',user.id);
                      Global.prefs.setString('phone', phone);
                      Global.prefs.setInt('map_Appear', map_Appear);
                      Global.prefs.setString('password', password);
                      Global.prefs.setString('userName', userName);
                      Global.prefs.setDouble('latitude',position.latitude);
                      Global.prefs.setDouble('longitude', position.longitude);

                      Navigator.of(context).pop();
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => CustomerHomePage()
                      ));
                    }
                    else{
                      setState(() {
                        Global.visible_progress=false;
                      });

                      Utils.toastMessage( AppLocalizations.of(context).translate('The_mobile_number_is_already_used'));
                    }}
                  );
                });


              }
            }
          }
          else{
            setState(() {
              Global.visible_progress=false;
            });
          }

        },
      ),
    );
  }

  Widget getLocation (){
    return Ink(
      decoration: const ShapeDecoration(
        color: Colors.white,
        shape: CircleBorder(),
      ),
      child: IconButton(
        icon: Icon(Icons.location_on),
        color: Color(int.parse(Global.primaryColor)),
        onPressed: () {
          position =  _getLocation() as Position;
        },
      ),
    );
  }

  // get current location of user
  Future<Position> _getLocation() async{
    Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    print(position);
    return position;
  }

  Widget DropDown() {
       return   Container(
        child: Row(
          children: <Widget>[
            Container(
              margin:EdgeInsets.all(15) ,
              child: Text(
                AppLocalizations.of(context).translate('account_type'),
                style: TextStyle(fontSize: 13,
                  fontFamily: Global.fontFamily,
                  fontWeight: FontWeight.w500,),
              ),
            ),
             DropdownButton<String>(
              value: dropdownValue,
              onChanged: (String data) {
                setState(() {
                  dropdownValue = data;
                });
                dropdownValue=data;
              },
              items: <String>[
                "Select",
                AppLocalizations.of(context).translate('customer'),
                AppLocalizations.of(context).translate('super_market'),
                AppLocalizations.of(context).translate('pharmacy'),
                AppLocalizations.of(context).translate('restaurant'),
                AppLocalizations.of(context).translate('atara'),
              ]
                  .map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: new Text(value),
                );
              }).toList(),
            ),
          ],
          mainAxisAlignment: MainAxisAlignment.center,
        )
    );
  }
  Widget sendToLogin(){
    return   Container(
        child: Row(
          children: <Widget>[
            Text(AppLocalizations.of(context).translate('have_acount')),
            FlatButton(
              textColor: Color(int.parse(Global.primaryColor)),
              child: Text(
                AppLocalizations.of(context).translate('login_user'),
                style: TextStyle(fontSize: 20),
              ),
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) =>Login()
                ));
              },
            ),

          ],
          mainAxisAlignment: MainAxisAlignment.center,
        ));
  }

  Future<Address> convertCoordinatesToAddress(Coordinates coordinates) async{
    var addresses = await Geocoder.local.findAddressesFromCoordinates(coordinates);
    return addresses.first;
  }

}