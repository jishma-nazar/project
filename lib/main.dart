import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'SlidePages.dart';
//import 'package:flare_flutter/flare_actor.dart';




void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Login/Sign Up',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Stack(
        children: [

          SlidePages(),
        ],
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}