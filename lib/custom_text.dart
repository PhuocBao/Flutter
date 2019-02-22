import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {
  final String text;
  final double fontSize;
  final Color color;
  final FontWeight fontWeight;
  final String fontFamily;

  const CustomText(
      {Key key,
      this.text,
      this.fontSize,
      this.color,
      this.fontWeight,
      this.fontFamily})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
          fontSize: fontSize,
          color: color,
          fontWeight: fontWeight,
          fontFamily: fontFamily),
      textAlign: TextAlign.center,
    );
  }
}
