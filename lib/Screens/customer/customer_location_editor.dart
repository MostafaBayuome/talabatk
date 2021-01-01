import 'package:Talabatk/Entities/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:geocoder/geocoder.dart';
import 'package:geolocator/geolocator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:Talabatk/Entities/global.dart';
import 'dart:async';
import 'package:Talabatk/Entities/location.dart';
import 'package:Talabatk/Widgets/utils.dart';
import 'customer_home_page.dart';

class LocationEditor extends StatefulWidget {

  @override
  State<StatefulWidget> createState() => _State();

}

class _State  extends State<LocationEditor>{

  String _locationName = null;


  TextEditingController _locationNameController = new TextEditingController();

  Position _currentposition=null;
  Address address;
  int _state = 0;

  @override
  Widget build(BuildContext context) {

    String _title= AppLocalizations.of(context).translate('edit_location');
    return Scaffold(
        appBar:Utils.appBarusers(context,_title),
      floatingActionButton:Container(
        child: FittedBox(
          child: FloatingActionButton(
            backgroundColor:Color(int.parse(Global.primaryColor)) ,
            child:IconButton(
              icon: Icon(Icons.location_on),
              onPressed: () {
                showAlertDialog(context);
              },
            )
          ),
        ),
      ),
      body: Container(
        child: FutureBuilder(
          future: Location.getByIdLocation("Location/GetByIdLocation"),
          builder:(BuildContext context,AsyncSnapshot snapshot){
            if(snapshot.data == null)  {
                return Container(
                  child: Center(
                    child: CircularProgressIndicator()
                  ),
                );
              }
            else{
              return ListView.builder(
                padding: EdgeInsets.all(20),
                itemCount: snapshot.data.length,
                itemBuilder: (BuildContext context,int index){
                  return ListTile(

                    title:Center(
                      child: RaisedButton(

                            onPressed: () { 
                              // long press delete location future work
                            },
                            color: Color(int.parse(Global.primaryColor)),
                            elevation: 10.0,
                            textColor: Colors.white,
                            padding: const EdgeInsets.all(15.0),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30.0),
                            ),
                        child: Text(snapshot.data[index].title ,style: TextStyle(
                            fontFamily: Global.fontFamily,
                            fontWeight: FontWeight.w600,
                            fontSize: 20,
                            color: Colors.white
                        ),),
                      ),
                    ) ,

                  );
                },
              );
            }
          },
        ),
      ),
    );
  }

  showAlertDialog(BuildContext context) {
    // set up the button
    Widget okButton = FlatButton(
      child: Text(AppLocalizations.of(context).translate('add_location'),style: TextStyle(
          fontFamily: Global.fontFamily,
          fontWeight: FontWeight.w600,
          fontSize: 15,
          color: Color(int.parse(Global.primaryColor))
      )),
      onPressed: () async {
        
        setState((){
          _locationName = _locationNameController.text;

        });
        if(_currentposition!=null && _locationName!=null)
          {
            // save new position post request
            // send user to CustomerHomePage()
            if(_state==0) {
                //_state for controlling user press not to add same location
                _state=1;
                SharedPreferences prefs = await SharedPreferences.getInstance();
                int user_id=prefs.getInt('id');


                final coordinates= new Coordinates(_currentposition.latitude,_currentposition.longitude);
                convertCoordinatesToAddress(coordinates).then((value){
                  address=value;
                  Location.addLocation("Location/AddLocation",user_id,_currentposition.latitude,_currentposition.longitude,_locationName,address.addressLine).then((value){
                    Utils.toastMessage(AppLocalizations.of(context).translate('added_successfully'));
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => CustomerHomePage()
                    ));
                  });

                });

              }
          }
        else{
          Utils.toastMessage(AppLocalizations.of(context).translate('right_info'));
        }
      },
    );
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      contentPadding: const EdgeInsets.all(16.0),
      title: Center(
          child:Text(AppLocalizations.of(context).translate('add_your_current_location'),style: TextStyle(
          fontFamily: Global.fontFamily,
          fontWeight: FontWeight.w800,
          fontSize: 15,
          color: Color(int.parse(Global.primaryColor))
      ))),


      content:Row(
        children: [
          IconButton(
            icon: Icon(Icons.location_on),
            color: Color(int.parse(Global.primaryColor)),
            onPressed: () {
              _currentposition = _getLocation() as Position;
            },
          ),
          Expanded(
            child: new TextField(
              controller: _locationNameController,
              autofocus: true,
              decoration: new InputDecoration(
                  labelText: AppLocalizations.of(context).translate('place_name') , hintText: AppLocalizations.of(context).translate('work'),),
            ),
          ),

        ],
      ),
      actions: [
           okButton ,
      ],
    );
    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
  // get current location of user
  Future<Position> _getLocation() async{
    _currentposition = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    print(_currentposition);
    return _currentposition;
  }

  Future<Address> convertCoordinatesToAddress(Coordinates coordinates) async{
    var addresses = await Geocoder.local.findAddressesFromCoordinates(coordinates);
    return addresses.first;
  }
}



