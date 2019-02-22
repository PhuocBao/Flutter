import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_demo_wireframe_design/main.dart';
import 'package:flutter_demo_wireframe_design/user.dart';
import 'welcome_screen.dart';
import 'dart:async';

class HomeTransitionScreen extends StatefulWidget {
  final User user;
  final bool isPush;

  const HomeTransitionScreen({Key key, this.user, this.isPush})
      : super(key: key);

  _HomeTransitionScreenState createState() => _HomeTransitionScreenState();
}

class _HomeTransitionScreenState extends State<HomeTransitionScreen> {
  @override
  void initState() {
    timeDilation = 2.5;
    Future.delayed(Duration(milliseconds: 1500), () {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => WelcomeScreen(user: widget.user)));
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Hero(
              tag: widget.user.avatar,
              child: Image.asset(
                widget.user.avatar,
                height: 287.0,
              ),
            ),
            Container(
              //margin: const EdgeInsets.only(top: 10.0),
              child: Hero(
                tag: widget.user.name,
                child: Container(
                  padding: EdgeInsets.only(top: 10.0, bottom: 10),
                  child: Text(
                    widget.user.name,
                    softWrap: true,
                    style:
                        TextStyle(fontSize: 36.0, fontWeight: FontWeight.w500),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
