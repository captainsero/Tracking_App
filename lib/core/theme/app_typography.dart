import 'package:flutter/material.dart';
import 'package:tracking_app/core/constants/font_manager.dart';

extension AppTypography on num {
  TextStyle get medium => TextStyle(
        fontFamily: FontConstants.interFamily,
        fontSize: toDouble(),
        fontWeight: FontWeightManager.medium,
      );

  TextStyle get regular => TextStyle(
        fontFamily: FontConstants.interFamily,
        fontSize: toDouble(),
        fontWeight: FontWeightManager.regular,
      );

  TextStyle get bold => TextStyle(
        fontFamily: FontConstants.interFamily,
        fontSize: toDouble(),
        fontWeight: FontWeightManager.bold,
      );
}
