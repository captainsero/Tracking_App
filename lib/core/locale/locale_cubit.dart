import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum AppLanguage {
  arabic('ar'),
  english('en');

  final String code;
  const AppLanguage(this.code);

  static AppLanguage fromCode(String code) {
    return AppLanguage.values.firstWhere(
      (lang) => lang.code == code,
      orElse: () => AppLanguage.arabic,
    );
  }
}

class LocaleCubit extends Cubit<Locale> {
  static const String _kLanguageKey = 'selected_language';

  LocaleCubit(Locale initialLocale) : super(initialLocale);

  static Future<Locale> loadSavedLocale() async {
    final prefs = await SharedPreferences.getInstance();
    final langCode = prefs.getString(_kLanguageKey);
    final language = langCode != null
        ? AppLanguage.fromCode(langCode)
        : AppLanguage.arabic;
    return Locale(language.code);
  }

  Future<void> changeLocale(AppLanguage language) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_kLanguageKey, language.code);
    emit(Locale(language.code));
  }

  bool get isArabic => state.languageCode == AppLanguage.arabic.code;
}