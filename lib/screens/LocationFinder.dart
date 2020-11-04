import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:flutter/cupertino.dart';
import 'package:tensorflow_lite_flutter/helpers/PinDropper.dart';
import 'dart:async';
import 'package:tensorflow_lite_flutter/screens/distance_calculator.dart';

class LocationFinder extends StatefulWidget {
  final double lat;
  final double long;

  const LocationFinder({Key key, this.lat, this.long}) : super(key: key);

  @override
  _LocationFinderState createState() => _LocationFinderState();
}

class _LocationFinderState extends State<LocationFinder> {
  LatLng currentPosition;
  double currentLat;
  double currentLong;

  @override
  void initState() {
    _getUserLocation();

    super.initState();
  }


  void _getUserLocation() async {
    var position = await GeolocatorPlatform.instance
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    setState(() {
      currentPosition = LatLng(position.latitude, position.longitude);
      currentLat = position.latitude;
      currentLong = position.longitude;
    });

  }

  GoogleMapController mapController;
  Map<String, Marker> markers = {};
  Map<String, Marker> newMarkers = {};


  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
    PinDropper pinDropper = new PinDropper();
    newMarkers = pinDropper.createPins(controller, currentLat,currentLong);
    setState(() {
      markers = newMarkers;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title:
              Text('10 Nearest Bins'),
          backgroundColor: Colors.blue,
        ),
        body: GoogleMap(
          myLocationEnabled: true,
          onMapCreated: _onMapCreated,
          initialCameraPosition: CameraPosition(
            target: LatLng(currentLat, currentLong),
            zoom: 15.0,
          ),
          markers: Set<Marker>.of(markers.values),
        ),
      ),
    );
  }
}
