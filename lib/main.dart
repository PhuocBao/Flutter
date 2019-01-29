import 'package:flutter/material.dart';
import 'package:flutter/physics.dart';
import 'package:flutter/services.dart';
import 'package:flutter_demo_wireframe_design/check_in.dart';
import 'package:flutter_demo_wireframe_design/splash_screen.dart';
import 'package:flutter_demo_wireframe_design/user_provider.dart';
import 'constants.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.landscapeLeft, DeviceOrientation.landscapeRight]);
    return UserProvider(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: SplashScreen(),
      ),
    );
  }
}

class HomeScreen extends StatefulWidget {
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  bool _isEnglish = true;
  bool _isVnese = false;
  AnimationController _controller;
  Animation _animation;

  @override
  void initState() {
    final SpringDescription defaultSpring = SpringDescription.withDampingRatio(
      mass: 0.7,
      stiffness: 150.0,
      ratio: 0.6,
    );
    _controller = AnimationController(
      vsync: this,
      lowerBound: -0.5,
      upperBound: 0.5,
    );
    _controller.animateWith(SpringSimulation(defaultSpring, 2.0, 0.0, 1.0));
    _animation = Tween<Offset>(begin: Offset(0.0, 0.0), end: Offset(1.0, 0.0))
        .animate(_controller);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Align(
            alignment: Alignment.topCenter,
            child: Container(
              margin: const EdgeInsets.only(top: 40.0),
              height: 120.0,
              width: 700.0,
              child: Text(
                'Please choose your profile to continue your session',
                style: TextStyle(
                  fontSize: 48.0,
                  color: Color(0xFF333333),
                  fontWeight: FontWeight.w500,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          Expanded(
            child: Container(
              child: GridView.count(
                crossAxisCount: 4,
                scrollDirection: Axis.vertical,
                physics: ScrollPhysics(parent: BouncingScrollPhysics()),
                children: List.generate(8, (index) {
                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      SlideTransition(
                        position: _animation,
                        child: GestureDetector(
                          child: Image.asset(
                            index == 0
                                ? 'images/not_checking.png'
                                : kAnimalAvatar.elementAt(index - 1),
                            height: 160.08,
                          ),
                          onTap: () {
                            if (index == 0) {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => CheckinScreen()));
                            }
                          },
                        ),
                      ),
                      Container(
                          margin: const EdgeInsets.only(top: 10.0),
                          child: Text(
                            index == 0
                                ? 'Not checking yet?'
                                : 'Anonymous ${kAnimal.elementAt(index - 1)[0].toUpperCase()}${kAnimal.elementAt(index - 1).substring(1)}',
                            style: TextStyle(
                                fontSize: 24.0, fontWeight: FontWeight.w500),
                          ))
                    ],
                  );
                }),
              ),
            ),
          ),
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                FlatButton(
                  textColor: _isEnglish ? Colors.black : Color(0xFFBDBDBD),
                  child: Text('English'),
                  onPressed: () {
                    setState(() {
                      _isEnglish = true;
                      _isVnese = false;
                    });
                  },
                ),
                FlatButton(
                  textColor: _isVnese ? Colors.black : Color(0xFFBDBDBD),
                  child: Text('Tiếng Việt'),
                  onPressed: () {
                    setState(() {
                      _isVnese = true;
                      _isEnglish = false;
                    });
                  },
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
