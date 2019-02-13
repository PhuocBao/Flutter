import 'package:flutter/material.dart';
import 'package:flutter_demo_wireframe_design/appbar_main.dart';
import 'package:flutter_demo_wireframe_design/constants.dart';
import 'package:flutter_demo_wireframe_design/input_name.dart';
import 'package:flutter_demo_wireframe_design/main.dart';
import 'package:flutter_demo_wireframe_design/user.dart';
import 'package:flutter_demo_wireframe_design/welcome_screen.dart';

class VisitPurpose extends StatefulWidget {
  final String userName;

  const VisitPurpose({Key key, this.userName}) : super(key: key);

  _VisitPurposeState createState() => _VisitPurposeState();
}

class _VisitPurposeState extends State<VisitPurpose> {
  String _displayName;
  String _avatarUrl;

  Widget customButton(String label, Color color, VoidCallback onPress) {
    return Container(
      width: 353.0,
      height: 64.0,
      child: RaisedButton(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 15.0),
          child: Text(
            label,
            style: TextStyle(
                color: Colors.white,
                fontSize: 18.0,
                fontWeight: FontWeight.w500),
          ),
        ),
        color: color,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(40.0))),
        onPressed: onPress,
      ),
    );
  }

  @override
  void initState() {
    //handle display name
    if (widget.userName.contains(' ', 0)) {
      int _firstSpace = widget.userName.indexOf(' ');
      if (widget.userName.substring(0, _firstSpace) == 'Anonymous') {
        _displayName = widget.userName;
      } else {
        _displayName = widget.userName.substring(0, _firstSpace);
      }
    } else if (!widget.userName.contains(' ') && widget.userName.length >= 6) {
      _displayName = widget.userName.substring(0, 6) + '...';
    } else {
      _displayName = widget.userName;
    }
    //handle avatar
    int spacePos = widget.userName.indexOf(' ');
    String animalName = widget.userName.substring(spacePos + 1);
    if (widget.userName.contains('Anonymous')) {
      for (var i = 0; i < kAnimalAvatar.length; i++) {
        if (kAnimalAvatar.elementAt(i).contains(animalName.toLowerCase(), 16) ==
            true) {
          _avatarUrl = kAnimalAvatar.elementAt(i);
          break;
        }
      }
    } else {
      _avatarUrl = 'images/anonymous_bear.png';
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // final _userBloc = UserProvider.of(context);
    // _userBloc.addAvatar(_avatarUrl);
    return Scaffold(
      backgroundColor: Color(0xFFF68B1F),
      body: Column(
        children: <Widget>[
          AppBarMain(
            content: 'Check in',
            isImplyLeading: true,
            leadingText: 'Back',
          ),
          ClipRRect(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(16.0),
                topRight: Radius.circular(16.0)),
            child: Container(
              color: Colors.white,
              height: MediaQuery.of(context).size.height - 128.0,
              width: MediaQuery.of(context).size.width,
              child: Stack(
                children: <Widget>[
                  CheckinScreen()
                      .createState()
                      .stepSection(Color(0xFFF15D03), Color(0xFFF15D03), true),
                  Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Text(
                          'Hi $_displayName, you come as...',
                          style: TextStyle(
                              fontSize: 36.0, color: Color(0xFFF15D03)),
                          textAlign: TextAlign.center,
                        ),
                        Container(
                          margin:
                              const EdgeInsets.only(top: 38.0, bottom: 32.0),
                          child:
                              customButton('Candidate', Color(0xFF00AEEF), () {
                            // _userBloc.addRole('Candidate');
                            // _userBloc.addUser();
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => WelcomeScreen(
                                          user: User(name: widget.userName,avatar: _avatarUrl,role: 'Candidate'),
                                        )));
                          }),
                        ),
                        customButton('Guest', Color(0xFF70BF43), () {
                          // _userBloc.addRole('Guest');
                          // _userBloc.addUser();
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => WelcomeScreen(
                                        user: User(name: widget.userName,avatar: _avatarUrl,role: 'Guest'),
                                      )));
                        }),
                        CheckinScreen().createState().orSection(200.0, 32.0),
                        customButton(
                          'Just skip',
                          Color(0xFFF15D03),
                          () {
                            // _userBloc.addRole('');
                            // _userBloc.addUser();
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => WelcomeScreen(
                                          user: User(name: widget.userName,avatar: _avatarUrl,role: ''),
                                        )));
                          },
                        ),
                      ],
                    ),
                  ),
                  exitSection(context)
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  exitSection(BuildContext context) {
    return Align(
        alignment: Alignment.bottomLeft,
        child: FlatButton(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Container(
                height: 28.0,
                width: 28.16,
                margin: const EdgeInsets.only(right: 8.0),
                child: ImageIcon(
                  AssetImage('images/exit_icon.png'),
                  color: Color(0xFFF68B1F),
                ),
              ),
              Text(
                'Exit',
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.w500,
                  color: Color(0xFFF15D03),
                ),
              ),
            ],
          ),
          onPressed: () => Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => HomeScreen())),
        ));
  }
}
