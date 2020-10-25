import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:Talabatk/Entities/user.dart';
import 'package:geolocator/geolocator.dart';
import 'package:Talabatk/Entities/api_manger.dart';
import 'package:Talabatk/Entities/validation.dart';
import 'package:Talabatk/Entities/global.dart';
import 'package:Talabatk/Screens/shop/shop_home_page.dart';
import 'package:Talabatk/Widgets/utils.dart';
import 'customer/customer_home_page.dart';
import 'login.dart';


class SignUp extends StatefulWidget {
  @override
  _State createState() => _State();
}

class _State extends State<SignUp> with Validation  {

  String dropdownValue = 'مستخدم';
  int map_Appear;
  String userName='';
  String phone='';
  String password='';
  String confirmPassword='';
  Position position=null;
  final formKey = GlobalKey <FormState>();
  final TextEditingController _confirmPass = TextEditingController();
  final TextEditingController _pass = TextEditingController();

  @override
  void initState()  {
    _getCurrentLocation();
    super.initState();
  }

    void _getCurrentLocation() async {
    try{
      position =  await getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
      print(position.latitude);
      print(position.longitude);
    }on Exception{
      print(Exception);
    }
  }

  @override
  Widget build(BuildContext context) {


    return Scaffold(
        appBar: Utils.appBar(30),
        body: Padding(
            padding: EdgeInsets.all(10),
            child: ListView(
                  children: <Widget>[
                //future update remove _title() and put CircleAvatar()
                _title(),
                Container(margin: EdgeInsets.only(top:25.0),),
                Container(
                  margin: EdgeInsets.all(20.0),
                  child: Form(
                    key: formKey,
                    child: Column(
                      children: [

                       Directionality(
                        textDirection: TextDirection.rtl,
                         child: nameField(),
                         ),
                       Directionality(
                          textDirection: TextDirection.rtl,
                          child: mobileField(),
                        ),
                       Directionality(
                          textDirection: TextDirection.rtl,
                          child: passwordField(),
                        ),
                        Directionality(
                          textDirection: TextDirection.rtl,
                          child: passwordFieldConfirmation(),
                        ),

                        Container(margin: EdgeInsets.only(top:10.0),),
                        Text(
                          'موقعك',
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

                      ],
                    ),
                  ),
                ),

                SizedBox(height: 10),
                sendToLogin(),
              ],
            )));
  }



  Widget _title() {
    return Align(

      child: Container(
        width: 100,
        height: 100,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          image: DecorationImage(
            image : AssetImage("images/Talabatk.png"),
            fit:BoxFit.fill
          )
        ),

      ),);
      /*Container(
          decoration: BoxDecoration(
              border: Border.all(color:Color(int.parse(Global.primaryColor)) , width: 4.0),
              borderRadius: new BorderRadius.all(Radius.elliptical(100, 50)),
              color:Color(int.parse(Global.secondaryColor))
          ),
          width: 140.0,
          height: 70.0,
          alignment: Alignment.center,
          padding: EdgeInsets.all(10),
          child: Text(
            'سجل حسابك',
            style: TextStyle(
                color: Colors.white,
                fontFamily: Global.fontFamily,
                fontWeight: FontWeight.w900,
                fontSize: 18),
          )) */

  }

  Widget nameField(){

    return TextFormField(
      textAlign: TextAlign.right,
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        labelText: 'الاسم',
        hintText: 'محمد',
      ),
      validator: validateUserName,
      onSaved: (String value){
        userName=value;
      },
    );
  }

  Widget mobileField(){
    return TextFormField(
      textAlign: TextAlign.right,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        labelText: 'رقم الموبيل',
        hintText: '',
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
      textAlign: TextAlign.right,
      decoration: InputDecoration(
        labelText: 'كلمه المرور',
        hintText: 'كلمه المرور',
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
      textAlign: TextAlign.right,
      decoration: InputDecoration(
        labelText: 'تاكيد كلمه المرور',
        hintText: 'تاكيد كلمه المرور',
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
    if(Global.visible_progress){
      return CircularProgressIndicator();

    }
    else
    return RaisedButton(
      color:Color(int.parse(Global.primaryColor)),
      child: Text('تسجيل الدخول',style:TextStyle(
        color: Colors.white,
        fontFamily: Global.fontFamily,
        fontWeight: FontWeight.w500,
      ),),
      onPressed: () async {
        setState(() {
          Global.visible_progress=true;
        });

        if(formKey.currentState.validate()) {
          formKey.currentState.save();
          // Sign up as shop
          map_Appear=0;
          if(dropdownValue=="صيدلية")     map_Appear=2;
          else if(dropdownValue=="محل تجاري")     map_Appear=1;

          if (map_Appear>0){
            if (position == null) {
              _getCurrentLocation();
            }
            else {
              
              signUp("Talabatk/AddUser", phone, password, userName ,position.latitude, position.longitude, true, map_Appear,-1).then((value) async {
                setState(() {
                  Global.visible_progress=false;
                });
                if(value != null)
                {
                  SharedPreferences prefs = await SharedPreferences.getInstance();

                  User user =new User(value['id'],phone,position.latitude,position.longitude,userName,password,map_Appear,-1);
                  Global.loginUser=user;

                  //save all user data
                  prefs.setInt('id',user.id);
                  prefs.setString('phone', phone);
                  prefs.setInt('map_Appear', map_Appear);
                  prefs.setString('password', password);
                  prefs.setString('userName', userName);
                  prefs.setDouble('latitude',position.latitude);
                  prefs.setDouble('longitude', position.longitude);

                  Navigator.of(context).pop();
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => ShopHomePage()
                  ));
                }
                else{
                  Utils.toastMessage("من فضلك ادخل البيانات صحيحه");
                }}
              );

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
              signUp("Talabatk/AddUser", phone, password,userName, position.latitude, position.longitude, true, map_Appear,-1).then((value) async {
                setState(() {
                  Global.visible_progress=false;
                });
                if(value != null)
                {
                  SharedPreferences prefs = await SharedPreferences.getInstance();

                  User user =new User(value['id'],phone,position.latitude,position.longitude,userName,password,map_Appear,-1);
                  Global.loginUser=user;

                  //save all user data
                  prefs.setInt('id',user.id);
                  prefs.setString('phone', phone);
                  prefs.setInt('map_Appear', map_Appear);
                  prefs.setString('password', password);
                  prefs.setString('userName', userName);
                  prefs.setDouble('latitude',position.latitude);
                  prefs.setDouble('longitude', position.longitude);

                  Navigator.of(context).pop();
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => CustomerHomePage()
                  ));
                }
                else{
                  setState(() {
                    Global.visible_progress=false;
                  });

                  Utils.toastMessage("رقم الموبايل مستخدم مسبقا ");
                }}
              );

            }
          }
        }
        else{
          setState(() {
            Global.visible_progress=true;
          });
        }

      },
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
    Position position = await getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    print(position);
    return position;
  }

  Widget DropDown() {
    return   Container(
        child: Row(
          children: <Widget>[

            new DropdownButton<String>(
              value: dropdownValue,
              onChanged: (String data) {
                setState(() {
                  dropdownValue = data;
                });
              },
              items: <String>['مستخدم', 'محل تجاري', 'صيدلية'].map((String value) {
                return new DropdownMenuItem<String>(
                  value: value,
                  child: new Text(value),
                );
              }).toList(),

            ),
            Container(
              margin:EdgeInsets.all(15) ,
              child: Text(
                'نوع الحساب',
                style: TextStyle(fontSize: 13,
                  fontFamily: Global.fontFamily,
                  fontWeight: FontWeight.w500,),
              ),
            )
          ],
          mainAxisAlignment: MainAxisAlignment.center,
        )
    );
  }

  Widget sendToLogin(){
    return   Container(
        child: Row(
          children: <Widget>[

            FlatButton(
              textColor: Color(int.parse(Global.primaryColor)),
              child: Text(
                'تسجيل الدخول',
                style: TextStyle(fontSize: 20),
              ),
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) =>Login()
                ));
              },
            ),
            Text('انشاء حساب؟'),
          ],
          mainAxisAlignment: MainAxisAlignment.center,
        ));
  }

}