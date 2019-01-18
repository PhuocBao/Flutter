import 'package:flutter/material.dart';
import 'package:flutter_demo_wireframe_design/user_provider.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'dart:math' as math;

class InputName extends StatefulWidget {
  final SwiperPluginConfig config;
  final editingController = TextEditingController();
  final userName;

  InputName({Key key, this.config, this.userName}) : super(key: key);

  _InputNameState createState() =>
      _InputNameState(editingController, userName);
}

class _InputNameState extends State<InputName> {
  TextEditingController editingController;
  final userName;

  _InputNameState(this.editingController, this.userName);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        _inputNameSection(context, widget.config, editingController),
        exitSection(context),
      ],
    );
  }

  @override
  void dispose() {
    editingController.dispose();
    super.dispose();
  }

  Widget _inputNameSection(BuildContext context, SwiperPluginConfig config,
      TextEditingController textController) {
    final _userBloc = UserProvider.of(context);
    return Center(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 120.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(
              'Your name',
              style: TextStyle(fontSize: 36.0),
            ),
            Container(
                height: 72.0,
                margin: const EdgeInsets.symmetric(vertical: 10.0),
                child: Stack(
                  children: <Widget>[
                    Center(
                      child: TextField(
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(50.0))),
                            counterStyle: TextStyle(color: Colors.red)),
                        keyboardType: TextInputType.text,
                        autofocus: false,
                        maxLength: 50,
                        textCapitalization: TextCapitalization.words,
                        maxLengthEnforced: true,
                        controller: textController,
                        onChanged: (value) => _userBloc.addUser(value),
                        onSubmitted: (string) {
                          if (string.trim().isEmpty) {
                            _validateInput(context, 'Please input your name',
                                'Did you forget something?');
                          } else {
                            _userBloc.addUser(textController.text);
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
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            GestureDetector(
                              child: Text(
                                'Clear all',
                                style: TextStyle(color: Color(0xFF828282)),
                              ),
                              onTap: () {
                                textController.clear();
                              },
                            ),
                            GestureDetector(
                              child: Container(
                                width: 80.0,
                                height: 57.0,
                                margin: const EdgeInsets.only(left: 10.0),
                                decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(39.0)),
                                    color: Color(0xFF828282)),
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
                                  _userBloc.addUser(textController.text);
                                  config.controller.next(animation: true);
                                }
                              },
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                )),
            orSection(200.0),
            RaisedButton(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
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
              color: Color(0xFF828282),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(32.0))),
              onPressed: () {
                textController.text = 'Anonymous ${math.Random().nextInt(10)}';
              },
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
}

Widget exitSection(BuildContext context) {
  return Align(
    alignment: Alignment.bottomLeft,
    child: FlatButton.icon(
      label: Text('Exit'),
      icon: ImageIcon(AssetImage('images/exit_icon.png')),
      onPressed: () => Navigator.pop(context),
    ),
  );
}

Widget orSection(double width) {
  return Container(
    margin: const EdgeInsets.symmetric(vertical: 20.0),
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
            margin: const EdgeInsets.symmetric(horizontal: 5.0),
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

Widget stepSection(Color stepColor) {
  return Align(
    alignment: Alignment.topCenter,
    child: Container(
      width: 200.0,
      height: 100.0,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            width: 40.0,
            height: 40.0,
            decoration:
                BoxDecoration(color: Color(0xFF828282), shape: BoxShape.circle),
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
                color: Color(0xFFBDBDBD),
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
