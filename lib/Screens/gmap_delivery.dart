import 'dart:async';

import 'package:Talabatk/Entities/location.dart';
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

  List<Marker> allMarkers =[];
  LatLng _deliveryPosition;
  _GmapDeliveryState(this._deliveryPosition,this.request,this.customerPosition);
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
    allMarkers.add(Marker(
        markerId:MarkerId("customerid"),
        infoWindow: InfoWindow(title:"مكان التوصيل"),
        draggable: false,
        position: customerPosition,
        icon: BitmapDescriptor.defaultMarkerWithHue(
          BitmapDescriptor.hueViolet,
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
