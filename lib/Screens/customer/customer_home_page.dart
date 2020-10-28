import 'package:Talabatk/Widgets/utils.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:Talabatk/Entities/constants.dart';
import 'package:Talabatk/Entities/global.dart';
import 'package:Talabatk/Screens/customer/customer_requests_layout.dart';
import 'gmap.dart';
import 'customer_location_editor.dart';
import 'package:Talabatk/Entities/location.dart';




class CustomerHomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _State();
}


class _State extends State<CustomerHomePage>
{

  List<Location> Locations =[];
  @override
  Widget build(BuildContext context) {
    String _title="Home Page";
    return Scaffold (
        appBar: Utils.appBarusers(context,_title),
        body:customerMenuWidget()

    );
  }

  Widget customerMenuWidget() {
    return Center(

      child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Utils.title(100, 100),
            const SizedBox(height: 150),
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
            const SizedBox(height: 40),
            RaisedButton(
                onPressed: () {


                  // get all location of user display it after user choose  redirect to gmap with exact latlng
                  Location.getByIdLocation("Location/GetByIdLocation").then((value) {
                    Locations=value;
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text(' مكان التوصيل',
                              style : TextStyle(
                              color: Color(int.parse(Global.primaryColor)),
                                fontFamily: Global.fontFamily,
                                fontWeight: FontWeight.w700,
                                fontSize: 20),
                              textAlign: TextAlign.center,
                            ),
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
            const SizedBox(height: 40),
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
            title:Text(Locations[index].title.toString(),textAlign: TextAlign.center,
              style: TextStyle(fontSize: 15,
                color:Color(int.parse(Global.primaryColor)),
                fontFamily: Global.fontFamily,
                fontWeight: FontWeight.w400,), ),
          );
        },
      ),
    );
  }




}