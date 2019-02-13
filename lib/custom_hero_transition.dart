import 'package:flutter/material.dart';

class CustomHeroTransition extends StatefulWidget {
  final String imageUrl;
  final String name;

  const CustomHeroTransition({Key key, this.imageUrl, this.name})
      : super(key: key);

  _CustomHeroTransitionState createState() => _CustomHeroTransitionState();
}

class _CustomHeroTransitionState extends State<CustomHeroTransition> {
  // AnimationController _controller;
  // Animation<double> _imgAnimation, _textAnimation;
  // static RectTween _createRectTween(Rect begin, Rect end) {
  //   return HeroOffsetTween(begin: begin, end: end);
  // }
  @override
  void initState() {
    // _controller = AnimationController(vsync: this,duration: Duration(seconds: 1));
    // _imgAnimation = Tween(begin: 160.08, end: 287.02).animate(CurvedAnimation(curve: Curves.ease,parent: _controller));
    // _textAnimation = Tween(begin: 20.0, end: 36.0).animate(CurvedAnimation(curve: Curves.ease,parent: _controller));
    // Future.delayed(Duration(seconds: 1), () {
    //   Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => WelcomeScreen(
    //     user: User(name: widget.name,avatar: widget.imageUrl),
    //   )));
    // });
    super.initState();
  }

  _flyingPlaceHolder() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Image.asset(
          widget.imageUrl,
          height: 160.08,
          width: 160.08,
        ),
        Container(
          margin: EdgeInsets.only(top: 23.92, bottom: 6.0),
          child: Text(
            widget.name,
            style: TextStyle(
              fontSize: 20.0,
            ),
            textAlign: TextAlign.center,
          ),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    // print('bao${widget.name}');
    return Hero(
        tag: widget.imageUrl,
        flightShuttleBuilder:
            (context, animation, flyDirection, fromHeroContext, toHeroContext) {
          // final toHero = toHeroContext.widget;
          // if (flyDirection == HeroFlightDirection.push) {
          //   _controller.forward();
          //   print('push');
          // } else {
          //   _controller.reverse();
          //   print('pop');
          // }
          if (flyDirection == HeroFlightDirection.push) {
            return Scaffold(
              backgroundColor: Colors.transparent,
              body: _flyingPlaceHolder(),
            );
          }
          return Scaffold(
            backgroundColor: Colors.transparent,
            body: _flyingPlaceHolder(),
          );
        },
        child: _flyingPlaceHolder());
  }

  @override
  void dispose() {
    // _controller.dispose();
    super.dispose();
  }
}

