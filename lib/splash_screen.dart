import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_demo_wireframe_design/main.dart';

class SplashScreen extends StatefulWidget {
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  Animation<double> animation;
  Animation<double> textAnimation;
  AnimationController controller;

  initState() {
    super.initState();
    controller = AnimationController(
        duration: const Duration(seconds: 2), vsync: this);
    final CurvedAnimation curve =
        CurvedAnimation(parent: controller, curve: Curves.bounceOut);
    textAnimation = Tween(begin: 0.0, end: 35.0).animate(curve);
    animation = Tween(begin: 0.0, end: 400.0).animate(curve)
      ..addListener(() {
        setState(() {});
      });
    controller.forward();
    Future.delayed(Duration(seconds: 3), () {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => HomeScreen()));
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
            height: animation.value + 30,
            width: animation.value + 30,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                  margin: const EdgeInsets.only(bottom: 20.0),
                  child: Image.asset(
                    'images/logo.png',
                  ),
                ),
                Text('WELCOME TO SIOUX',
                    style: TextStyle(
                        color: Color(0xFF4F4F4F),
                        fontSize: textAnimation.value,
                        fontWeight: FontWeight.w500)),
              ],
            )),
      ),
    );
  }

  dispose() {
    controller.dispose();
    super.dispose();
  }
}
