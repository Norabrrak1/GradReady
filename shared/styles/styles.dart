import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'colors.dart';

abstract class AppTextStyles {
  static TextStyle boldTitles = GoogleFonts.dmSans(
    fontWeight: FontWeight.bold,
    fontSize: 40,
    color: AppColors.black,
  );
  static TextStyle boldTitles3 = GoogleFonts.dmSans(
      fontSize: 22, color: AppColors.white, fontWeight: FontWeight.bold);
  static TextStyle boldTitles2 = GoogleFonts.dmSans(
    fontWeight: FontWeight.w900,
    fontSize: 30,
    color: AppColors.blue2,
  );
  static TextStyle w400b =
      GoogleFonts.dmSans(fontWeight: FontWeight.bold, fontSize: 14);

  /// - weight: w300
  /// - family: cairo
  static const TextStyle w300 =
      TextStyle(fontWeight: FontWeight.w300, fontSize: 30);

  /// - weight: w400
  /// - family: cairo
  static TextStyle w400 =
      GoogleFonts.dmSans(fontWeight: FontWeight.w400, fontSize: 18);
  static TextStyle w400s =
      GoogleFonts.dmSans(fontWeight: FontWeight.w600, fontSize: 12);

  /// - weight: w500
  /// - family: cairo
  static TextStyle smTitles = GoogleFonts.dmSans(
      fontWeight: FontWeight.w500, fontSize: 16, color: AppColors.black);

  /// - weight: w600
  /// - family: cairo
  static const TextStyle w600 = TextStyle(fontWeight: FontWeight.w600);

  /// - weight: w700
  /// - family: cairo
  static const TextStyle lrTitles =
      TextStyle(fontWeight: FontWeight.w500, fontSize: 30);

  /// - weight: w800
  /// - family: cairo
  static TextStyle w800 =
      GoogleFonts.dmSans(fontWeight: FontWeight.w800, fontSize: 18);

  /// - weight: w900
  /// - family: cairo
  static const TextStyle w900 = TextStyle(fontWeight: FontWeight.w900);

  static TextStyle button = GoogleFonts.dmSans(
      fontSize: 18, color: AppColors.white, fontWeight: FontWeight.w600);

  static TextStyle name = GoogleFonts.dmSans(
      fontSize: 18, color: AppColors.black, fontWeight: FontWeight.bold);

  static TextStyle sectionTitles = GoogleFonts.dmSans(
      fontWeight: FontWeight.bold, fontSize: 30, color: AppColors.black);

  static TextStyle smSectionTitles = GoogleFonts.dmSans(
      fontWeight: FontWeight.w600, fontSize: 18, color: AppColors.black);

  static TextStyle sName = GoogleFonts.dmSans(
      fontSize: 20, color: AppColors.black, fontWeight: FontWeight.bold);

  static TextStyle radioButton = GoogleFonts.dmSans(
    fontSize: 16,
    color: AppColors.black,
    fontWeight: FontWeight.w600,
    height: 1,
  );

  static TextStyle labelStyle = GoogleFonts.dmSans(
    textStyle: const TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w600,
        height: 1,
        color: AppColors.black),
  );
  static TextStyle hintStyle = GoogleFonts.dmSans(
    textStyle: const TextStyle(
        fontSize: 15,
        fontWeight: FontWeight.w400,
        height: 1.5,
        color: AppColors.greyDark),
  );

  static TextStyle info =
      GoogleFonts.dmSans(fontSize: 18, color: AppColors.blue2);

  static TextStyle title =  GoogleFonts.dmSans(
      fontSize: 16,
      color: AppColors.blue2,
      fontWeight: FontWeight.w600);

}
