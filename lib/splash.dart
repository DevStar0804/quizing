import 'dart:async';
import 'package:flutter/material.dart';
import 'package:test_flutter/settings.dart';


class SplashScreen extends StatefulWidget{
  @override
  _SplashScreenState createState() => _SplashScreenState();

}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState(){
    super.initState();
    Timer(Duration(seconds: 3), (){
      Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context) => HomePage()
      ));
    });
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: Colors.cyanAccent,
      body: Center(
        child: Text(
          "Let's Enjoy\n to Quiz!!!",
          style: TextStyle(
            fontSize: 50.0,
            color: Colors.redAccent,
            fontFamily: "Satisfy",
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}