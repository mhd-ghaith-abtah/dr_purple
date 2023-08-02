import 'dart:io';
import 'dart:ui';

import 'package:dr_purple/app/storage/app_preferences.dart';

const String translationAssetsPath = "assets/translation";

class SupportedLanguages {
  static final all = [
    const Locale("en"),
    const Locale("ar"),
  ];
}

enum Language {
  en,
  ar;

  @override
  String toString() => name;
}

class LanguageManager {
  final AppPreferences _appPreferences;

  Locale? _locale;

  LanguageManager(this._appPreferences);

  Locale get locale => _locale ?? Locale(Language.en.name);

  bool get isArabic => _locale == Locale(Language.ar.name);

  Language get appCurrentLanguage =>
      _locale == Locale(Language.ar.name) ? Language.ar : Language.en;

  void initiateLocale() {
    final language = _appPreferences.getAppLanguage();
    if (language != null) {
      Locale newLocal = Locale(language.name);
      if (SupportedLanguages.all.contains(newLocal)) _locale = newLocal;
    } else {
      final languageCode = Platform.localeName.substring(0, 2);
      final platformLocale = Locale(languageCode);
      if (SupportedLanguages.all.contains(platformLocale)) {
        _locale = platformLocale;
      } else {
        _locale = Locale(Language.en.name);
      }
    }
  }

  Future<Locale> setLocal(Language language) async {
    final newLocale = Locale(language.name);
    if (SupportedLanguages.all.contains(newLocale)) {
      await _appPreferences.setAppLanguage(languageValue: language);
      _locale = newLocale;
    }
    return newLocale;
  }
}
