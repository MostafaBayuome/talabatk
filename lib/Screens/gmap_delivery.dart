import 'dart:async';
import 'package:Talabatk/Entities/app_localizations.dart';
import 'package:Talabatk/Entities/delivery_location.dart';
import 'package:Talabatk/Entities/global.dart';
import 'package:Talabatk/Entities/request.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GmapDelivery extends StatefulWidget {

  LatLng deliveryPosition;
  Request request;
  LatLng customerPosition;
  GmapDelivery({Key key, @required this.deliveryPosition , @required this.request, @required this.customerPosition}): super(key: key);
  @override
  _GmapDeliveryState createState() => _GmapDeliveryState(deliveryPosition,request,customerPosition);

}

class _GmapDeliveryState extends State<GmapDelivery> {

  LatLng customerPosition;
  Request request;
  BitmapDescriptor LocationIcon;
  BitmapDescriptor  deliveryIcon;
  List<Marker> allMarkers =[];
  LatLng _deliveryPosition;
  _GmapDeliveryState(this._deliveryPosition,this.request,this.customerPosition);
  Completer<GoogleMapController> _controller = Completer();
  Marker marker;

  @override
  void initState() {
    super.initState();

    BitmapDescriptor.fromAssetImage(
        ImageConfiguration(devicePixelRatio: 2.5),
        'images/destinationmarker.png').then((onValue) {
          LocationIcon = onValue;
    });

    BitmapDescriptor.fromAssetImage(
        ImageConfiguration(devicePixelRatio: 4.0),
        'images/deliveryicon.png').then((onValue) {
      deliveryIcon = onValue;
    });
    getLastLocationOfDelivery();
  }

  @override
  void dispose() {
    Global.location_timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          _googleMap(context),
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
            target:_deliveryPosition,
            zoom: 15),
        onMapCreated: (GoogleMapController controller){
          _controller.complete(controller);
           setState(() {
             allMarkers.add(Marker(
                 markerId:MarkerId("customerid"),
                 infoWindow: InfoWindow(title:AppLocalizations.of(context).translate('Place_to_delivery_to') ),
                 draggable: false,
                 position: customerPosition,
                 icon:  LocationIcon
             ));

             allMarkers.add(Marker(
                 markerId:MarkerId("deliveryid"),
                   infoWindow: InfoWindow(title:AppLocalizations.of(context).translate('delivery_location') ),
                 draggable: false,
                 position: _deliveryPosition,
                 icon: deliveryIcon
             ));


           });
        },
        markers: Set.from(allMarkers),
      ),

    );
  }

  Future getLastLocationOfDelivery(){
    try{
      Global.delivery_timer = Timer.periodic(Duration(seconds: 10), (Timer t) async {
        DeliveryLocation.getByIdLastLocation(request.delivery_id).then((value) {
          if(value!=null){

            setState(() {
              _deliveryPosition  = new LatLng(value.latitude, value.longitude);
              if(allMarkers.length>1)
              {
                allMarkers[1] = Marker(
                    markerId:MarkerId("deliveryid"),
                    infoWindow: InfoWindow(title:AppLocalizations.of(context).translate('delivery_location')),
                    draggable: false,
                    position: _deliveryPosition,
                    icon: deliveryIcon
                );
              }
            });
          }

        });
      });
    }catch(Exception)
    {
      print(Exception);
    }
  }
}
