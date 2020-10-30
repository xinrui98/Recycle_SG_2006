import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:flutter/cupertino.dart';
import 'dart:async';
import 'package:tensorflow_lite_flutter/screens/distance_calculator.dart';

class LocationMapsPostalCodePage extends StatefulWidget {
  final double lat;
  final double long;

  const LocationMapsPostalCodePage({Key key, this.lat, this.long})
      : super(key: key);

  @override
  _LocationMapsPostalCodePageState createState() =>
      _LocationMapsPostalCodePageState();
}

class _LocationMapsPostalCodePageState
    extends State<LocationMapsPostalCodePage> {
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
    // var position = await GeolocatorPlatform.instance
    //     .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);

    // setState(() {
    //   currentPostion = LatLng(widget.lat, widget.long);
    // });
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

  Map<String, Marker> markers = {};

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
    // final nearestBinsLatsTest = [1.34948, 1.3404, 1.3328];
    // final nearestBinsLongsTest = [103.69456, 103.7090, 103.7433];
    //markers.clear();
    // var markerIDVal = markers.length + 1;
    // String mar = markerIDVal.toString();
    //
    // final MarkerId markerId = MarkerId(mar);
    // final Marker marker = Marker(
    //   markerId: markerId,
    //   position: LatLng(widget.lat, widget.long),
    //   icon: BitmapDescriptor.fromAssetImage("assets/download.jpeg"),
    // );

    // final nearestBinsLatsTest = [1.34948, 1.3404, 1.3328];
    // final nearestBinsLongsTest = [103.69456, 103.7090, 103.7433];
    //markers.clear();
    for (int i = 0; i < 10; i++) {
      var markerIDVal = markers.length + 1;
      String mar = markerIDVal.toString();
      print(nearestTenBinsLats[i]);
      print(nearestTenBinsLong[i]);

      final MarkerId markerId = MarkerId(mar);
      final Marker marker = Marker(
        markerId: markerId,
        position: LatLng(
            nearestTenBinsLats[i], nearestTenBinsLong[i]), // change to bins
      );

      setState(() {
        markers[markerId.toString()] = marker;
      });
    }
    print("MARKERS SET");
    print(markers);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title:
              // Text('${currentPostion.latitude}, ${currentPostion.longitude}'),
              Text('10 Nearest Bins'),
          backgroundColor: Colors.blue,
        ),
        body: GoogleMap(
          onMapCreated: _onMapCreated,
          initialCameraPosition: CameraPosition(
            // target: LatLng(widget.lat,widget.long),
            // target: LatLng(1.3543, 103.6869),
            target: LatLng(widget.lat, widget.long),
            zoom: 15.0,
          ),
          markers: Set<Marker>.of(markers.values),
        ),
        // floatingActionButton: FloatingActionButton(
        //   onPressed: () {
        //     // Add your onPressed code here!
        //     _getCurrentLocation();
        //   },
        //   child: Icon(Icons.navigation),
        //   backgroundColor: Colors.green,
        // ),
        // floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
      ),
    );
  }
}
