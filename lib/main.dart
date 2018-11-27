import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('images/pacific_rim.jpg'),
                    fit: BoxFit.fitHeight)),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
              child: Container(
                decoration: BoxDecoration(color: Colors.white.withOpacity(0.0)),
              ),
            ),
          ),
          AppBar(
            backgroundColor: Colors.transparent,
            title: Text('Pacific Rim'),
            centerTitle: true,
            leading: IconButton(
              icon: Icon(CupertinoIcons.back),
              onPressed: () {},
            ),
            actions: <Widget>[
              Container(
                margin: EdgeInsets.only(right: 10.0),
                child: IconButton(
                  icon: Icon(CupertinoIcons.search),
                  onPressed: () {},
                ),
              )
            ],
          ),
          Center(
            child: Container(
                margin: EdgeInsets.only(
                    left: 25.0,
                    right: 25.0,
                    bottom: 30.0,
                    top: MediaQuery.of(context).size.height / 4),
                child: cardSection()),
          ),
          Center(
            child: Container(
                margin: EdgeInsets.only(
                    top: AppBar().preferredSize.height + 15,
                    bottom: MediaQuery.of(context).size.height / 3),
                child: ClipRRect(
                  child: Image.asset(
                    'images/pacific_rim.jpg',
                    fit: BoxFit.scaleDown,
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(15.0)),
                )),
          )
        ],
      ),
    );
  }

  Widget _starSection() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Icon(
          Icons.star,
          color: Colors.yellow,
        ),
        Icon(
          Icons.star,
          color: Colors.yellow,
        ),
        Icon(
          Icons.star,
          color: Colors.yellow,
        ),
        Icon(
          Icons.star,
          color: Colors.yellow,
        ),
        Icon(
          Icons.star,
          color: Colors.yellow,
        ),
      ],
    );
  }

  Widget timeSection(Icon icon, String text) {
    return Row(
      children: <Widget>[icon, Text(text)],
    );
  }

  Widget chipSection(String text) {
    return Container(
      margin: EdgeInsets.only(right: 10.0),
      child: Chip(
        label: Text(
          text,
          style: TextStyle(color: Colors.white),
          softWrap: true,
        ),
        backgroundColor: Colors.green[300],
        materialTapTargetSize: MaterialTapTargetSize.padded,
      ),
    );
  }

  Widget actorSection() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(right: 5.0),
          child: CircleAvatar(backgroundImage: AssetImage('images/profile_pic.jpg'),),
        ),
        Container(
          margin: EdgeInsets.only(right: 5.0),
          child: CircleAvatar(backgroundImage: AssetImage('images/profile_pic.jpg'),),
        ),
        Container(
          margin: EdgeInsets.only(right: 5.0),
          child: CircleAvatar(backgroundImage: AssetImage('images/profile_pic.jpg'),),
        ),
        Container(
          margin: EdgeInsets.only(right: 5.0),
          child: CircleAvatar(backgroundImage: AssetImage('images/profile_pic.jpg'),),
        ),
      ],
    );
  }

  Widget cardSection() {
    return Card(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10.0))),
      child: ListView(
        children: <Widget>[
          Center(
            child: Container(
              margin: EdgeInsets.only(
                  top: (MediaQuery.of(context).size.height * 6) / 15),
              child: Text(
                'Pacific Rim',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20.0,
                    color: Colors.black),
              ),
            ),
          ),
          Center(
            child: _starSection(),
          ),
          Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(right: 20.0),
                  child: timeSection(
                      Icon(
                        Icons.timer,
                        color: Colors.grey,
                      ),
                      '111 min'),
                ),
                timeSection(
                    Icon(Icons.camera, color: Colors.grey), 'Mar 23 2018')
              ],
            ),
          ),
          Center(
            child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              chipSection('Action'),
              chipSection('Adventure'),
              chipSection('Science'),
            ],
          )),
          Center(
            child: Container(
              margin: EdgeInsets.all(5.0),
              child: actorSection(),
            )
          )
        ],
      ),
    );
  }
}
