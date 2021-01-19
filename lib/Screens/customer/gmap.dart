import 'dart:async';
import 'package:Talabatk/Entities/app_localizations.dart';
import 'package:Talabatk/Widgets/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter/material.dart';
import 'package:Talabatk/Entities/global.dart';
import 'package:Talabatk/Entities/user.dart';
import 'package:Talabatk/Screens/customer/customer_request_page.dart';




class Gmap extends StatefulWidget {
  LatLng currentPosition;
  Gmap({Key key, @required this.currentPosition}): super(key: key);
  @override
  State<StatefulWidget> createState() => _GMapState(currentPosition);
}

class _GMapState extends State<Gmap> {

  List<User> nearestShops=[];
  List<Marker> allMarkers =[];
  BitmapDescriptor pinLocationIcon;
  BitmapDescriptor pinPharmacyIcon;
  List<User> pharmacy=[];
  List<User> shops=[];
  List<User> restaurants=[];
  List<User> atar=[];



  //0 all SHOP 1 All pharmacy 2 All supermarket 3 All Restaurants 4 All Atara
  int numberOfList=0;
  LatLng currentPosition;
  _GMapState(this.currentPosition);
  Completer<GoogleMapController> _controller = Completer();
  double zoomVal=20.0;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Utils.appBarusers(context,AppLocalizations.of(context).translate('nearest_shop') ),
      body:Column(
        children: [
          Expanded(
            flex: 1,
            child: Row(
              mainAxisAlignment:  MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(child: pharmacyIcon()),
                Expanded(child: shopIcon()),
                Expanded(child: restaurantIcon()),
                Expanded(child:ataraIcon()),
              ],
            ),
          ),
          Expanded(
            flex:12,
            child: Stack(
              children: [
                _googleMap(context),

                _buildContainer(),
              ],
            ),
          ),
        ],
      )
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
            target:currentPosition,
            zoom: 15),
        onMapCreated: (GoogleMapController controller){
           _controller.complete(controller);
           setState(() {
             allMarkers.add(Marker(
                 markerId:MarkerId("myMarker"),
                 infoWindow: InfoWindow(title:"مكان التوصيل"),
                 draggable: false,
                 position: currentPosition,
                 icon: pinLocationIcon
             ));
           });
        },
        markers: Set.from(allMarkers),
      ),

    );
  }


  @override
  void initState() {
    super.initState();
    getAllNearestShops();
    BitmapDescriptor.fromAssetImage(
        ImageConfiguration(devicePixelRatio: 2.5),
        'images/destinationmarker.png').then((onValue) {
      pinLocationIcon = onValue;
    });



  }

  Future<void> getAllNearestShops() async  {

    User.getNearestShops("Talabatk/GetNearestShops",currentPosition.latitude,currentPosition.longitude).then((value){
      nearestShops=value;

      for(int i=0;i<nearestShops.length;i++)
      {
        if(nearestShops[i].mapAppear==1)
          shops.add(nearestShops[i]);
        else if(nearestShops[i].mapAppear==2)
          pharmacy.add(nearestShops[i]);
        else if (nearestShops[i].mapAppear==3)
          restaurants.add(nearestShops[i]);
        else if(nearestShops[i].mapAppear==4)
          atar.add(nearestShops[i]);

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


  Widget _boxesBuilder(String _image,double lat , double long, String name,int index,String mobileNumber,User shop) {
    return GestureDetector(
      onTap: (){
        _goToLocation(lat,long);
      },
      child: Container(
        height: 130,
          width: 150,
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
                    width: 100,
                    height: 100,
                    child: ClipRRect(
                      borderRadius: new BorderRadius.circular(24.0),
                      child: Image(
                        fit: BoxFit.fill,
                        image:AssetImage(_image),
                      ),
                    ),
                  ),
                  Column(
                    children: [
                      Container(
                       child: Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Text(name, style: TextStyle(
                            fontFamily: Global.fontFamily,
                            fontWeight: FontWeight.w600,
                            fontSize: 12,

                        )),
                               ),
                        ),
                      Container(
                        height: 30,
                        width: 70,
                        child: RaisedButton(
                         onPressed: () {
                           // send user to request screen to request items from exact shop
                           Navigator.of(context).push(MaterialPageRoute(
                             builder: (context) => UserRequest(shop:shop),
                           ));
                             },
                            color: Color(int.parse(Global.primaryColor)),
                            textColor: Colors.white,
                            padding: const EdgeInsets.all(0.0),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            child: Container(
                              padding: const EdgeInsets.all(0.0),
                              child: const Text(
                                  'طلب اوردر',
                                  style: TextStyle(fontSize: 12)
                              ),
                            )
                            ),
                      ),
                     /*
                      Container(
                        child: Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Text(mobileNumber, style: TextStyle(
                              fontFamily: Global.fontFamily,
                              fontWeight: FontWeight.w600,
                              fontSize: 8,

                          )),
                        ),
                      ),
                      */
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
      if (numberOfList == 0)
        shopList=nearestShops;
      else if(numberOfList == 1)
        shopList=pharmacy;
      else if(numberOfList == 2)
        shopList=shops;
      else if(numberOfList == 3)
        shopList=restaurants;
      else if(numberOfList == 4)
        shopList=atar;
    });
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 5.0),
        height: 150.0,
        child: ListView.builder(
          itemCount: shopList.length,
          itemBuilder: (BuildContext context,int i)
          {

            String image= "images/";
            String pharmacy = "snake.png";
            String supermarket = "supermarket.png";
            String restaurants = "restaurant.png";
            String atar= "atar.png";

            if(shopList[i].mapAppear==1)
              image+=supermarket;
            else if (shopList[i].mapAppear==2)
              image+=pharmacy;
            else if( shopList[i].mapAppear==3)
               image+=restaurants;
            else if(shopList[i].mapAppear==4)
              image+=atar;


            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: _boxesBuilder(
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

        alignment: Alignment.topCenter,
        child:FlatButton(
          child: Column (
            mainAxisSize : MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(Icons.local_pharmacy,color:Colors.lightGreen,
              size: 25,),

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
        position: currentPosition,
        icon: pinLocationIcon
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
                BitmapDescriptor.hueGreen,
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
        alignment: Alignment.topCenter,
        child:FlatButton(
          child: Column (
            mainAxisSize : MainAxisSize.min,
            children: [
              Icon(Icons.shopping_cart,color:Colors.blue,
              size: 25,),
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
        position: currentPosition,
        icon: pinLocationIcon
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
                BitmapDescriptor.hueBlue,
              )
          ));
        });
      }

    setState(() {
      numberOfList=2;
    });
  }

  //RESTAURANT
  Widget restaurantIcon() {
    return Container(

      alignment: Alignment.topCenter,
      child:FlatButton(
        child: Column (
          mainAxisSize : MainAxisSize.min,
          children: [
            Icon(Icons.restaurant,color:Colors.redAccent,
              size: 25,),

          ],
        ),
        onPressed: () {
          getAllRestaurants();
        },
      ), );
  }
  void getAllRestaurants()  {
    setState(() {
      allMarkers.clear();
      nearestShops.clear();
    });
    allMarkers.add(Marker(
        markerId:MarkerId("myMarker"),
        infoWindow: InfoWindow(title:"مكان التوصيل"),
        draggable: false,
        position: currentPosition,
        icon:pinLocationIcon
    ));
    for(int i=0;i<restaurants.length;i++)
    {
      LatLng _position = new LatLng(restaurants[i].latitude, restaurants[i].longitude);
      setState(() {
        allMarkers.add(Marker(
            markerId:MarkerId(restaurants[i].id.toString()),
            infoWindow: InfoWindow(title:restaurants[i].userName),
            draggable: false,
            position: _position,
            icon: BitmapDescriptor.defaultMarkerWithHue(
              BitmapDescriptor.hueRed,
            )
        ));
      });
    }
    setState(() {
      numberOfList=3;
    });

  }

  //ATARA
  Widget ataraIcon() {
    return Container(

      alignment: Alignment.topCenter,
      child:FlatButton(
        child: Column (
          mainAxisSize : MainAxisSize.min,
          children: [
            Icon(Icons.wb_shade,color:Colors.deepOrangeAccent,
              size: 25,),

          ],
        ),
        onPressed: () {
          getAllAtaras();
        },
      ), );
  }
  void getAllAtaras()  {
    setState(() {
      allMarkers.clear();
      nearestShops.clear();
    });
    allMarkers.add(Marker(
        markerId:MarkerId("myMarker"),
        infoWindow: InfoWindow(title:"مكان التوصيل"),
        draggable: false,
        position: currentPosition,
        icon:pinLocationIcon
    ));
    for(int i=0;i<atar.length;i++)
    {
      LatLng _position = new LatLng(atar[i].latitude, atar[i].longitude);
      setState(() {
        allMarkers.add(Marker(
            markerId:MarkerId(atar[i].id.toString()),
            infoWindow: InfoWindow(title:atar[i].userName),
            draggable: false,
            position: _position,
            icon: BitmapDescriptor.defaultMarkerWithHue(
              BitmapDescriptor.hueOrange,
            )
        ));
      });
    }
    setState(() {
      numberOfList=4;
    });

  }

}
