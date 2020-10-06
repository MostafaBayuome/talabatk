import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:talabatk_flutter/Entities/constants.dart';
import 'package:talabatk_flutter/Entities/global.dart';
import 'package:talabatk_flutter/Screens/user_request.dart';
import '../Entities/user.dart';
import 'signup.dart';


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

  Future<void> getAllNearestShops() async {
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


  Widget _boxes(String _image,double lat , double long, String name,int index)
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
                        child: Text(name),
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
                            borderRadius: BorderRadius.circular(18.0),
                          ),
                          child: Container(
                            padding: const EdgeInsets.all(10.0),
                            child: const Text(
                                'طلب اوردر',
                                style: TextStyle(fontSize: 20)
                            ),
                          )
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
                  "https://lh5.googleusercontent.com/p/AF1QipO3VPL9m-b355xWeg4MXmOQTauFAEkavSluTtJU=w225-h160-k-no",
                  nearestShops[i].latitude, nearestShops[i].longitude,nearestShops[i].userName,i),
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
      prefs.remove('value');
      prefs.remove('phone');
      prefs.remove('map_Appear');


      Navigator.of(context).pop();
      Navigator.of(context).push(MaterialPageRoute(
          builder: (context) =>SignUp()
      ));
    }
    // for future features

  }

}