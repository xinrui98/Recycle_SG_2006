import 'package:flutter/material.dart';
import 'package:tensorflow_lite_flutter/screens/ItemScanner.dart';

final double fontSize = 30;

class RecyclableInfoScreen extends StatefulWidget {
  @override
  _RecyclableInfoScreenState createState() => _RecyclableInfoScreenState();
}

class _RecyclableInfoScreenState extends State<RecyclableInfoScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Container(
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.all(8.0),
              ),
              Text(
                'What are recyclables?',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 35),
              ),
              Padding(
                padding: EdgeInsets.all(8.0),
              ),
              Image(
                image: NetworkImage(
                    "https://i.ibb.co/sKy33WM/what-Are-Recyclables.png"),
              ),
              Padding(
                padding: EdgeInsets.all(8.0),
              ),
              Card(
                  child: FlatButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ItemScanner(
                              title: "Verify Recyclables",
                            )),
                  );
                },
                child: Padding(
                  child: Text(
                    'Not sure? Click here to scan your items!',
                    style: TextStyle(fontSize: fontSize),
                    textAlign: TextAlign.center,
                  ),
                  padding:
                      EdgeInsets.symmetric(horizontal: 15.0, vertical: 8.0),
                ),
                color: Color.fromRGBO(0, 200, 75, 0.3),
                padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 8.0),
              )),
            ],
          ),
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
