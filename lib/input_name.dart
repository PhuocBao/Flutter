import 'package:flutter/material.dart';
import 'package:flutter_demo_wireframe_design/constants.dart';
import 'package:flutter_demo_wireframe_design/main.dart';
import 'package:flutter_demo_wireframe_design/user_provider.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'dart:math' as math;
import 'package:flutter/services.dart';

class InputName extends StatefulWidget {
  final SwiperPluginConfig config;
  final editingController = TextEditingController();
  final userName;

  InputName({Key key, this.config, this.userName}) : super(key: key);

  _InputNameState createState() => _InputNameState(editingController, userName);
}

class _InputNameState extends State<InputName> {
  TextEditingController editingController;
  final userName;
  bool _isKeyboardShowing = false;

  _InputNameState(this.editingController, this.userName);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([]);
    return Center(
      child: SingleChildScrollView(
        physics: ScrollPhysics(parent: NeverScrollableScrollPhysics()),
        child: ClipRRect(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(16.0), topRight: Radius.circular(16.0)),
          child: Container(
            color: Colors.white,
            height: MediaQuery.of(context).size.height - 128.0,
            width: MediaQuery.of(context).size.width,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Container(),
                _mainSection(),
                exitSection(context)
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    editingController.dispose();
    super.dispose();
  }

  Widget _mainSection() {
    return Container(
      margin: EdgeInsets.only(top: 60.0),
      child: Column(
        children: <Widget>[
          Container(
            margin: const EdgeInsets.only(bottom: 20.0),
            child: Text(
              'Your name',
              style: TextStyle(fontSize: 36.0, color: Color(0xFFF15D03)),
            ),
          ),
          _inputNameSection(context, widget.config, editingController),
          orSection(180.0, 20.0),
          _buttonSection(editingController),
        ],
      ),
    );
  }

  Widget _inputNameSection(BuildContext context, SwiperPluginConfig config,
      TextEditingController textController) {
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
                  filled: true,
                  hintText: 'Type your name here...',
                  hintStyle: TextStyle(color: Color(0xFF828282)),
                ),
                keyboardType: TextInputType.text,
                autofocus: false,
                maxLength: 30,
                textCapitalization: TextCapitalization.words,
                maxLengthEnforced: true,
                controller: textController,
                onChanged: (value) => _userBloc.addUserName(value),
                onTap: () => _isKeyboardShowing = true,
                onSubmitted: (string) {
                  if (string.trim().isEmpty) {
                    _validateInput(context, 'Please input your name',
                        'Did you forget something?');
                  } else {
                    _userBloc.addUserName(textController.text);
                    widget.config.controller.next(animation: true);
                  }
                },
              ),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: Container(
                //If maxLength or show error messages is needed, margin bottom 13.0
                margin: const EdgeInsets.only(bottom: 13.0),
                child: !_isKeyboardShowing
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
                                config.controller.next(animation: true);
                              }
                              FocusScope.of(context)
                                  .requestFocus(new FocusNode());
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

  _buttonSection(TextEditingController textController) {
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
        textController.text =
            'Anonymous ${kAnimal.elementAt(math.Random().nextInt(kAnimal.length))}';
      },
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
}

Widget exitSection(BuildContext context) {
  return Align(
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
        onPressed: () => Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => HomeScreen())),
      ));
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
                'Or',
                style: TextStyle(fontSize: 18.0),
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

Widget stepSection(Color stepColor, Color dividerColor) {
  return Align(
    alignment: Alignment.topCenter,
    child: Container(
      margin: const EdgeInsets.only(top: 40.0),
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
            decoration:
                BoxDecoration(color: Color(0xFFF15D03), shape: BoxShape.circle),
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
            decoration: BoxDecoration(color: stepColor, shape: BoxShape.circle),
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
