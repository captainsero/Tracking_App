import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocaleCubit extends Cubit<Locale> {
  static const String _kLanguageKey = 'selected_language';

  LocaleCubit(Locale initialLocale) : super(initialLocale);

  /// Call this once in main() before runApp to get the saved locale.
  static Future<Locale> loadSavedLocale() async {
    final prefs = await SharedPreferences.getInstance();
    final langCode = prefs.getString(_kLanguageKey);
    if (langCode != null) {
      return Locale(langCode);
    }
    return const Locale('ar'); // default
  }

  /// Change locale and immediately persist the choice.
  Future<void> changeLocale(Locale locale) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_kLanguageKey, locale.languageCode);
    emit(locale);
  }

  bool get isArabic => state.languageCode == 'ar';
}
