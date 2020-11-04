import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tensorflow_lite_flutter/screens/ItemScanner.dart';
import 'package:tensorflow_lite_flutter/screens/home_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Detect Trash',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
      // DetectScreen(title: 'Detect Trash'),
    );
  }
}
