import 'package:flutter/material.dart';
import 'dart:math' as math;

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.purple,
        ),
        floatingActionButton: FabButton(),
      ),
    );
  }
}

class FabButton extends StatefulWidget {
  _FabButtonState createState() => _FabButtonState();
}

class _FabButtonState extends State<FabButton> with TickerProviderStateMixin {
  AnimationController _controller;

  @override
  void initState() {
    _controller = new AnimationController(
        vsync: this, duration: Duration(milliseconds: 200));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        ScaleTransition(
          alignment: FractionalOffset.topCenter,
          scale: CurvedAnimation(parent: _controller, curve: Curves.easeOut),
          child: FloatingActionButton(
            heroTag: 'favorite',
            child: Icon(Icons.favorite),
            onPressed: () {},
            mini: true,
          ),
        ),
        Container(
          margin: const EdgeInsets.symmetric(vertical: 5.0),
          child: ScaleTransition(
            scale: CurvedAnimation(parent: _controller, curve: Curves.easeOut),
            child: FloatingActionButton(
              heroTag: 'share',
              child: Icon(Icons.share),
              onPressed: () {},
              mini: true,
            ),
          ),
        ),
        FloatingActionButton(
          backgroundColor: Colors.purple,
          child: AnimatedBuilder(
            // child: Icon(Icons.add),
            animation: _controller,
            builder: (context, child) {
              return Transform(
                alignment: FractionalOffset.center,
                transform: Matrix4.rotationZ(_controller.value * math.pi * 0.75),
                child: Icon(Icons.add),
              );
            },
          ),
          onPressed: () {
            if (_controller.isDismissed) {
              _controller.forward();
            } else {
              _controller.reverse();
            }
          },
        ),
      ],
    );
  }
}
