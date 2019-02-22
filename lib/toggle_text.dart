import 'package:flutter/material.dart';
import 'package:flutter_demo_wireframe_design/custom_text.dart';
import 'package:flutter_demo_wireframe_design/language_bloc.dart';
import 'package:flutter_demo_wireframe_design/translations.dart';
import 'package:flutter_demo_wireframe_design/user_provider.dart';

class ToggleText extends StatelessWidget {
  final String newText;
  final String placeHolderText;
  final double fontSize;
  final Color color;
  final FontWeight fontWeight;
  final String fontFamily;

  const ToggleText({
    Key key,
    this.newText,
    this.placeHolderText,
    this.fontSize,
    this.color,
    this.fontWeight,
    this.fontFamily,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _languageBloc = BlocProvider.of<LanguageBloc>(context);
    return StreamBuilder<Translations>(
      stream: _languageBloc.language,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return CustomText(
            color: color,
            fontFamily: fontFamily,
            fontSize: fontSize,
            fontWeight: fontWeight,
            text: snapshot.data.text(newText),
          );
        } else {
          return CustomText(
            color: color,
            fontFamily: fontFamily,
            fontSize: fontSize,
            fontWeight: fontWeight,
            text: placeHolderText,
          );
        }
      },
    );
  }
}
