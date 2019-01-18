import 'package:flutter/material.dart';
import 'package:flutter_demo_wireframe_design/user_provider.dart';
import 'package:flutter_demo_wireframe_design/welcome_screen.dart';
import 'input_name.dart' as input;

class VisitPurpose extends StatefulWidget {
  final String userName;

  const VisitPurpose({Key key, this.userName}) : super(key: key);

  _VisitPurposeState createState() => _VisitPurposeState();
}

class _VisitPurposeState extends State<VisitPurpose> {
  Widget customButton(String label, VoidCallback onPress) {
    return Container(
      width: 350.0,
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
        color: Color(0xFF828282),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(40.0))),
        onPressed: onPress,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final _userBloc = UserProvider.of(context);
    return Stack(
      children: <Widget>[
        Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                'Hi ${widget.userName}, you come as...',
                style: TextStyle(fontSize: 36.0),
                textAlign: TextAlign.center,
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 25.0),
                child: customButton('Candidate', () {
                  _userBloc.addRole('Candidate');
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => WelcomeScreen()));
                }),
              ),
              customButton('Guest', () {
                _userBloc.addRole('Guest');
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => WelcomeScreen()));
              }),
              input.orSection(200.0),
              customButton(
                'Just skip',
                () {
                  _userBloc.addRole('');
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => WelcomeScreen()));
                },
              ),
            ],
          ),
        ),
        input.exitSection(context)
      ],
    );
  }
}
