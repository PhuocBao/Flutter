import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:async';
import 'dart:convert';

class Translations {
  Locale locale;
  static Map<dynamic, dynamic> _localizedValues;

  Translations(Locale locale) {
    this.locale = locale;
    _localizedValues = null;
  }

  static Translations of(BuildContext context) {
    return Localizations.of<Translations>(context, Translations);
  }

  String text(String key) {
    return _localizedValues[key];
  }

  static Future<Translations> load(Locale locale) async {
    Translations translations = Translations(locale);
    String json =
        await rootBundle.loadString('locale/i18n_${locale.languageCode}.json');
    _localizedValues = jsonDecode(json);
    return translations;
  }

  get currentLanguage => locale.languageCode;
}

class TranslationsDelegate extends LocalizationsDelegate<Translations> {
  const TranslationsDelegate();

  @override
  bool isSupported(Locale locale) => ['en', 'vi'].contains(locale.languageCode);

  @override
  Future<Translations> load(Locale locale) => Translations.load(locale);

  @override
  bool shouldReload(TranslationsDelegate old) => false;
}
