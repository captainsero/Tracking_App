import 'package:flutter/material.dart';

class AppTextStyles {
  AppTextStyles._();

  static const appBarTitle = TextStyle(
    color: AppColorsHelper.background,
    fontSize: 18,
    fontWeight: FontWeight.w600,
  );

  static const screenTitle = TextStyle(
    color: AppColorsHelper.textPrimary,
    fontSize: 18,
    fontWeight: FontWeight.w600,
  );

  static const subtitle = TextStyle(
    color: AppColorsHelper.textSecondary,
    fontSize: 13,
    height: 1.4,
  );

  static const inputLabel = TextStyle(
    color: AppColorsHelper.textPrimary,
    fontSize: 13,
    fontWeight: FontWeight.w500,
  );

  static const inputHint = TextStyle(
    color: AppColorsHelper.hintColor,
    fontSize: 14,
  );

  static const inputText = TextStyle(
    color: AppColorsHelper.textPrimary,
    fontSize: 14,
  );

  static const errorText = TextStyle(
    color: AppColorsHelper.error,
    fontSize: 12,
  );

  static const linkText = TextStyle(
    color: AppColorsHelper.primary,
    fontSize: 13,
    fontWeight: FontWeight.w600,
  );

  static const buttonText = TextStyle(
    color: AppColorsHelper.background,
    fontSize: 15,
    fontWeight: FontWeight.w600,
  );
}

abstract class AppColorsHelper {
  //colors specific to ui components
  static const Color primary = Color(0xFFC93A78);
  static const Color background = Colors.white;
  static const Color textPrimary = Color(0xFF1A1A1A);
  static const Color textSecondary = Color(0xFF9B9B9B);
  static const Color hintColor = Color(0xFFBFBFC6);
  static const Color border = Color(0xFFE3E3E8);
  static const Color borderFocused = primary;
  static const Color inputFill = Color(0xFFFAFAFC);
  static const Color disabledButton = Color(0xFFF1B8D2);
  static const Color error = Color(0xffB3261E);
}
