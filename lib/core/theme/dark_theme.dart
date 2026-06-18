import 'package:flutter/material.dart';
import 'package:tracking_app/core/constants/color_manager.dart';
import 'package:tracking_app/core/constants/font_manager.dart';
import 'package:tracking_app/core/constants/style_manager.dart';
import 'package:tracking_app/core/constants/values_manager.dart';

ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,

  scaffoldBackgroundColor: AppColors.black,

  colorScheme: ColorScheme(
    brightness: Brightness.dark,
    primary: AppColors.primary,
    onPrimary: AppColors.black,
    secondary: AppColors.white,
    onSecondary: AppColors.black,
    error: AppColors.error,
    onError: AppColors.white,
    surface: AppColors.black,
    onSurface: AppColors.white,
  ),

  textTheme: TextTheme(
    displayLarge: getBoldStyle(
      color: AppColors.black,
      fontSize: FontSize.s40,
      fontFamily: FontConstants.interFamily,
    ),
    displayMedium: getSemiBoldStyle(
      color: AppColors.black,
      fontSize: FontSize.s35,
      fontFamily: FontConstants.interFamily,
    ),
    displaySmall: getMediumStyle(
      color: AppColors.black,
      fontSize: FontSize.s30,
      fontFamily: FontConstants.interFamily,
    ),

    headlineLarge: getSemiBoldStyle(
      color: AppColors.black,
      fontSize: FontSize.s24,
      fontFamily: FontConstants.interFamily,
    ),
    headlineMedium: getMediumStyle(
      color: AppColors.black,
      fontSize: FontSize.s22,
      fontFamily: FontConstants.interFamily,
    ),
    headlineSmall: getRegularStyle(
      color: AppColors.black,
      fontSize: FontSize.s18,
      fontFamily: FontConstants.interFamily,
    ),

    titleLarge: getSemiBoldStyle(
      color: AppColors.black,
      fontSize: FontSize.s22,
      fontFamily: FontConstants.interFamily,
    ),
    titleMedium: getMediumStyle(
      color: AppColors.black,
      fontSize: FontSize.s16,
      fontFamily: FontConstants.interFamily,
    ),
    titleSmall: getRegularStyle(
      color: AppColors.black,
      fontSize: FontSize.s14,
      fontFamily: FontConstants.interFamily,
    ),

    bodyLarge: getRegularStyle(
      color: AppColors.grey,
      fontSize: FontSize.s16,
      fontFamily: FontConstants.interFamily,
    ),
    bodyMedium: getRegularStyle(
      color: AppColors.grey,
      fontSize: FontSize.s14,
      fontFamily: FontConstants.interFamily,
    ),
    bodySmall: getRegularStyle(
      color: AppColors.grey,
      fontSize: FontSize.s12,
      fontFamily: FontConstants.interFamily,
    ),

    labelLarge: getMediumStyle(
      color: AppColors.placeholder,
      fontSize: FontSize.s14,
      fontFamily: FontConstants.interFamily,
    ),
    labelMedium: getMediumStyle(
      color: AppColors.placeholder,
      fontSize: FontSize.s12,
      fontFamily: FontConstants.interFamily,
    ),
    labelSmall: getRegularStyle(
      color: AppColors.placeholder,
      fontSize: FontSize.s10,
      fontFamily: FontConstants.interFamily,
    ),
  ),

  appBarTheme: AppBarTheme(
    backgroundColor: AppColors.transparent,
    foregroundColor: AppColors.black,
    titleTextStyle: getRegularStyle(
      color: AppColors.black,
      fontSize: FontSize.s20,
      fontFamily: FontConstants.interFamily,
    ),
    leadingWidth: AppSize.s25,
    actionsPadding: EdgeInsets.only(right: AppPadding.p20),
    titleSpacing: AppSize.s0,
    elevation: 0,
  ),

  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: AppColors.primary,
      foregroundColor: AppColors.white,
      disabledBackgroundColor: AppColors.lightGrey,
      disabledForegroundColor: AppColors.white,
      padding: EdgeInsets.all(AppPadding.p16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
      textStyle: getMediumStyle(
        color: AppColors.black,
        fontSize: FontSize.s16,
        fontFamily: FontConstants.interFamily,
      ),
    ),
  ),

  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: AppColors.transparent,
    hintStyle: TextStyle(
      color: AppColors.placeholder,
      fontSize: FontSize.s16,
      fontFamily: FontConstants.interFamily,
    ),
    labelStyle: TextStyle(
      color: AppColors.grey,
      fontSize: FontSize.s18,
      fontWeight: FontWeight.w500,
      fontFamily: FontConstants.interFamily,
    ),
    floatingLabelStyle: getRegularStyle(
      color: AppColors.grey,
      fontSize: FontSize.s18,
      fontFamily: FontConstants.interFamily,
    ),
    floatingLabelBehavior: FloatingLabelBehavior.always,
    errorStyle: getRegularStyle(
      color: AppColors.error,
      fontSize: FontSize.s12,
      fontFamily: FontConstants.interFamily,
    ),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(RadiusSize.r4),
      borderSide: BorderSide(color: AppColors.grey),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(RadiusSize.r4),
      borderSide: BorderSide(color: AppColors.grey),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(RadiusSize.r4),
      borderSide: BorderSide(color: AppColors.primary, width: AppSize.s2),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(RadiusSize.r4),
      borderSide: BorderSide(color: AppColors.error, width: AppSize.s1),
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(RadiusSize.r4),
      borderSide: BorderSide(color: AppColors.error, width: AppSize.s2),
    ),

    contentPadding: EdgeInsets.all(AppPadding.p16),
  ),

  progressIndicatorTheme: ProgressIndicatorThemeData(
    color: AppColors.primary,
    linearTrackColor: AppColors.grey,
    borderRadius: BorderRadius.circular(RadiusSize.r8),
  ),

  dialogTheme: DialogThemeData(
    backgroundColor: AppColors.white,
    elevation: 0,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
    titleTextStyle: getSemiBoldStyle(
      color: AppColors.black,
      fontSize: FontSize.s18,
      fontFamily: FontConstants.interFamily,
    ),
    contentTextStyle: getRegularStyle(
      color: AppColors.black,
      fontSize: FontSize.s16,
      fontFamily: FontConstants.interFamily,
    ),
  ),
);
