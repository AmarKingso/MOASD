import 'package:flutter/material.dart';

class DetailContent extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Andrew"),
        centerTitle: true,
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: (
            Image.asset("resources/timg.jpeg")
        ),
      ),
    );
  }
}