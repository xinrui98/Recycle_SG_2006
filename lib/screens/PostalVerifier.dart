import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geocoder/geocoder.dart';
import 'package:geocoder/services/base.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'ManualLocationFinder.dart';

class PostalVerifier extends StatefulWidget {
  @override
  _PostalVerifierState createState() => new _PostalVerifierState();
}

class AppState extends InheritedWidget {
  const AppState({
    Key key,
    this.mode,
    Widget child,
  })  : assert(mode != null),
        assert(child != null),
        super(key: key, child: child);

  final Geocoding mode;

  static AppState of(BuildContext context) {
    return context.inheritFromWidgetOfExactType(AppState);
  }

  @override
  bool updateShouldNotify(AppState old) => mode != old.mode;
}

class GeocodeView extends StatefulWidget {
  GeocodeView();

  @override
  _GeocodeViewState createState() => new _GeocodeViewState();
}

class _GeocodeViewState extends State<GeocodeView> {
  _GeocodeViewState();

  final TextEditingController _controller = new TextEditingController();

  List<Address> results = [];

  bool isLoading = false;

  bool validatePostalResults = true;

  Future search() async {
    //internal validation of postal code
    this.validatePostalResults = validatePostal(int.parse(_controller.text));
    if (!this.validatePostalResults) {
      _showToast(context);
      return;
    }

    this.setState(() {
      this.isLoading = true;
    });
    try {
      var geocoding = AppState.of(context).mode;
      var results = await geocoding.findAddressesFromQuery(_controller.text);
      this.setState(() {
        this.results = results;
      });
      print(this.results[0].coordinates.latitude);
      print(this.results[0].coordinates.longitude);
      Navigator.push(context, MaterialPageRoute(builder: (context) {
        return ManualLocationFinder(lat: this.results[0].coordinates.latitude, long: this.results[0].coordinates.longitude,);
      }));
    } catch (e) {
      print("Error occured: $e");
    } finally {
      this.setState(() {
        this.isLoading = false;
      });
    }
  }

  bool validatePostal(int code) {
    List postalSet = [
      01,
      02,
      03,
      04,
      05,
      06,
      07,
      08,
      14,
      15,
      16,
      09,
      10,
      11,
      12,
      13,
      17,
      18,
      19,
      20,
      21,
      22,
      23,
      24,
      25,
      26,
      27,
      28,
      29,
      30,
      31,
      32,
      33,
      34,
      35,
      36,
      37,
      38,
      39,
      40,
      41,
      42,
      43,
      44,
      45,
      46,
      47,
      48,
      49,
      50,
      81,
      51,
      52,
      53,
      54,
      55,
      82,
      56,
      57,
      58,
      59,
      60,
      61,
      62,
      63,
      64,
      65,
      66,
      67,
      68,
      69,
      70,
      71,
      72,
      73,
      77,
      78,
      75,
      76,
      79,
      80
    ];

    if (code < 0)
      return false;
    else if (code.toString().length != 6)
      return false;
    else {
      String firsttwo = code.toString().substring(0, 2);
      int startDigits = int.parse(firsttwo);
      // just checking if first two digits is in array
      if (postalSet.contains(startDigits)) {
        return true;
      }
      return false;
    }
  }

  void _showToast(BuildContext context) {
    final scaffold = Scaffold.of(context);
    scaffold.showSnackBar(
      SnackBar(
        content: const Text('Invalid Postal Code'),
        action: SnackBarAction(
            label: 'OK', onPressed: scaffold.hideCurrentSnackBar),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Column(children: <Widget>[
      new Card(
        child: new Padding(
          padding: const EdgeInsets.all(10.0),
          child: new Row(
            children: <Widget>[
              new Expanded(
                child: new TextField(
                  keyboardType: TextInputType.number,
                  controller: _controller,
                  decoration: new InputDecoration(
                    hintText: "Enter a postal code",
                    // errorText:
                    //     validatePostalResults ? null : "Invalid Postal Code"
                  ),
                ),
              ),
              new IconButton(
                  icon: new Icon(Icons.search), onPressed: () => search())
            ],
          ),
        ),
      ),
      new Expanded(child: new AddressListView(this.isLoading, this.results)),
    ]);
  }
}


class _PostalVerifierState extends State<PostalVerifier> {
  Geocoding geocoding = Geocoder.local;

  final Map<String, Geocoding> modes = {
    "Local": Geocoder.local,
    "Google (distant)": Geocoder.google("<API-KEY>"),
  };

  void _changeMode(Geocoding mode) {
    this.setState(() {
      geocoding = mode;
    });
  }

  @override
  Widget build(BuildContext context) {
    return new AppState(
      mode: this.geocoding,
      child: new MaterialApp(
        home: new DefaultTabController(
          length: 2,
          child: new Scaffold(
            appBar: new AppBar(
              title: new Text('Postal Code Entry'),
            ),
            body: new GeocodeView(),
            // new ReverseGeocodeView(),
          ),
        ),
      ),
    );
  }
}

class AddressTile extends StatelessWidget {
  final Address address;

  AddressTile(this.address);

  final titleStyle =
      const TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold);

  @override
  Widget build(BuildContext context) {
    return new Padding(
      padding: const EdgeInsets.all(10.0),
      child: new Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
                "${this.address.coordinates.latitude}, ${this.address.coordinates.longitude}")
          ]),
    );
  }
}

class AddressListView extends StatelessWidget {
  final List<Address> addresses;

  final bool isLoading;

  AddressListView(this.isLoading, this.addresses);

  @override
  Widget build(BuildContext context) {
    if (this.isLoading) {
      return new Center(child: new CircularProgressIndicator());
    }

    return new ListView.builder(
      itemCount: this.addresses.length,
      itemBuilder: (c, i) => new AddressTile(this.addresses[i]),
    );
  }
}

class ErrorLabel extends StatelessWidget {
  final String name, text;

  final TextStyle descriptionStyle;

  ErrorLabel(this.name, String text,
      {double fontSize = 9.0, bool isBold = false})
      : this.text = text ?? "Unknown $name",
        this.descriptionStyle = new TextStyle(
            fontSize: fontSize,
            fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
            color: text == null ? Colors.red : Colors.black);

  @override
  Widget build(BuildContext context) {
    return new Text(this.text, style: descriptionStyle);
  }
}
