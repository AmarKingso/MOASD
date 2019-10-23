import 'package:flutter/material.dart';
import 'package:flutter_app/feed_home.dart';

void main(){
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'HW4',
      theme: ThemeData(primaryColor: Colors.white),
      home: HomePage(),
    );
  }
}


