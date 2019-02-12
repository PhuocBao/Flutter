import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_demo_wireframe_design/constants.dart';
import 'package:flutter_demo_wireframe_design/main.dart';
import 'package:flutter_demo_wireframe_design/navigation_animation.dart';
import 'package:flutter_demo_wireframe_design/user_provider.dart';
import 'package:flutter_demo_wireframe_design/visit_purpose.dart';
import 'dart:math' as math;

class CheckinScreen extends StatefulWidget {
  final editingController = TextEditingController();
  final userName;

  CheckinScreen({Key key, this.userName}) : super(key: key);
  _CheckinScreenState createState() =>
      _CheckinScreenState(editingController, userName);
}

class _CheckinScreenState extends State<CheckinScreen>
    with TickerProviderStateMixin {
  AnimationController _controller, _controller2;
  Animation _animation, _animation2, _animation3;
  TextEditingController editingController;
  FocusNode textfocus = FocusNode();
  final userName;
  // bool _isKeyboardShowing = false;
  bool isAppbarVisible = false;
  DateTime now;

  _CheckinScreenState(this.editingController, this.userName);

  @override
  void initState() {
    textfocus.addListener(_onFocusChange);
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 350),
    );
    _animation = Tween(begin: 128.0, end: 0.0)
        .animate(CurvedAnimation(curve: Curves.ease, parent: _controller))
          ..addListener(() {
            setState(() {});
          });
    _animation3 = Tween(begin: 370.0, end: 430.0)
        .animate(CurvedAnimation(curve: Curves.ease, parent: _controller));
    _controller2 = AnimationController(
        vsync: this, duration: Duration(milliseconds: 1000));
    _animation2 = Tween(begin: 0.0, end: 1.0)
        .animate(CurvedAnimation(parent: _controller2, curve: Curves.easeIn));
    _controller2.forward();
    super.initState();
  }

  void _onFocusChange() {
    if (textfocus.hasFocus) {
      now = DateTime.now();
      _controller.forward();
    } else {
      while (now.difference(DateTime.now()).inMilliseconds > -1000) {}
      _controller.stop();
      _controller.reverse();
    }
  }

  @override
  Widget build(BuildContext context) {
    // final _userBloc = UserProvider.of(context);
    SystemChrome.setEnabledSystemUIOverlays([]);
    return Scaffold(
      backgroundColor: Color.fromRGBO(255, 255, 255,
          _animation2.value > 0.9 ? 1.0 : 0.0), //Color(0xFFF68B1F),
      // body: SingleChildScrollView(
      body: Column(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          checkinSection(),
          inputname(context),
          exitSection(context)
        ],
      ),
      // ),
    );
  }

  checkinSection() {
    return AnimatedBuilder(
        animation: _animation2,
        builder: (context, widget) {
          return AnimatedBuilder(
              animation: _animation,
              builder: (context, widget) {
                return Container(
                  alignment: Alignment.topCenter,
                  height: _animation.value,
                  color: Color.fromRGBO(
                      246, 139, 31, _animation2.value > 0.55 ? 1.0 : 0.0),
                  child: _animation2.value > 0.55
                      ? AppBar(
                          automaticallyImplyLeading: false,
                          flexibleSpace: Center(
                            child: Container(
                              color: Color.fromRGBO(
                                  246,
                                  139,
                                  31,
                                  _animation2.value > 0.4
                                      ? _animation2.value
                                      : 0.0),
                              child: Text(
                                'Check in',
                                style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 48.0,
                                    color: Colors.white),
                              ),
                            ),
                          ),
                          elevation: 0.0,
                          backgroundColor: Color.fromRGBO(
                              246,
                              139,
                              31,
                              _animation2.value > 0.4
                                  ? _animation2.value
                                  : 0.0),
                        )
                      : Container(),
                );
              });
        });
  }

  Widget inputname(BuildContext context) {
    return Container(
      color: textfocus.hasFocus ? Color(0xFFFFFFFF) : Color(0xFFF68B1F),
      child: ClipRRect(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(16.0), topRight: Radius.circular(16.0)),
        child: GestureDetector(
            child: AnimatedContainer(
                duration: Duration(milliseconds: 0),
                color: Colors.white,
                height: textfocus.hasFocus
                    ? MediaQuery.of(context).size.height - 430.0
                    : MediaQuery.of(context).size.height -
                        (_animation3.value > 390.0 ? 430.0 : 370.0),
                width: MediaQuery.of(context).size.width,
                child: Stack(
                  children: <Widget>[
                    stepSection(Color(0xFFBDBDBD), Color(0xFFBDBDBD)),
                    Container(
                      margin: EdgeInsets.only(top: 128.0),
                      child: _mainSection(),
                    ),
                  ],
                )),
            onTap: () => FocusScope.of(context).requestFocus(new FocusNode())),
      ),
    );
  }

  Widget _mainSection() {
    return Center(
      child: Column(
        children: <Widget>[
          Container(
            margin: const EdgeInsets.only(bottom: 20.0),
            child: Text(
              'Your name',
              style: TextStyle(fontSize: 36.0, color: Color(0xFFF15D03)),
            ),
          ),
          inputNameSection(context, editingController),
          AnimatedContainer(
            duration: Duration(milliseconds: 400),
            child: textfocus.hasFocus
                ? Container()
                : _animation3.value == 370.0
                    ? orSection(180.0, 20.0)
                    : Container(),
          ),
          buttonSection(context, editingController),
        ],
      ),
    );
  }

  Widget inputNameSection(
      BuildContext context, TextEditingController textController) {
    final _userBloc = UserProvider.of(context);
    return Theme(
      data: ThemeData(
          primaryColor: Color(0xFFF15D03),
          hintColor: Colors.white,
          inputDecorationTheme: InputDecorationTheme(
            border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(50.0))),
          )),
      child: Container(
        height: 72.0,
        width: 640.0,
        margin: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 120.0),
        child: Stack(
          children: <Widget>[
            Center(
              child: TextField(
                decoration: InputDecoration(
                  fillColor: Color(0xFFF2F2F2),
                  focusedBorder: OutlineInputBorder(
                      //gapPadding: 10.0,
                      borderSide:
                          BorderSide(color: Color(0xFFF15D03), width: 0.5),
                      borderRadius: BorderRadius.circular(39.0)),
                  filled: true,
                  hintText: 'Type your name here...',
                  hintStyle: TextStyle(color: Color(0xFF828282)),
                ),
                keyboardType: TextInputType.text,
                autofocus: false,
                autocorrect: false,
                maxLength: 30,
                textCapitalization: TextCapitalization.words,
                maxLengthEnforced: true,
                controller: textController,
                //onChanged: (value) => _userBloc.addUserName(value),
                focusNode: textfocus,
                // onTap: () => _controller.forward(),
                onSubmitted: (string) {
                  if (string.trim().isEmpty) {
                    _validateInput(context, 'Please input your name',
                        'Did you forget something?');
                    // _controller.reset();
                  } else {
                    _userBloc.addUserName(textController.text);
                    Navigator.push(
                        context,
                        SlideLeftNavigation(
                            widget: VisitPurpose(
                          userName: textController.text,
                        )));
                    FocusScope.of(context).requestFocus(new FocusNode());
                  }
                },
              ),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: Container(
                //If maxLength or show error messages is needed, margin bottom 13.0
                margin: const EdgeInsets.only(bottom: 13.0),
                child: !textfocus.hasFocus
                    ? Container()
                    : Row(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          GestureDetector(
                            child: Text(
                              'Clear all',
                              style: TextStyle(
                                  color: Color(0xFFF15D03),
                                  fontWeight: FontWeight.w500,
                                  fontSize: 15.0),
                            ),
                            onTap: () {
                              textController.clear();
                            },
                          ),
                          GestureDetector(
                            child: Container(
                              width: 65.0,
                              height: 57.0,
                              margin: const EdgeInsets.only(left: 10.0),
                              decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(39.0)),
                                  color: Color(0xFFF68B1F)),
                              child: Center(
                                child: Text(
                                  'Go',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                            ),
                            onTap: () {
                              if (textController.text.trim().isEmpty) {
                                _validateInput(
                                    context,
                                    'Please input your name',
                                    'Did you forget something?');
                              } else {
                                _userBloc.addUserName(textController.text);
                                Navigator.push(
                                    context,
                                    SlideLeftNavigation(
                                        widget: VisitPurpose(
                                      userName: textController.text,
                                    )));
                                FocusScope.of(context)
                                    .requestFocus(new FocusNode());
                                // config.controller.next(animation: true);
                              }
                              // Navigator.push(
                              //     context,
                              //     SlideLeftNavigation(
                              //         widget: VisitPurpose(
                              //       userName: textController.text,
                              //     )));
                            },
                          )
                        ],
                      ),
              ),
            )
          ],
        ),
      ),
    );
  }

  _validateInput(BuildContext context, String title, String content) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(title),
          content: Text(content),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
          actions: <Widget>[
            FlatButton(
              child: Text('OK'),
              onPressed: () => Navigator.pop(context),
            )
          ],
        );
      },
    );
  }

  buttonSection(BuildContext context, TextEditingController textController) {
    final _userBloc = UserProvider.of(context);
    return RaisedButton(
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(
              'Just pick a random name',
              style: TextStyle(color: Colors.white, fontSize: 15.0),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Icon(
                Icons.arrow_forward,
                color: Colors.white,
              ),
            )
          ],
        ),
      ),
      color: Color(0xFFF15D03),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(32.0))),
      onPressed: () {
        String anonymousName =
            'Anonymous ${kAnimal.elementAt(math.Random().nextInt(kAnimal.length))}';
        _userBloc.addUserName(anonymousName);
        // Navigator.push(context, MaterialPageRoute(builder: (context) => VisitPurpose(userName: anonymousName,)));
        Navigator.push(
            context,
            SlideLeftNavigation(
                widget: VisitPurpose(
              userName: anonymousName,
            )));
        FocusScope.of(context).requestFocus(new FocusNode());
      },
    );
  }

  Widget stepSection(Color stepColor, Color dividerColor) {
    return Align(
      alignment: Alignment.topCenter,
      child: Container(
        margin: const EdgeInsets.only(top: 20.0),
        width: 200.0,
        height: 80.0,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              width: 40.0,
              height: 40.0,
              decoration: BoxDecoration(
                  color: Color(0xFFF15D03), shape: BoxShape.circle),
              child: Center(
                  child: Text(
                '1',
                style: TextStyle(color: Colors.white, fontSize: 24.0),
              )),
            ),
            Expanded(
              child: Align(
                alignment: Alignment.center,
                child: Container(
                  height: 3.0,
                  color: dividerColor,
                ),
              ),
            ),
            Container(
              width: 40.0,
              height: 40.0,
              decoration:
                  BoxDecoration(color: stepColor, shape: BoxShape.circle),
              child: Center(
                  child: Text(
                '2',
                style: TextStyle(color: Colors.white, fontSize: 24.0),
              )),
            ),
          ],
        ),
      ),
    );
  }

  Widget exitSection(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 350),
      child: _animation3.value < 380.0
          ? Container(
              color: Colors.white,
              height: 240.0,
              child: Align(
                  alignment: Alignment.bottomLeft,
                  child: FlatButton(
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Text(
                          'Exit',
                          style: TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.w500,
                            color: Color(0xFFF15D03),
                          ),
                        ),
                        Container(
                          height: 28.0,
                          width: 28.16,
                          margin: const EdgeInsets.only(left: 8.0),
                          child: ImageIcon(
                            AssetImage('images/exit_icon.png'),
                            color: Color(0xFFF68B1F),
                          ),
                        ),
                      ],
                    ),
                    onPressed: () =>
                        // Navigator.pop(context), =>
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => HomeScreen())),
                  )),
            )
          : Container(),
    );
  }

  Widget orSection(double width, double marginSpace) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: marginSpace),
      width: width,
      child: Row(
        children: <Widget>[
          Expanded(
            child: Container(
              color: Colors.black,
              height: 1.0,
            ),
          ),
          Container(
              margin: const EdgeInsets.symmetric(horizontal: 30.0),
              child: Center(
                child: Text(
                  'or',
                  style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w500),
                ),
              )),
          Expanded(
            child: Container(
              color: Colors.black,
              height: 1.0,
            ),
          ),
        ],
      ),
    );
  }
}
