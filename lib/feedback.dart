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
        body: ListView(
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
        Container(
          margin: EdgeInsets.only(top: 120.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Container(
                  color: Color(0xFFF2F2F2),
                  height: 60.0,
                  margin: const EdgeInsets.symmetric(horizontal: 50.0),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                          child: Theme(
                              data: ThemeData(primaryColor: Color(0xFFF2F2F2)),
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: TextField(
                                  decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: 'What could we do better?',
                                      hintStyle: TextStyle(color: Colors.grey),
                                      suffix: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: <Widget>[
                                          InkWell(
                                            child: Text('Cancel'),
                                            onTap: () {},
                                          ),
                                        ],
                                      )),
                                  keyboardType: TextInputType.text,
                                ),
                              ))),
                      Container(
                          height: 60.0,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                                topRight: Radius.circular(5.0),
                                bottomRight: Radius.circular(5.0)),
                            color: Colors.grey,
                          ),
                          child: Center(
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20.0),
                              child: InkWell(
                                child: Text('OK'),
                              ),
                            ),
                          ))
                    ],
                  )),
              Container(
                margin: const EdgeInsets.only(top: 30.0, bottom: 20.0),
                child: RaisedButton(
                  color: Colors.grey,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(5.0))),
                  child:
                      home.textTheme('Rate your feedback', Colors.white, 15.0),
                  onPressed: () {},
                ),
              )
            ],
          ),
        )
      ],
    ));
  }
}
