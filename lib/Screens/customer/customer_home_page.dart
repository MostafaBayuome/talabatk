import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:talabatk_flutter/Entities/constants.dart';
import 'package:talabatk_flutter/Entities/global.dart';
import 'package:talabatk_flutter/Screens/customer/customer_requests_layout.dart';
import 'package:talabatk_flutter/Screens/signup.dart';
import 'gmap.dart';
import 'customer_location_editor.dart';
import 'package:talabatk_flutter/Entities/location.dart';




class CustomerHomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _State();
}


class _State extends State<CustomerHomePage>
{

  List<Location> Locations =[];
  @override
  Widget build(BuildContext context) {
    return Scaffold (
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
        body:customerMenuWidget()


    );
  }

  Widget customerMenuWidget()
  {
    return Center(

      child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            RaisedButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => LocationEditor()
                  ));
                },
                color: Color(int.parse(Global.primaryColor)),
                elevation: 10.0,
                textColor: Colors.white,
                padding: const EdgeInsets.all(0.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18.0),
                ),
                child: Container(
                  padding: const EdgeInsets.all(10.0),
                  child: const Text(
                      'اضافه موقع جديد',
                      style: TextStyle(fontSize: 20)
                  ),
                )),
            const SizedBox(height: 100),
            RaisedButton(
                onPressed: () {


                  // get all location of user display it after user choose  redirect to gmap with exact latlng
                  Location.getByIdLocation("Location/GetByIdLocation").then((value) {
                    Locations=value;
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text(' مكان التوصيل'),
                            content: setupAlertDialogContainer(),
                          );});

                  });

                },
                color: Color(int.parse(Global.primaryColor)),
                elevation: 10.0,
                textColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18.0),
                ),
                padding: const EdgeInsets.all(0.0),
                child: Container(
                  padding: const EdgeInsets.all(10.0),
                  child: const Text(
                      'لطلب اوردر',
                      style: TextStyle(fontSize: 20)
                  ),
                )),
            const SizedBox(height: 100),
            RaisedButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => CustomerRequestLayout()
                  ));
                },
                color: Color(int.parse(Global.primaryColor)),
                elevation: 10.0,
                textColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18.0),
                ),
                padding: const EdgeInsets.all(0.0),
                child: Container(
                  padding: const EdgeInsets.all(10.0),
                  child: const Text(
                      ' طلباتي',
                      style: TextStyle(fontSize: 20)
                  ),
                )),
          ]
      ),
    );

  }


  Widget setupAlertDialogContainer() {
    return Container(
      height: 200.0,
      width: 200.0,
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: Locations.length,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            onTap: () {
              LatLng latlng = new LatLng( Locations[index].latitude,  Locations[index].longitude);
              Global.userLocationIdDeliever=Locations[index].id;
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => Gmap(currentPosition : latlng),
              ));
            },
            title:Text(Locations[index].title.toString(),
              style: TextStyle(fontSize: 15,
                color:Color(int.parse(Global.primaryColor)),
                fontFamily: Global.fontFamily,
                fontWeight: FontWeight.w400,), ),
          );
        },
      ),
    );
  }


  Future<void> choiceAction(String choices) async {

    if(choices.contains('تسجيل الخروج')){
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.remove('FirstEnter');
      prefs.remove('phone');
      prefs.remove('map_Appear');
      prefs.remove('id');
      prefs.remove('password');
      prefs.remove('userName');
      prefs.remove('latitude');
      prefs.remove('longitude');

      Navigator.of(context).pop();
      Navigator.of(context).push(MaterialPageRoute(
          builder: (context) =>SignUp()
      ));
    }
    // for future features example settings user etc...

  }

}