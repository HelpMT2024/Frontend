import 'package:flutter/material.dart';
import 'package:help_my_truck/services/router/router.dart';
import '../shared_preferences_wrapper.dart';

class L10n {
  static List<Locale> support = [
    L10nLocales.en.locale,
    L10nLocales.ua.locale,
    L10nLocales.ru.locale
  ];
}

enum L10nLocales { en, ua, ru }

L10nLocales? localeFrom(String string) {
  switch (string) {
    case 'en':
      return L10nLocales.en;
    case 'uk':
      return L10nLocales.ua;
    case 'ru':
      return L10nLocales.ru;
  }

  return null;
}

L10nLocales localeFromServerCode(String value) {
  switch (value) {
    case 'en':
      return L10nLocales.en;
    case 'ua':
      return L10nLocales.ua;
    case 'ru':
      return L10nLocales.ru;
    default:
      return L10nLocales.en;
  }
}

String serverCodeFrom(L10nLocales locale) {
  switch (locale) {
    case L10nLocales.en:
      return 'en';
    case L10nLocales.ua:
      return 'ua';
    case L10nLocales.ru:
      return 'ru';
  }
}

String nameFrom(L10nLocales locale) {
  switch (locale) {
    case L10nLocales.en:
      return 'English';
    case L10nLocales.ua:
      return 'Україньска';
    case L10nLocales.ru:
      return 'Русский';
  }
}

String talkJSKey(L10nLocales locale) {
  switch (locale) {
    case L10nLocales.ua:
      return 'uk-UA';
    case L10nLocales.en:
      return 'en-US';
    case L10nLocales.ru:
      return 'ru-RU';
  }
}

extension L10nLocalesExtension on L10nLocales {
  Locale get locale {
    switch (this) {
      case L10nLocales.en:
        return const Locale('en');
      case L10nLocales.ua:
        return const Locale('uk');
      case L10nLocales.ru:
        return const Locale('ru');
      default:
        return const Locale('en');
    }
  }
}

class LocaleProvider with ChangeNotifier {
  L10nLocales? language;
  Locale? get locale => language?.locale;

  LocaleProvider(this.language);

  void setLocale(L10nLocales loc, bool needNotify) {
    language = loc;
    restAPIService.addLocale(loc);
    SharedPreferencesWrapper.setLocale(loc);
    if (needNotify) {
      notifyListeners();
    }
  }
}
