import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_demo_wireframe_design/translations.dart';
import 'package:flutter_demo_wireframe_design/user_provider.dart';
import 'package:rxdart/rxdart.dart';

class LanguageBloc extends BlocBase {
  Observable<Translations> get language => _languageController.stream;
  final _languageController = BehaviorSubject<Translations>();

  Future<void> changeLanguage(bool isEnglish) async {
    if (isEnglish) {
      _languageController.add(await Translations.load((Locale('en'))));
    } else {
      _languageController.add(await Translations.load((Locale('vi'))));
    }
  }

  @override
  void dispose() {
    _languageController.close();
  }
}