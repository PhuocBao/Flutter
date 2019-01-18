import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_demo_wireframe_design/check_in.dart';
import 'package:flutter_demo_wireframe_design/splash_screen.dart';
import 'package:flutter_demo_wireframe_design/user_provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.landscapeLeft, DeviceOrientation.landscapeRight]);
    return UserProvider(
          child: MaterialApp(
        theme: ThemeData(primaryColor: Color(0xFF828282)),
        debugShowCheckedModeBanner: false,
        home: SplashScreen(),
      ),
    );
  }
}

class HomeScreen extends StatefulWidget {
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _isEnglish = true;
  bool _isVnese = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
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
                  color: Color(0xFF4F4F4F),
                  fontWeight: FontWeight.w500,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          Expanded(
            child: Container(
              child: GridView.count(
                crossAxisCount: 4,
                scrollDirection: Axis.vertical,
                physics: ScrollPhysics(parent: BouncingScrollPhysics()),
                children: List.generate(10, (index) {
                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      GestureDetector(
                        child: Image.asset(index == 0
                            ? 'images/not_checking.png'
                            : 'images/checked_in.png'),
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => CheckinScreen()));
                        },
                      ),
                      Container(
                          margin: const EdgeInsets.only(top: 10.0),
                          child: Text(
                            index == 0
                                ? 'Not checking yet?'
                                : 'Anonymous $index',
                            style: TextStyle(
                                fontSize: 24.0, fontWeight: FontWeight.w500),
                          ))
                    ],
                  );
                }),
              ),
            ),
          ),
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                FlatButton(
                  textColor: _isEnglish ? Colors.black : Color(0xFFBDBDBD),
                  child: Text('English'),
                  onPressed: () {
                    setState(() {
                      _isEnglish = true;
                      _isVnese = false;
                    });
                  },
                ),
                FlatButton(
                  textColor: _isVnese ? Colors.black : Color(0xFFBDBDBD),
                  child: Text('Tiếng Việt'),
                  onPressed: () {
                    setState(() {
                      _isVnese = true;
                      _isEnglish = false;
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
