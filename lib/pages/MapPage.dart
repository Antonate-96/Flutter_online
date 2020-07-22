import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:url_launcher/url_launcher.dart';


class MapPage extends StatefulWidget{
  MapPage({Key key }) : super(key: key);

  @override
  _MapPageState createState() => _MapPageState();
}
class _MapPageState extends State<MapPage> {
Completer<GoogleMapController> _controller = Completer();

_openGoogleMapApp(double lat, double long) async{
  var url = 'https://www.google.com/maps/search/?api=1&query=$lat,$long';
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('map'),
      ),
      body: GoogleMap(
        mapType: MapType.normal,
        markers: <Marker>[
          Marker(
            markerId:  MarkerId('marker1'),
            position:  LatLng(13.80564244, 100.5746134),
            icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueMagenta),
            infoWindow: InfoWindow(
              title : 'อบรม flutter',
              snippet: 'day 10-15/06/20',
              onTap: () {
                _openGoogleMapApp(13.80564244, 100.5746134);
              }
            )
          ),
        ].toSet(),
        initialCameraPosition: CameraPosition(
          target: LatLng(13.80564244, 100.5746134),
          zoom: 16,
        ),
        
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
      ),
    );
  }
}