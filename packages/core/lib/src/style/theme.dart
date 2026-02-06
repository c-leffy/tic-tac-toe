import 'package:core/src/style/size.dart';
import 'package:flutter/material.dart';

abstract final class AppColors {
  static const background = Color(0xFFFEFBF7);
  static const surface = Color(0xFFFFFFFF);
  static const primary = Color(0xFFFFE500);
  static const secondary = Color(0xFFFF6B35);
  static const text = Color(0xFF000000);
  static const border = Color(0xFF000000);
  static const shadow = Color(0xFF000000);
}

final appTheme = ThemeData(
  brightness: Brightness.light,
  scaffoldBackgroundColor: AppColors.background,
  colorScheme: ColorScheme.light(
    primary: AppColors.primary,
    secondary: AppColors.secondary,
    surface: AppColors.surface,
    onPrimary: Colors.black,
    onSecondary: Colors.white,
    onSurface: Colors.black,
  ),
  textTheme: const TextTheme(
    headlineSmall: TextStyle(
      fontSize: 24,
      fontWeight: FontWeight.bold,
      color: AppColors.text,
    ),
    bodyLarge: TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.w600,
      color: AppColors.text,
    ),
  ),
  dialogTheme: DialogThemeData(
    backgroundColor: AppColors.surface,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(Size.small),
      side: const BorderSide(color: AppColors.border, width: Size.tiny),
    ),
    titleTextStyle: const TextStyle(
      fontSize: 24,
      fontWeight: FontWeight.bold,
      color: AppColors.text,
    ),
  ),
);
