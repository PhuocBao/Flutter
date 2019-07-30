import 'package:flutter/material.dart';
import 'package:flutter_demo_rating_button_animation/pulse.dart';
import 'package:flutter/scheduler.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
  AnimationController _controller, _controllerShadow;
  Animation _animation, _animationShadow;
  int opacityValue;

  @override
  void initState() {
    _controllerShadow =
        AnimationController(vsync: this, duration: Duration(milliseconds: 300))
          ..addListener(() {
            setState(() {
              if (_animationShadow.isCompleted) {
                _controllerShadow.reset();
                Future.delayed(Duration(milliseconds: 100), () {
                  _controller.reverse();
                });
              }
            });
          });
    _controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 200))
          ..addListener(() {
            setState(() {
              if (_controller.isCompleted) {
                _controllerShadow.forward();
              }
            });
          });

    _animation = Tween(begin: 1.0, end: 150.0 / 112.0).animate(_controller);
    _animationShadow =
        Tween(begin: 0.0, end: 1.0).animate(CurveTween(curve: Curves.linear).animate(_controllerShadow));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // timeDilation = 3.0;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: GestureDetector(
          child: Stack(
            children: <Widget>[
              ScaleTransition(
                scale: _animation,
                child: Align(
                  alignment: Alignment.center,
                  child: Image.asset(
                    'images/icon.png',
                    height: 112.0,
                    width: 112.0,
                  ),
                ),
              ),
              Opacity(
                opacity: 1.0 - _animationShadow.value,
                child: Transform.scale(
                  scale: _animationShadow.value,
                  child: Align(
                    alignment: Alignment.center,
                    child: Container(
                      height: 330.0,
                      width: 330.0,
                      margin: EdgeInsets.only(right: 15.0),
                      decoration: BoxDecoration(
                          color: Colors.orange[900].withOpacity(0.2), shape: BoxShape.circle),
                    ),
                  ),
                ),
              ),
            ],
          ),
          onTap: () {
            setState(() {
              _controller.forward();
              // _isForward = true;
              // _controllerShadow.forward();
            });
          },
        ),
      ),
    );
  }
}
