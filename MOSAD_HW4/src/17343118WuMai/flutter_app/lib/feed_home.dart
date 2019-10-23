import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:async';
import 'package:flutter_app/feed_list.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  static const platform = const MethodChannel('samples.flutter.io/battery');
  String _batteryLevel = '100%';

  Future<Null> _getBatteryLevel() async {
    String batteryLevel;
    try {
      final int result = await platform.invokeMethod('getBatteryLevel');
      batteryLevel = '$result%';
    } on PlatformException catch (e) {
      batteryLevel = "Failed to get battery level: '${e.message}'.";
    }

    setState(() {
      _batteryLevel = batteryLevel;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Helo'),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(
            Icons.camera_alt,
            color: Colors.black,
          ),
          padding: EdgeInsets.only(left: 12.0),
        ),
        actions: <Widget>[
          FlatButton.icon(
            icon: Icon(Icons.battery_unknown),
            padding: EdgeInsets.only(right: 12.0),
            onPressed: _getBatteryLevel,
            label: Text(_batteryLevel,
              style: TextStyle(
                fontSize: 20.0,
                color: Colors.black,
              ),
            ),
          ),
        ],
      ),
      body: _homeBody(),
      bottomNavigationBar: BottomAppBar(
        color: Colors.white,
        child: Row(
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.home),
              disabledColor: Colors.black,
            ),
            IconButton(icon: Icon(Icons.search)),
            IconButton(icon: Icon(Icons.add_box)),
            IconButton(icon: Icon(Icons.favorite)),
            IconButton(icon: Icon(Icons.account_box)),
          ],
          mainAxisAlignment: MainAxisAlignment.spaceAround,     //均匀分布
        ),
      ),
    );
  }

  Widget _homeBody(){
    return ListView.builder(
      itemCount: 6,
      itemBuilder: (BuildContext context, int index){
        return EveryCell();
      },
    );
  }
}