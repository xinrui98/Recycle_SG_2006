import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:flutter/cupertino.dart';
import 'package:tensorflow_lite_flutter/helpers/PinDropper.dart';
import 'dart:async';
import 'package:tensorflow_lite_flutter/screens/distance_calculator.dart';

class ManualLocationFinder extends StatefulWidget {
  final double lat;
  final double long;

  const ManualLocationFinder({Key key, this.lat, this.long})
      : super(key: key);

  @override
  _ManualLocationFinderState createState() =>
      _ManualLocationFinderState();
}

class _ManualLocationFinderState
    extends State<ManualLocationFinder> {
  LatLng currentPostion;
  List nearestTenBinsList = [];
  List nearestTenBinsLats = [];
  List nearestTenBinsLong = [];

  @override
  void initState() {
    // TODO: implement initState
    _getUserLocation();
    print("LAT LONG POSTAL CODE INIT STATE");
    print(widget.lat);
    print(widget.long);
    super.initState();
  }

  void _getUserLocation() async {
    print("LAT LONG POSTAL CODE");
    print(widget.lat);
    print(widget.long);

    var distanceCalculator = DistanceCalculator();
    nearestTenBinsList = distanceCalculator.main(widget.lat, widget.long);
    for (int i = 0; i < nearestTenBinsList.length; i++) {
      if (i % 2 == 0) {
        nearestTenBinsLats.add(nearestTenBinsList[i]);
      } else {
        nearestTenBinsLong.add(nearestTenBinsList[i]);
      }
    }
  }

  GoogleMapController mapController;
  Map<String, Marker> newMarkers = {};
  Map<String, Marker> markers = {};

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
    //PINDROPPER CODE
    mapController = controller;
    PinDropper pinDropper = new PinDropper();
    newMarkers = pinDropper.createPins(controller, widget.lat, widget.long);
    setState(() {
      markers = newMarkers;
    });
    print("entering the for loop");
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
          onMapCreated: _onMapCreated,
          initialCameraPosition: CameraPosition(
            target: LatLng(widget.lat, widget.long),
            zoom: 15.0,
          ),
          markers: Set<Marker>.of(markers.values),
        ),
      ),
    );
  }
}
