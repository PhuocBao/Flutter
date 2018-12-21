import 'package:flutter/material.dart';
import 'main.dart' as home;

class FeedbackScreen extends StatefulWidget {
  _FeedbackScreenState createState() => _FeedbackScreenState();
}

class _FeedbackScreenState extends State<FeedbackScreen> {
  Widget _iconSection(String imgUrl, String emotion) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Container(
          margin: const EdgeInsets.only(top: 50.0, bottom: 20.0),
          child: Image.asset(imgUrl),
        ),
        Padding(
          padding: const EdgeInsets.only(right: 20.0),
          child: Text(emotion),
        )
      ],
    );
  }

  Widget _rateIconSection() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        _iconSection('images/terrible_icon.png', 'Terriable'),
        _iconSection('images/bad_icon.png', 'Bad'),
        _iconSection('images/okay_icon.png', 'Okay'),
        _iconSection('images/good_icon.png', 'Good'),
        _iconSection('images/excellent_icon.png', 'Excellent'),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Align(
            alignment: Alignment.topCenter,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 50.0),
                  child: Image.asset('images/logo.png'),
                ),
                home.textTheme('How was your experience?', Colors.grey, 30.0),
              ],
            ),
          ),
          Center(
            child: _rateIconSection(),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 50.0),
                  child: TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(8.0)),borderSide: BorderSide(color: Colors.grey)),
                    hintText: 'What could we do better?',                   
                  ),
                ),
                ),
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 20.0),
                  child: RaisedButton(
                    color: Colors.grey,
                    child: Text('Rate your feedback'),
                    onPressed: () {},
                  ),
                )
              ],
            )
          )
        ],
      ),
    );
  }
}
