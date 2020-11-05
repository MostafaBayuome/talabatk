import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GmapDelivery extends StatefulWidget {
  LatLng deliveryPosition;
  GmapDelivery({Key key, @required this.deliveryPosition}): super(key: key);
  @override
  _GmapDeliveryState createState() => _GmapDeliveryState(deliveryPosition);
}

class _GmapDeliveryState extends State<GmapDelivery> {
  // Delivery position
  List<Marker> allMarkers =[];
  LatLng _deliveryPosition;
  _GmapDeliveryState(this._deliveryPosition);
  Completer<GoogleMapController> _controller = Completer();
  Marker marker;

  @override
  void initState() {
    super.initState();
    allMarkers.add(Marker(
        markerId:MarkerId("deliveryid"),
        infoWindow: InfoWindow(title:"مكان الطيار"),
        draggable: false,
        position: _deliveryPosition,
        icon: BitmapDescriptor.defaultMarkerWithHue(
          BitmapDescriptor.hueBlue,
        )
    ));
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
        },
        markers: Set.from(allMarkers),
      ),

    );
  }



}
