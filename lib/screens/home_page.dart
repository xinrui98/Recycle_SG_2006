import 'package:flutter/material.dart';
import 'package:tensorflow_lite_flutter/screens/detect_screen.dart';
import 'package:tensorflow_lite_flutter/screens/location_maps_page.dart';
import 'package:tensorflow_lite_flutter/screens/location_page.dart';
import 'package:tensorflow_lite_flutter/screens/menu_page.dart';
import 'package:tensorflow_lite_flutter/screens/postal_code_page.dart';
import 'package:tensorflow_lite_flutter/screens/recyclable_info_screen.dart';
import 'detail_page.dart';
import 'constants.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'data.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';

import 'distance_calculator.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  static double lat = 1.2907;
  static double long = 103.8517;
  PageController _pageController = PageController();
  List<Widget> _screens = [
    MenuPage(),
    DetectScreen(title: "Detect Recyclable"),
    LocationMapsPage(lat: lat, long: long),
    MyPostalApp(),
    // LocationMapsPage(),
  ];

  void _onPageChanged(int index) {}

  void _onItemTapped(int selectedIndex) {
    _pageController.jumpToPage(selectedIndex);
  }

  void _getCurrentLocation() async {
    final position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    print(position);

    setState(() {
      lat = position.latitude;
      long = position.longitude;
    });
  }

  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: gradientEndColor,
        body: PageView(
          controller: _pageController,
          children: _screens,
          onPageChanged: _onPageChanged,
          physics: NeverScrollableScrollPhysics(),
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentIndex,
          items: [
            BottomNavigationBarItem(
                icon: Icon(Icons.menu),
                title: Text("Home"),
                backgroundColor: Colors.blue),
            BottomNavigationBarItem(
                icon: Icon(Icons.check_box),
                title: Text("Verify Recyclables"),
                backgroundColor: Colors.blue),
            BottomNavigationBarItem(
                icon: Icon(Icons.location_on),
                title: Text("Location"),
                backgroundColor: Colors.blue),
            BottomNavigationBarItem(
                icon: Icon(Icons.add_location_rounded),
                title: Text("Postal Code"),
                backgroundColor: Colors.blue),
          ],
          onTap: (index) {
            // var distanceCalculator = DistanceCalculator();
            // distanceCalculator.main();
            setState(() {
              _currentIndex = index;
              _onItemTapped(_currentIndex);
              if (index == 2) {
                _getCurrentLocation();
              }
            });
          },
        ));
  }
}
