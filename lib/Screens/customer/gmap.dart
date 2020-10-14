import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:talabatk_flutter/Entities/constants.dart';
import 'package:talabatk_flutter/Entities/global.dart';
import 'package:talabatk_flutter/Entities/user.dart';
import 'package:talabatk_flutter/Screens/customer/customer_request_page.dart';
import 'package:talabatk_flutter/Screens/signup.dart';



class Gmap extends StatefulWidget {
  LatLng currentPosition;
  Gmap({Key key, @required this.currentPosition}): super(key: key);
  @override
  State<StatefulWidget> createState() => _GMapState(currentPosition);
}

class _GMapState extends State<Gmap> {
  List<User> nearestShops=[];
  List<Marker> allMarkers =[];

  LatLng _currentPosition;
  _GMapState(this._currentPosition);
  Completer<GoogleMapController> _controller = Completer();
  double zoomVal=20.0;



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:Text(Global.appName),
        backgroundColor: Color(int.parse(Global.primaryColor)),
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
      body:Stack(
        children: [
          _googleMap(context),
          _buildContainer(),
        ],
      ),
    );
  }

  Widget _googleMap(BuildContext context)  {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: GoogleMap(

        myLocationEnabled:true,
        mapType: MapType.normal  ,
        zoomControlsEnabled: false,
        initialCameraPosition:  CameraPosition(
            target:_currentPosition,
            zoom: 15),
        onMapCreated: (GoogleMapController controller){
           _controller.complete(controller);
        },
        markers: Set.from(allMarkers),
      ),

    );
  }


  @override
  void initState() {
    super.initState();
    getAllNearestShops();
    allMarkers.add(Marker(
        markerId:MarkerId("myMarker"),
        infoWindow: InfoWindow(title:"مكان التوصيل"),
        draggable: false,
        position: _currentPosition,
        icon: BitmapDescriptor.defaultMarkerWithHue(
          BitmapDescriptor.hueBlue,
        )
    ));

  }

  Future<void> getAllNearestShops() async  {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    User.getNearestShops("Talabatk/GetNearestShops",prefs.getString('phone')).then((value){
      nearestShops=value;

      for(int i=0;i<nearestShops.length;i++)
      {
        LatLng _position = new LatLng(nearestShops[i].latitude, nearestShops[i].longitude);
        setState(() {
          allMarkers.add(Marker(
              markerId:MarkerId(nearestShops[i].id.toString()),
              infoWindow: InfoWindow(title:nearestShops[i].userName),
              draggable: false,
              position: _position,
              icon: BitmapDescriptor.defaultMarkerWithHue(
                BitmapDescriptor.hueViolet,
              )
          ));
        });
      }
    });
  }


  Widget _boxes(String _image,double lat , double long, String name,int index,String mobileNumber)
  {
    return GestureDetector(
      onTap: (){
        _goToLocation(lat,long);
      },
      child: Container(
          child:new FittedBox(
            child: Material(
              color: Colors.white,
              elevation: 4.0,
              borderRadius: BorderRadius.circular(24.0),
              shadowColor: Color(int.parse(Global.primaryColor)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: 180,
                    height: 200,
                    child: ClipRRect(
                      borderRadius: new BorderRadius.circular(24.0),
                      child: Image(
                        fit:BoxFit.fill,
                        image:NetworkImage(_image),
                      ),
                    ),
                  ),
                  Column(
                    children: [
                      Container(
                       child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(name, style: TextStyle(
                            fontFamily: Global.fontFamily,
                            fontWeight: FontWeight.w600,
                            fontSize: 20,
                            color: Color(int.parse(Global.primaryColor))
                        )),
                               ),
                        ),

                      RaisedButton(
                       onPressed: () {
                         // send user to request screen to request items from exact shop
                         print("hey there"+ name);
                         Navigator.of(context).push(MaterialPageRoute(
                           builder: (context) => UserRequest(shop:nearestShops[index]),
                         ));

                       },
                       elevation: 2.0,
                          color: Color(int.parse(Global.primaryColor)),
                          textColor: Colors.white,
                          padding: const EdgeInsets.all(0.0),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          child: Container(
                            padding: const EdgeInsets.all(10.0),
                            child: const Text(
                                'طلب اوردر',
                                style: TextStyle(fontSize: 15)
                            ),
                          )
                          ),
                      Container(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(mobileNumber, style: TextStyle(
                              fontFamily: Global.fontFamily,
                              fontWeight: FontWeight.w600,
                              fontSize: 12,
                              color: Color(int.parse(Global.primaryColor))
                          )),
                        ),
                      ),
                      ]
                  ),

                ],

              ),
            ),
          )
      ),
    );
  }


  Widget _buildContainer() {

    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 20.0),
        height: 180.0,
        child: ListView.builder(
          itemCount: nearestShops.length,
          itemBuilder: (BuildContext context,int i)
          {
            return  Padding(
              padding: const EdgeInsets.all(8.0),
              child: _boxes(
                  "https://wheelandbarrow.com.au/skins/customer/modules/PerceptionSystemPvtLtd/Storelocator/storelocator/images/default-store.png",
                  nearestShops[i].latitude, nearestShops[i].longitude,nearestShops[i].userName,i,nearestShops[i].mobileNumber),
            );
          },
          scrollDirection: Axis.horizontal,
        ),
      ),
    );
  }

  Future<void> _goToLocation(double lat,double long) async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(target: LatLng(lat,long), zoom:15, tilt: 40.0,bearing:45.0)));
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
    // for future features

  }

}