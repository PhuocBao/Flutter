import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_demo_wireframe_design/see_person.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.landscapeLeft, DeviceOrientation.landscapeRight]);
    return MaterialApp(
      home: HomeScreen(),
    );
  }
}

Widget textTheme(String label, Color color, double size) {
  return Text(
    label,
    style: TextStyle(color: color, fontSize: size),
  );
}

class HomeScreen extends StatefulWidget {
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Container(
        margin: EdgeInsets.only(top: 30.0, bottom: 20.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            textTheme('Welcome to Sioux', Colors.grey, 50.0),
            Container(
              width: 300.0,
              height: 300.0,
              margin: EdgeInsets.symmetric(vertical: 20.0),
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('images/profile_pic.jpg')),
                  shape: BoxShape.circle),
            ),
            textTheme('Mr. Brown Smith', Colors.grey, 30.0),
            textTheme('Job title', Colors.grey, 20.0),
            Container(
              margin: EdgeInsets.only(top: 30.0),
              child: RaisedButton(
                shape: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(5.0)),
                    borderSide: BorderSide(width: 0.0, color: Colors.grey)),
                color: Colors.grey,
                child: textTheme('See who you will meet', Colors.white, 15.0),
                onPressed: () => Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => SeePersonInCharge())),
              ),
            )
          ],
        ),
      )),
    );
  }
}
