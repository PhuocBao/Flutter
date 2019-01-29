import 'package:flutter/material.dart';
import 'package:flutter_demo_wireframe_design/constants.dart';
import 'package:flutter_demo_wireframe_design/user_provider.dart';
import 'package:flutter_demo_wireframe_design/welcome_screen.dart';
import 'input_name.dart' as input;

class VisitPurpose extends StatefulWidget {
  final String userName;

  VisitPurpose({Key key, this.userName}) : super(key: key);

  _VisitPurposeState createState() => _VisitPurposeState();
}

class _VisitPurposeState extends State<VisitPurpose> {
  String _displayName;
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
    if (widget.userName.contains(' ', 0)) {
      int _firstSpace = widget.userName.indexOf(' ');
      _displayName = widget.userName.substring(0, _firstSpace);
    } else if (!widget.userName.contains(' ') && widget.userName.length >= 6) {
      _displayName = widget.userName.substring(0, 6) + '...';
    } else {
      _displayName = widget.userName;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final _userBloc = UserProvider.of(context);
    String _avatarUrl;
    int spacePos = widget.userName.indexOf(' ');
    String animalName = widget.userName.substring(spacePos + 1);
    for (var i = 0; i < kAnimalAvatar.length; i++) {
      if (kAnimalAvatar.elementAt(i).contains(animalName, 16) == true) {
        _avatarUrl = kAnimalAvatar.elementAt(i);
        break;
      }
    }
    _userBloc.addAvatar(_avatarUrl);
    return ClipRRect(
      borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16.0), topRight: Radius.circular(16.0)),
      child: Container(
        color: Colors.white,
        height: MediaQuery.of(context).size.height - 128.0,
        width: MediaQuery.of(context).size.width,
        child: Stack(
          children: <Widget>[
            Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text(
                    'Hi $_displayName, you come as...',
                    style: TextStyle(fontSize: 36.0, color: Color(0xFFF15D03)),
                    textAlign: TextAlign.center,
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 38.0, bottom: 32.0),
                    child: customButton('Candidate', Color(0xFF00AEEF), () {
                      _userBloc.addRole('Candidate');
                      _userBloc.addUser();
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => WelcomeScreen()));
                    }),
                  ),
                  customButton('Guest', Color(0xFF70BF43), () {
                    _userBloc.addRole('Guest');
                    _userBloc.addUser();
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => WelcomeScreen()));
                  }),
                  input.orSection(200.0, 32.0),
                  customButton(
                    'Just skip',
                    Color(0xFFF15D03),
                    () {
                      _userBloc.addRole('');
                      _userBloc.addUser();
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => WelcomeScreen()));
                    },
                  ),
                ],
              ),
            ),
            input.exitSection(context)
          ],
        ),
      ),
    );
  }
}
