import 'package:flutter/material.dart';

class ButtonBorder extends StatelessWidget {
  final String content;
  final VoidCallback callback;

  const ButtonBorder({Key key, this.content, this.callback}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 48.0,
      width: 140.0,
      decoration: BoxDecoration(
        border: Border.all(color: Color(0xFFF15D03),),
        borderRadius: BorderRadius.circular(32.0),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0,vertical: 13.0),
        child: Text(content, style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w500,color: Color(0xFFF15D03)),textAlign: TextAlign.center,),
      ),
    );
  }
}