import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/physics.dart';
import 'package:flutter/services.dart';
import 'package:flutter_demo_wireframe_design/custom_hero_transition.dart';
import 'package:flutter_demo_wireframe_design/input_name.dart';
import 'package:flutter_demo_wireframe_design/push_up_navigation.dart';
import 'package:flutter_demo_wireframe_design/translations.dart';
import 'package:flutter_demo_wireframe_design/user.dart';
import 'package:flutter_demo_wireframe_design/user_provider.dart';
import 'package:flutter_demo_wireframe_design/welcome_screen.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
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
        localizationsDelegates: [
          const TranslationsDelegate(),
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
        ],
        supportedLocales: [const Locale('en', ''), const Locale('vi', '')],
        home: HomeScreen(),
      ),
    );
  }
}

class HomeScreen extends StatefulWidget {
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  bool _isEnglish = true;
  bool _isVnese = false;
  bool isTapChecking = false;
  List _controller2 = List(4);
  List _animation = List(4);
  List _controller = List(4);
  List ani = List(4);
  AnimationController _checkingController;
  Animation _checkingAnimation;
  OverlayEntry overlayEntry;

  @override
  void initState() {
    SystemChrome.setEnabledSystemUIOverlays([]);
    // timeDilation = 1.0;
    final SpringDescription defaultSpring = SpringDescription.withDampingRatio(
      mass: 0.7,
      stiffness: 250.0,
      ratio: 0.6,
    );

    for (int i = 0; i < 4; i++) {
      _controller[i] = AnimationController(
        vsync: this,
        lowerBound: -0.3,
        upperBound: 0.3,
        duration: Duration(seconds: 2),
      );
      _animation[i] =
          Tween<Offset>(begin: Offset(0.0, 0.0), end: Offset(1.0, 0.0))
              .animate(_controller[i]);
      _controller[i]
          .animateWith(SpringSimulation(defaultSpring, 1.0, 0.0, 0.0));
    }
    for (int i = 0; i < 4; i++) _controller[i].stop();

    for (int i = 0; i < ani.length; i++) {
      _controller2[i] = AnimationController(
        vsync: this,
        duration: Duration(milliseconds: 600 + i * 150),
      );
      ani[i] = Tween<Offset>(begin: Offset(0.7 * i, 0.0), end: Offset(0.0, 0.0))
          .animate(
              CurvedAnimation(parent: _controller2[i], curve: Curves.ease));
    }
    for (final controller in _controller2) controller.forward();

    for (int i = 0; i < 4; i++) {
      Future.delayed(Duration(milliseconds: 400 + 150 * i), () {
        _controller[i]
            .animateWith(SpringSimulation(defaultSpring, 0.5, 0.0, 0.0));
      });
    }

    _checkingController = AnimationController(
        vsync: this, duration: Duration(milliseconds: 1000));
    _checkingAnimation = Tween(begin: 1.0, end: 20.0).animate(
        CurvedAnimation(parent: _checkingController, curve: Curves.ease));
    _checkingController.reset();
    overlayEntry = OverlayEntry(builder: _buildbox);
    super.initState();
  }

  Widget _buildbox(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([]);
    return Positioned(
      left: 47.5,
      top: 140,
      height: 160.08,
      child: ScaleTransition(
        scale: _checkingAnimation,
        child: Container(
          width: 160.8,
          height: 160.8,
          decoration: BoxDecoration(
            color: Colors.orange,
            shape: BoxShape.circle,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // final _userBloc = UserProvider.of(context);
    // _userBloc.changeLanguage(true);
    return Scaffold(
      body: isTapChecking
          ? Container(
              alignment: Alignment.topCenter,
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              color: Color(0xFFF68B1F),
              child: Container(
                height: 128.0,
                child: AppBar(
                  automaticallyImplyLeading: false,
                  flexibleSpace: Center(
                    child: Text(
                      'Check in',
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 48.0,
                          color: Colors.white),
                    ),
                  ),
                  elevation: 0.0,
                  backgroundColor: Color(0xFFF68B1F),
                ),
              ),
            )
          : Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Align(
                  alignment: Alignment.topCenter,
                  child: Container(
                    margin: const EdgeInsets.only(top: 20.0),
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
                    margin: const EdgeInsets.only(top: 30.0),
                    child: GridView.count(
                      crossAxisCount: 4,
                      scrollDirection: Axis.vertical,
                      physics: ScrollPhysics(parent: BouncingScrollPhysics()),
                      children: List.generate(9, (index) {
                        if (index == 0) {
                          return Column(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              GestureDetector(
                                  child: SlideTransition(
                                    position: ani[index % 4],
                                    child: SlideTransition(
                                      position: _animation[index % 4],
                                      child: Image.asset(
                                        'images/not_checking.png',
                                        height: 160.08,
                                      ),
                                    ),
                                  ),
                                  onTap: () async {
                                    Overlay.of(context).insert(overlayEntry);
                                    _checkingController.forward();
                                    await Future.delayed(
                                        Duration(milliseconds: 400));
                                    setState(() {
                                      isTapChecking = true;
                                    });
                                    overlayEntry.remove();
                                    await Future.delayed(
                                        Duration(milliseconds: 100));
                                    // await Future.delayed(
                                    //     Duration(milliseconds: 2000));
                                    Navigator.push(
                                        context,
                                        PushUpNavigation(
                                            widget: CheckinScreen()));
                                  }),
                              Container(
                                  margin: EdgeInsets.only(top: 22.0),
                                  child: Text(
                                    'Not checked in yet?',
                                    style: TextStyle(
                                        fontSize: 24.0,
                                        fontWeight: FontWeight.w500,
                                        color: Color(0xFF4F4F4F)),
                                  ))
                            ],
                          );
                        } else {
                          final anonymousName =
                              'Anonymous ${kAnimal.elementAt(index - 1)[0].toUpperCase()}${kAnimal.elementAt(index - 1).substring(1)}';
                          return GestureDetector(
                            child: SlideTransition(
                              position: ani[index % 4],
                              child: SlideTransition(
                                position: _animation[index % 4],
                                child: CustomHeroTransition(
                                  imageUrl: kAnimalAvatar.elementAt(index - 1),
                                  name: anonymousName,
                                ),
                              ),
                            ),
                            onTap: () {
                              // Navigator.push(context, MaterialPageRoute(builder: (context) => HeroTempScreen(
                              //   name: anonymousName,
                              //   imgUrl: kAnimalAvatar.elementAt(index - 1),
                              // )));
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => WelcomeScreen(
                                            user: User(name: anonymousName),
                                          )));
                            },
                          );
                        }
                      }),
                    ),
                  ),
                ),
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      FlatButton(
                        textColor:
                            _isEnglish ? Color(0xFFF15D03) : Color(0xFFBDBDBD),
                        child: Text('English'),
                        onPressed: () {
                          setState(() {
                            _isEnglish = true;
                            _isVnese = false;
                            // _userBloc.changeLanguage(_isEnglish);
                          });
                        },
                      ),
                      FlatButton(
                        textColor:
                            _isVnese ? Color(0xFFF15D03) : Color(0xFFBDBDBD),
                        child: Text('Tiếng Việt'),
                        onPressed: () {
                          setState(() {
                            _isVnese = true;
                            _isEnglish = false;
                            // _userBloc.changeLanguage(_isEnglish);
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
