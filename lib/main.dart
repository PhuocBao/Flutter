import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/physics.dart';
import 'package:flutter/services.dart';
import 'package:flutter_demo_wireframe_design/custom_hero_transition.dart';
import 'package:flutter_demo_wireframe_design/home_transition.dart';
import 'package:flutter_demo_wireframe_design/input_name.dart';
import 'package:flutter_demo_wireframe_design/language_bloc.dart';
import 'package:flutter_demo_wireframe_design/push_up_navigation.dart';
import 'package:flutter_demo_wireframe_design/toggle_text.dart';
import 'package:flutter_demo_wireframe_design/translations.dart';
import 'package:flutter_demo_wireframe_design/user.dart';
import 'package:flutter_demo_wireframe_design/user_bloc.dart';
import 'package:flutter_demo_wireframe_design/user_provider.dart';
import 'package:flutter_demo_wireframe_design/welcome_screen.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'constants.dart';
import 'package:flutter/scheduler.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.landscapeLeft, DeviceOrientation.landscapeRight]);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      localizationsDelegates: [
        const TranslationsDelegate(),
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: [const Locale('en', ''), const Locale('vi', '')],
      home: BlocProvider(
        bloc: LanguageBloc(),
        child: HomeScreen(),
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
  bool isAvatarChoose = false;
  int avatarChooseIndex;
  Offset avatarPosition;
  List _slideAnimationController = List(4);
  List _slideAnimation = List(4);
  List _springAnimationController = List(4);
  List _springAnimation = List(4);
  List _keyRed = List(10);
  AnimationController _checkingController;
  AnimationController _oldPageScaleController;
  Animation _checkingAnimation;
  Animation _oldPageScaleAnimation;
  OverlayEntry overlayEntry;

  @override
  void initState() {
    SystemChrome.setEnabledSystemUIOverlays([]);
    timeDilation = 1.0;

    //Setting up the controller and animation for profile load transition (to Welcome Screen)
    _oldPageScaleController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 50),
    );
    _oldPageScaleAnimation = Tween(begin: 1.0, end: 0.7).animate(
      CurvedAnimation(
        parent: _oldPageScaleController,
        curve: Curves.ease,
      ),
    );
    //initialize key for each avatar inorder to get avatar position later
    for (int i = 0; i < 10; i++) _keyRed[i] = GlobalKey();

    //Setting up the controller and animation for spring simualation for avatars
    final SpringDescription defaultSpring = SpringDescription.withDampingRatio(
      mass: 0.7,
      stiffness: 250.0,
      ratio: 0.6,
    );

    for (int i = 0; i < 4; i++) {
      _springAnimationController[i] = AnimationController(
        vsync: this,
        lowerBound: -0.3,
        upperBound: 0.3,
        duration: Duration(seconds: 2),
      );
      _slideAnimation[i] =
          Tween<Offset>(begin: Offset(0.0, 0.0), end: Offset(1.0, 0.0))
              .animate(_springAnimationController[i]);
      _springAnimationController[i]
          .animateWith(SpringSimulation(defaultSpring, 1.0, 0.0, 0.0));
    }
    for (int i = 0; i < 4; i++) _springAnimationController[i].stop();

    //Setting up the controller and animation for slide animation for avatars
    for (int i = 0; i < _springAnimation.length; i++) {
      _slideAnimationController[i] = AnimationController(
        vsync: this,
        duration: Duration(milliseconds: 600 + i * 150),
      );
      _springAnimation[i] =
          Tween<Offset>(begin: Offset(0.7 * i, 0.0), end: Offset(0.0, 0.0))
              .animate(CurvedAnimation(
                  parent: _slideAnimationController[i], curve: Curves.ease));
    }
    //start the slide animation
    for (final controller in _slideAnimationController) controller.forward();

    //start the spring animation column by column with time delay in between
    for (int i = 0; i < 4; i++) {
      Future.delayed(Duration(milliseconds: 400 + 150 * i), () {
        _springAnimationController[i]
            .animateWith(SpringSimulation(defaultSpring, 0.5, 0.0, 0.0));
      });
    }

    //Setting up the controller and animation for checking transition (to Checkin Screen)
    _checkingController = AnimationController(
        vsync: this, duration: Duration(milliseconds: 1000));
    _checkingAnimation = Tween(begin: 1.0, end: 20.0).animate(
        CurvedAnimation(parent: _checkingController, curve: Curves.ease));
    _checkingController.reset();
    overlayEntry = OverlayEntry(builder: _buildbox);
    super.initState();
  }

  //A Round shape that scale and full fill the screen
  Widget _buildbox(BuildContext context) {
    // SystemChrome.setEnabledSystemUIOverlays([]);
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
            color: Color(0xFFF68B1F),
            shape: BoxShape.circle,
          ),
        ),
      ),
    );
  }

  String _anonymousName(int index) {
    return 'Anonymous ${kAnimal.elementAt(index - 1)[0].toUpperCase()}${kAnimal.elementAt(index - 1).substring(1)}';
  }

  String _anonymousImage(int index) {
    return kAnimalAvatar.elementAt(index - 1);
  }

  @override
  Widget build(BuildContext context) {
    final _languageBloc = BlocProvider.of<LanguageBloc>(context);
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
                        child: ToggleText(
                      newText: 'ckin_app_bar',
                      placeHolderText:
                          Translations.of(context).text('ckin_app_bar'),
                      fontWeight: FontWeight.w500,
                      fontSize: 48.0,
                      color: Colors.white,
                    )),
                    elevation: 0.0,
                    backgroundColor: Color(0xFFF68B1F),
                  ),
                ),
              )
            : Stack(
                children: <Widget>[
                  ScaleTransition(
                    scale: _oldPageScaleAnimation,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      children: <Widget>[
                        Align(
                          alignment: Alignment.topCenter,
                          child: Container(
                            margin: const EdgeInsets.only(top: 20.0),
                            height: 120.0,
                            width: 700.0,
                            child: ToggleText(
                              newText: 'choose_profile',
                              placeHolderText:
                                  'Please choose your profile to continue your session',
                              fontSize: 48.0,
                              color: Color(0xFF333333),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            margin: const EdgeInsets.only(top: 30.0),
                            child: GridView.count(
                              crossAxisCount: 4,
                              scrollDirection: Axis.vertical,
                              physics: ScrollPhysics(
                                  parent: BouncingScrollPhysics()),
                              children: List.generate(9, (index) {
                                return isAvatarChoose &&
                                        avatarChooseIndex == index
                                    ? Container()
                                    : Column(
                                        key: _keyRed[index],
                                        mainAxisSize: MainAxisSize.min,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: <Widget>[
                                          index == 0
                                              ? GestureDetector(
                                                  child: SlideTransition(
                                                    position: _springAnimation[
                                                        index % 4],
                                                    child: SlideTransition(
                                                      position: _slideAnimation[
                                                          index % 4],
                                                      child: Image.asset(
                                                        'images/not_checking.png',
                                                        height: 160.08,
                                                      ),
                                                    ),
                                                  ),
                                                  onTap: () async {
                                                    Overlay.of(context)
                                                        .insert(overlayEntry);
                                                    _checkingController
                                                        .forward();
                                                    await Future.delayed(
                                                        Duration(
                                                            milliseconds: 400));
                                                    setState(() {
                                                      isTapChecking = true;
                                                    });
                                                    overlayEntry.remove();
                                                    await Future.delayed(
                                                        Duration(
                                                            milliseconds: 100));
                                                    print('object');
                                                    //await Future.delayed(Duration(milliseconds: 2000));
                                                    Navigator.push(
                                                        context,
                                                        PushUpNavigation(
                                                            widget:
                                                                BlocProvider(
                                                          bloc: _languageBloc,
                                                          child:
                                                              CheckinScreen(),
                                                        )));
                                                  })
                                              : GestureDetector(
                                                  child: SlideTransition(
                                                    position: _springAnimation[
                                                        index % 4],
                                                    child: SlideTransition(
                                                      position: _slideAnimation[
                                                          index % 4],
                                                      child: Image.asset(
                                                        _anonymousImage(index),
                                                        height: 160.08,
                                                      ),
                                                    ),
                                                  ),
                                                  onTap: () async {
                                                    final RenderBox
                                                        renderBoxRed =
                                                        _keyRed[index]
                                                            .currentContext
                                                            .findRenderObject();
                                                    avatarPosition =
                                                        renderBoxRed
                                                            .localToGlobal(
                                                                Offset(
                                                                    47.5, 0.0));
                                                    print(
                                                        "POSITION of Red: ${avatarPosition.dx} ");
                                                    _oldPageScaleController
                                                        .forward();
                                                    avatarChooseIndex = index;
                                                    setState(() {
                                                      isAvatarChoose = true;
                                                    });
                                                    Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder: (context) =>
                                                                HomeTransitionScreen(
                                                                  user: User(
                                                                      name: _anonymousName(
                                                                          index),
                                                                      avatar: kAnimalAvatar.elementAt(
                                                                          index -
                                                                              1)),
                                                                  isPush: true,
                                                                )));
                                                    await Future.delayed(
                                                        Duration(
                                                            milliseconds: 1000),
                                                        () {
                                                      _oldPageScaleController
                                                          .reset();
                                                    });
                                                  },
                                                ),
                                          Container(
                                            margin: const EdgeInsets.only(
                                                top: 10.0),
                                            child: StreamBuilder<Translations>(
                                                stream: _languageBloc.language,
                                                builder: (context, snapshot) {
                                                  if (snapshot.hasData) {
                                                    return Text(
                                                      index == 0
                                                          ? snapshot.data.text(
                                                              'not_checking?')
                                                          : _anonymousName(
                                                              index),
                                                      style: TextStyle(
                                                          fontSize: index == 0
                                                              ? 24.0
                                                              : 20.0,
                                                          fontWeight: index == 0
                                                              ? FontWeight.w500
                                                              : FontWeight
                                                                  .normal),
                                                    );
                                                  } else {
                                                    return Text(
                                                      index == 0
                                                          ? 'Not checked in yet?'
                                                          : _anonymousName(
                                                              index),
                                                      style: TextStyle(
                                                          fontSize: index == 0
                                                              ? 24.0
                                                              : 20.0,
                                                          fontWeight: index == 0
                                                              ? FontWeight.w500
                                                              : FontWeight
                                                                  .normal),
                                                    );
                                                  }
                                                }),
                                          ),
                                        ],
                                      );
                              }),
                            ),
                          ),
                        ),
                        Container(
                          color: Colors.transparent,
                          child: StreamBuilder<Translations>(
                              stream: _languageBloc.language,
                              builder: (context, snapshot) {
                                if (snapshot.hasData) {
                                  return _changeLanguageSection(
                                    context,
                                    snapshot.data.currentLanguage == 'en'
                                        ? Color(0xFFF15D03)
                                        : Color(0xFFBDBDBD),
                                    snapshot.data.currentLanguage == 'vi'
                                        ? Color(0xFFF15D03)
                                        : Color(0xFFBDBDBD),
                                  );
                                } else {
                                  return _changeLanguageSection(
                                      context,
                                      _isEnglish
                                          ? Color(0xFFF15D03)
                                          : Color(0xFFBDBDBD),
                                      _isVnese
                                          ? Color(0xFFF15D03)
                                          : Color(0xFFBDBDBD));
                                }
                              }),
                        )
                      ],
                    ),
                  ),
                  !isAvatarChoose
                      ? Container()
                      : Positioned(
                          left: avatarPosition.dx,
                          child: Container(
                            height: avatarPosition.dy * 2 + 201,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Hero(
                                  tag: kAnimalAvatar
                                      .elementAt(avatarChooseIndex - 1),
                                  child: Image.asset(
                                    avatarChooseIndex == 0
                                        ? 'images/not_checking.png'
                                        : kAnimalAvatar
                                            .elementAt(avatarChooseIndex - 1),
                                    height: 160.08,
                                  ),
                                ),
                                Container(
                                  child: Hero(
                                    tag: _anonymousName(avatarChooseIndex - 1),
                                    flightShuttleBuilder: (
                                      BuildContext flightContext,
                                      Animation<double> animation,
                                      HeroFlightDirection flightDirection,
                                      BuildContext fromHeroContext,
                                      BuildContext toHeroContext,
                                    ) {
                                      return ScaleTransition(
                                        scale: animation.drive(
                                          Tween<double>(
                                                  begin: 1.0, end: 36.0 / 24.0)
                                              .chain(
                                            CurveTween(
                                              curve: Curves.easeIn,
                                            ),
                                          ),
                                        ),
                                        child: Scaffold(
                                          backgroundColor: Color.fromRGBO(
                                              255, 255, 255, 0.0),
                                          body: Container(
                                            alignment: Alignment(0, 0),
                                            child: SingleChildScrollView(
                                              child: fromHeroContext.widget,
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.only(
                                          top: 10.0, bottom: 10.0),
                                      child: Text(
                                        _anonymousName(avatarChooseIndex),
                                        softWrap: true,
                                        style: TextStyle(
                                            fontSize: 24.0,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                ],
              ));
  }

  _changeLanguageSection(BuildContext context, Color viColor, Color enColor) {
    final _languageBloc = BlocProvider.of<LanguageBloc>(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        FlatButton(
          textColor: viColor,
          child: Text('English'),
          onPressed: () {
            setState(() {
              _isEnglish = true;
              _isVnese = false;
              _languageBloc.changeLanguage(_isEnglish);
            });
          },
        ),
        FlatButton(
          textColor: enColor,
          child: Text('Tiếng Việt'),
          onPressed: () {
            setState(() {
              _isVnese = true;
              _isEnglish = false;
              _languageBloc.changeLanguage(_isEnglish);
            });
          },
        )
      ],
    );
  }
}
