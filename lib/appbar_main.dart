import 'package:flutter/material.dart';

class AppBarMain extends StatelessWidget {
  final String content;
  final bool isImplyLeading;
  final String leadingText;

  const AppBarMain({Key key, @required this.content, @required this.isImplyLeading, @required this.leadingText}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topCenter,
      height: 128.0,
      child: AppBar(
        automaticallyImplyLeading: isImplyLeading,
        title: Text(leadingText, style: TextStyle(fontWeight: FontWeight.w500,
                fontSize: 18.0,
                color: Colors.white),),
        flexibleSpace: Center(
          child: Text(
            content,
            style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 48.0,
                color: Colors.white),
          ),
        ),
        elevation: 0.0,
        backgroundColor: Color(0xFFF68B1F),
      ),
    );
  }
}
