import 'package:flutter/material.dart';

class LanguageController {
  static final ValueNotifier<Locale> locale =
      ValueNotifier<Locale>(const Locale('en'));

  static const Map<String, Locale> languages = {
    'English': Locale('en'),
    'Arabic': Locale('ar'),
    'French': Locale('fr'),
    'Spanish': Locale('es'),
    'German': Locale('de'),
    'Italian': Locale('it'),
    'Turkish': Locale('tr'),
    'Russian': Locale('ru'),
    'Chinese': Locale('zh'),
    'Japanese': Locale('ja'),
  };

  static void changeLanguage(String language) {
    final newLocale = languages[language];

    if (newLocale != null) {
      locale.value = newLocale;
    }
  }
}