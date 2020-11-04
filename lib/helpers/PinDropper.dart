import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:flutter/cupertino.dart';
import 'dart:async';
import 'package:tensorflow_lite_flutter/screens/distance_calculator.dart';

class PinDropper {
  List nearestTenBinsList = [];
  List nearestTenBinsLats = [];
  List nearestTenBinsLong = [];

  GoogleMapController mapController;
  Map<String, Marker> markers = {};

  Map<String, Marker> createPins(GoogleMapController controller, double lat, double long ) {
    var distanceCalculator = DistanceCalculator();
    nearestTenBinsList = distanceCalculator.main(lat, long);
    for (int i = 0; i < nearestTenBinsList.length; i++) {
      if (i % 2 == 0) {
        nearestTenBinsLats.add(nearestTenBinsList[i]);
      } else {
        nearestTenBinsLong.add(nearestTenBinsList[i]);
      }
    }
    mapController = controller;
    for (int i = 0; i < 10; i++) {
      var markerIDVal = markers.length + 1;
      String mar = markerIDVal.toString();

      final MarkerId markerId = MarkerId(mar);
      final Marker marker = Marker(
        markerId: markerId,
        position: LatLng(
            nearestTenBinsLats[i], nearestTenBinsLong[i]), // change to bins
      );
      markers[markerId.toString()] = marker;

    }
    return markers;
  }
}
