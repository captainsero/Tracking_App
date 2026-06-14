import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

abstract class FontConstants {
  static final interFamily = "Inter";
  static final imfEllEnglish = "IMFellEnglish";
}

abstract class FontWeightManager {
  static const FontWeight light = FontWeight.w300;
  static const FontWeight regular = FontWeight.w400;
  static const FontWeight medium = FontWeight.w500;
  static const FontWeight semiBold = FontWeight.w600;
  static const FontWeight bold = FontWeight.w700;
}

class FontSize {
  static const double s12c = 12;
  static double get s10 => 10.sp;
  static double get s12 => 12.sp;
  static double get s14 => 14.sp;
  static double get s16 => 16.sp;
  static double get s17 => 17.sp;
  static double get s18 => 18.sp;
  static double get s20 => 20.sp;
  static double get s22 => 22.sp;
  static double get s24 => 24.sp;
  static double get s25 => 25.sp;
  static double get s30 => 30.sp;
  static double get s35 => 35.sp;
  static double get s40 => 40.sp;
  static double get s48 => 48.sp;
}
