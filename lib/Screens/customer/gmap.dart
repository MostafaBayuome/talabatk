import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:Talabatk/Entities/constants.dart';
import 'package:Talabatk/Entities/global.dart';
import 'package:Talabatk/Entities/user.dart';
import 'package:Talabatk/Screens/customer/customer_request_page.dart';
import 'package:Talabatk/Screens/signup.dart';



class Gmap extends StatefulWidget {
  LatLng currentPosition;
  Gmap({Key key, @required this.currentPosition}): super(key: key);
  @override
  State<StatefulWidget> createState() => _GMapState(currentPosition);
}

class _GMapState extends State<Gmap> {
  List<User> nearestShops=[];
  List<Marker> allMarkers =[];

  List<User> pharmacy=[];
  List<User> shops=[];
  //0 all SHOP 1 All pharmacy 2 All supermarket
  int numberOfList=0;
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
              return Constants.customerChoices.map((String choice){
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
          Row(
            mainAxisAlignment:  MainAxisAlignment.center,
            children: [
              pharmacyIcon(),
              shopIcon(),
            ],
          ),
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
        if(nearestShops[i].mapAppear==1)
          shops.add(nearestShops[i]);
        else if(nearestShops[i].mapAppear==2)
          pharmacy.add(nearestShops[i]);

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


  Widget _boxes(String _image,double lat , double long, String name,int index,String mobileNumber,User shop)
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
                        image:AssetImage(_image),
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

                         Navigator.of(context).push(MaterialPageRoute(
                           builder: (context) => UserRequest(shop:shop),
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
    List<User> shopList =[];
    setState(() {
      if(  numberOfList == 0)
        shopList=nearestShops;
      else if(numberOfList == 1)
        shopList=pharmacy;
      else if(numberOfList == 2)
        shopList=shops;
    });
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 20.0),
        height: 180.0,
        child: ListView.builder(
          itemCount: shopList.length,
          itemBuilder: (BuildContext context,int i)
          {

            String image= "images/";
            String pharmacy = "snake.png";
            String supermarket = "supermarket.png";
            if(shopList[i].mapAppear==1)
              image+=supermarket;
            else if (shopList[i].mapAppear==2)
              image+=pharmacy;


            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: _boxes(
                   image,
                  shopList[i].latitude, shopList[i].longitude,shopList[i].userName,i,shopList[i].mobileNumber,shopList[i]),
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

  //PHARMACY
  Widget pharmacyIcon() {
    return Container(
      padding: EdgeInsets.fromLTRB(0, 10.0, 0, 0),
        alignment: Alignment.topCenter,
        child:FlatButton(
          child: Column (
            mainAxisSize : MainAxisSize.min,
            children: [
              Icon(Icons.local_pharmacy,color:Color(int.parse(Global.primaryColor)),
              size: 30,),

            ],
          ),
          onPressed: () {
            getAllPharmacies();
          },
        ), );
  }
  void getAllPharmacies()  {
    setState(() {
      allMarkers.clear();
      nearestShops.clear();
    });
    allMarkers.add(Marker(
        markerId:MarkerId("myMarker"),
        infoWindow: InfoWindow(title:"مكان التوصيل"),
        draggable: false,
        position: _currentPosition,
        icon: BitmapDescriptor.defaultMarkerWithHue(
          BitmapDescriptor.hueBlue,
        )
    ));
    for(int i=0;i<pharmacy.length;i++)
      {
        LatLng _position = new LatLng(pharmacy[i].latitude, pharmacy[i].longitude);
        setState(() {
          allMarkers.add(Marker(
              markerId:MarkerId(pharmacy[i].id.toString()),
              infoWindow: InfoWindow(title:pharmacy[i].userName),
              draggable: false,
              position: _position,
              icon: BitmapDescriptor.defaultMarkerWithHue(
                BitmapDescriptor.hueViolet,
              )
          ));
        });
      }
    setState(() {
      numberOfList=1;
    });

  }

  // SHOP
  Widget shopIcon(){
   return Container(
        padding: EdgeInsets.fromLTRB(0, 10.0, 0, 0),
        alignment: Alignment.topCenter,
        child:FlatButton(
          child: Column (
            mainAxisSize : MainAxisSize.min,
            children: [
              Icon(Icons.shopping_cart,color:Color(int.parse(Global.primaryColor)),
              size: 30,),

            ],
          ),
          onPressed: () {
            getAllShops();
          },
        ),
     );
  }
  void getAllShops()  {
    setState(() {
      allMarkers.clear();
      nearestShops.clear();
    });

    allMarkers.add(Marker(
        markerId:MarkerId("myMarker"),
        infoWindow: InfoWindow(title:"مكان التوصيل"),
        draggable: false,
        position: _currentPosition,
        icon: BitmapDescriptor.defaultMarkerWithHue(
          BitmapDescriptor.hueBlue,
        )
    ));
    for(int i=0;i<shops.length;i++)
      {
        LatLng _position = new LatLng(shops[i].latitude, shops[i].longitude);
        setState(() {
          allMarkers.add(Marker(
              markerId:MarkerId(shops[i].id.toString()),
              infoWindow: InfoWindow(title:shops[i].userName),
              draggable: false,
              position: _position,
              icon: BitmapDescriptor.defaultMarkerWithHue(
                BitmapDescriptor.hueViolet,
              )
          ));
        });
      }

    setState(() {
      numberOfList=2;
    });
  }


  Future<void> choiceAction(String choices) async {

    if(choices.contains('تسجيل الخروج')){
      SharedPreferences prefs = await SharedPreferences.getInstance();

      prefs.remove('phone');
      prefs.remove('map_Appear');
      prefs.remove('id');
      prefs.remove('password');
      prefs.remove('userName');
      prefs.remove('latitude');
      prefs.remove('longitude');


      Navigator.of(context).pushAndRemoveUntil(  MaterialPageRoute(
          builder: (context) =>SignUp()
      ),ModalRoute.withName("/Home"));
    }
    // for future features

  }
}
