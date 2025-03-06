import 'package:flutter/material.dart';
import 'app_colors.dart';

class FontWeights {
  static FontWeight boldFontWeight = FontWeight.w800;
  static FontWeight fontWeight700 = FontWeight.w700;
  static FontWeight semiBoldFontWeight = FontWeight.w600;
  static FontWeight mediumFontWeight = FontWeight.w500;
  static FontWeight normalFontWeight = FontWeight.w400;
}


class AppFonts {
  static TextStyle headingStyle = TextStyle(
    fontSize: 24,
    fontWeight: FontWeights.boldFontWeight,
    color: AppColors.textColor,
  );

  static TextStyle mediumHeadingStyle = TextStyle(
    fontSize: 16,
    color: AppColors.textColor,
    fontWeight: FontWeights.boldFontWeight,
  );

  static TextStyle buttonStyle = TextStyle(
    fontSize: 18,
    fontWeight: FontWeights.semiBoldFontWeight,
    color: Colors.white,
  );
}