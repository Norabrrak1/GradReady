import 'package:flutter/material.dart';
import 'package:grad_ready/shared/styles/styles.dart';
import 'colors.dart';

ThemeData lightTheme = ThemeData(
  scaffoldBackgroundColor: AppColors.white4,

  appBarTheme: AppBarTheme(
      backgroundColor: AppColors.white4,
      elevation: 0,
      centerTitle: true,
      iconTheme: const IconThemeData(color: AppColors.black),
      titleTextStyle: AppTextStyles.boldTitles3.apply(color: AppColors.blue),
      actionsIconTheme: const IconThemeData(color: AppColors.white)),
);
