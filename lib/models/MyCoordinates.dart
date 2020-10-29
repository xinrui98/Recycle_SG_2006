import 'dart:core';

class MyCoordinates {
  double lat;
  double long;

  MyCoordinates(double lat, double long) {
    this.lat = lat;
    this.long = long;
  }

  void setLat(double lat) {
    this.lat = lat;
  }

  void setLong(double long) {
    this.long = long;
  }

  double getLat() {
    return lat;
  }

  double getLong() {
    return long;
  }
}
