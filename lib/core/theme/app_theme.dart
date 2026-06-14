import 'package:flutter/material.dart';
import 'package:tracking_app/core/theme/light_theme.dart' as light;
import 'package:tracking_app/core/theme/dark_theme.dart' as dark;

abstract class AppTheme {
  static ThemeData get lightTheme => light.lightTheme;
  static ThemeData get darkTheme => dark.darkTheme;
}
