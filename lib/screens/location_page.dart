import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'dart:async';
import 'package:geocoder/services/base.dart';

class LocationPage extends StatefulWidget {
  @override
  _LocationPageState createState() => _LocationPageState();
}

class _LocationPageState extends State<LocationPage> {
  String _locationMessage = "";

  void _getCurrentLocation() async {
    final position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    print(position);

    setState(() {
      _locationMessage = "${position.latitude}, ${position.longitude}";
    });
  }

  @override
  Widget build(BuildContext context) {


    return MaterialApp(
        title: 'Flutter Demo',
        home: Scaffold(
            appBar: AppBar(title: Text("Location Services")),
            body: Align(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(_locationMessage),
                  FlatButton(
                      onPressed: () {
                        _getCurrentLocation();
                      },
                      color: Colors.green,
                      child: Text("Find Location")),
                  // IconButton(
                  //     icon: Icon(Icons.search), onPressed: () => search()),
                  // TextField(
                  //   controller: _controllerLatitude,
                  //   decoration: InputDecoration(hintText: "Latitude"),
                  // ),
                  // TextField(
                  //   controller: _controllerLongitude,
                  //   decoration: InputDecoration(hintText: "Longitude"),
                  // ),
                ],
              ),
            )));
  }
}
