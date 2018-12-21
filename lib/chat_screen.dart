import 'package:flutter/material.dart';

import 'main.dart' as home;

class ChatScreen extends StatefulWidget {
  static const chat_route = '/chat';

  _ChatScreenState createState() => _ChatScreenState();
}

Widget optionsSection(String label, [VoidCallback callback]) {
  return Container(
      margin: EdgeInsets.symmetric(vertical: 5.0),
      width: 250.0,
      child: RaisedButton(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.only(topLeft: Radius.circular(5.0),bottomLeft: Radius.circular(5.0))),
        color: Colors.grey,
        child: Align(
          alignment: Alignment.centerLeft,
          child: home.textTheme(label, Colors.white, 13.0),
        ),
        onPressed: () {
          callback();
        },
      ));
}

class _ChatScreenState extends State<ChatScreen> {
  Widget _chatItem(String message) {
    return Container(
      margin: EdgeInsets.only(top: 20.0),
      child: ListTile(
        leading: Container(
          width: 75.0,
          height: 75.0,
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                  image: AssetImage('images/avatar_container.png'))),
          child: Image.asset(
            'images/profile_pic.jpg',
            width: 40.0,
            height: 40.0,
          ),
        ),
        title: Container(
          // color: Colors.grey,
          decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.all(Radius.circular(8.0))),
          child: Padding(
            padding: EdgeInsets.all(20.0),
            child: home.textTheme(message, Colors.black, 20.0),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: const EdgeInsets.only(
          top: 20.0,
          bottom: 20.0,
          left: 20.0,
        ),
        child: Row(
          children: <Widget>[
            Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width * 2 / 3,
              child: ListView(
                scrollDirection: Axis.vertical,
                children: <Widget>[
                  ListTile(
                    leading: Container(
                      height: 70.0,
                      width: 70.0,
                      decoration: BoxDecoration(
                          color: Colors.grey, shape: BoxShape.circle),
                      child: Center(
                          child: home.textTheme('Hi!', Colors.white, 30.0)),
                    ),
                    title: home.textTheme('Mr. Brown Smith', Colors.grey, 20.0),
                  ),
                  _chatItem('Good morning, Mr Smith. Welcome to Sioux'),
                  _chatItem(
                      'I am coming in 5 minutes. Please feel free to play with Welcome Robot while watitng')
                ],
              ),
            ),
            Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width * 1 / 3 - 20,
              child: Align(
                  alignment: Alignment.bottomRight,
                  // child: Container(
                  //   margin: EdgeInsets.only(bottom: 20.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      optionsSection('See the progress'),
                      optionsSection('See who you will meet'),
                      optionsSection('Play with Welcome Robot'),
                      optionsSection('Rate my feedback')
                    ],
                  )
                  // ),
                  ),
            )
          ],
        ),
      ),
    );
  }
}
