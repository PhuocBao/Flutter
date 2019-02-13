import 'package:flutter/material.dart';
import 'package:flutter_demo_wireframe_design/user.dart';
import 'package:flutter_demo_wireframe_design/welcome_screen.dart';
import 'dart:async';

class HeroTempScreen extends StatefulWidget {
  final String name, imgUrl;

  const HeroTempScreen({Key key, this.name, this.imgUrl}) : super(key: key);

  _HeroTempScreenState createState() => _HeroTempScreenState();
}

class _HeroTempScreenState extends State<HeroTempScreen>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation<double> _imgAnimation, _textAnimation, _spaceAnimation;
  // static RectTween _createRectTween(Rect begin, Rect end) {
  //   return HeroOffsetTween(begin: begin, end: end);
  // }
  @override
  void initState() {
    _controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 500));
    _imgAnimation = Tween(begin: 160.08, end: 287.02).animate(_controller);
    _textAnimation = Tween(begin: 20.0, end: 36.0).animate(_controller);
    _spaceAnimation = Tween(begin: 23.92, end: 42.97).animate(_controller);
    _controller.forward();
    // print('play');
    Future.delayed(Duration(seconds: 1), () {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => WelcomeScreen(
                    user: User(name: widget.name),
                  )));
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // timeDilation = 5.0;
    return Scaffold(
      body: Center(
        child: Hero(
          tag: widget.imgUrl,
          flightShuttleBuilder: (context, animation, flyDirection,
              fromHeroContext, toHeroContext) {
            // _controller.forward();
            if (flyDirection == HeroFlightDirection.push) {
              return Scaffold(
                body: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      ScaleTransition(
                        scale: animation.drive(
                            Tween<double>(begin: 1.0, end: 287.02 / 160.08)),
                        child: Image.asset(
                          widget.imgUrl,
                          height: _imgAnimation.value,
                          width: _imgAnimation.value,
                        ),
                      ),
                      // ScaleTransition(
                      //   scale: animation.drive(Tween<double>(begin: 1.0, end: 42.97/23.92)),
                      //   child: Container(
                      //     height: 42.97,
                      //     width: MediaQuery.of(context).size.width,
                      //     color: Colors.red,
                      //   ),
                      // ),
                      ScaleTransition(
                        scale: animation
                            .drive(Tween<double>(begin: 1.0, end: 36.0 / 20.0)),
                        child: Container(
                          margin: EdgeInsets.only(top: 23.91 * 4 - 25),
                          child: Text(
                            widget.name,
                            style: TextStyle(
                              fontSize: _textAnimation.value,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              );
            }
            return Scaffold(
              body: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    ScaleTransition(
                      scale: animation.drive(
                          Tween<double>(begin: 287.02 / 160.08, end: 1.0)),
                      child: Image.asset(
                        widget.imgUrl,
                        height: _imgAnimation.value,
                        width: _imgAnimation.value,
                      ),
                    ),
                    ScaleTransition(
                      scale: animation
                          .drive(Tween<double>(begin: 36.0 / 20.0, end: 1.0)),
                      child: Container(
                        margin: EdgeInsets.only(top: 42.97),
                        child: Text(
                          widget.name,
                          style: TextStyle(
                            fontSize: _textAnimation.value,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            );
          },
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Image.asset(
                  widget.imgUrl,
                  height: 287.02,
                  width: 287.02,
                ),
                Container(
                  margin: EdgeInsets.only(top: 42.97),
                  child: Text(
                    widget.name,
                    style: TextStyle(
                      fontSize: 36.0,
                    ),
                    textAlign: TextAlign.center,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
