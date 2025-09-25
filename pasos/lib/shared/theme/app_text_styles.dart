import 'package:flutter/material.dart';
import 'app_colors.dart';

class AppTextStyles {
  AppTextStyles._();

  static const String _fontFamilyEnglish = 'NEXA';
  static const String _fontFamilyArabic = 'RPT';

  static TextStyle get headlineLarge => const TextStyle(
    fontSize: 32,
    fontWeight: FontWeight.bold,
    color: AppColors.secondary,
    fontFamily: _fontFamilyEnglish,
  );

  static TextStyle get headlineMedium => const TextStyle(
    fontSize: 28,
    fontWeight: FontWeight.bold,
    color: AppColors.secondary,
    fontFamily: _fontFamilyEnglish,
  );

  static TextStyle get headlineSmall => const TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.w600,
    color: AppColors.secondary,
    fontFamily: _fontFamilyEnglish,
  );

  static TextStyle get titleLarge => const TextStyle(
    fontSize: 22,
    fontWeight: FontWeight.w600,
    color: AppColors.secondary,
    fontFamily: _fontFamilyEnglish,
  );

  static TextStyle get titleMedium => const TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w500,
    color: AppColors.secondary,
    fontFamily: _fontFamilyEnglish,
  );

  static TextStyle get titleSmall => const TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w500,
    color: AppColors.secondary,
    fontFamily: _fontFamilyEnglish,
  );

  static TextStyle get bodyLarge => const TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.normal,
    color: AppColors.white,
    fontFamily: _fontFamilyEnglish,
  );

  static TextStyle get bodyMedium => const TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.normal,
    color: AppColors.white,
    fontFamily: _fontFamilyEnglish,
  );

  static TextStyle get bodySmall => const TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.normal,
    color: AppColors.white,
    fontFamily: _fontFamilyEnglish,
  );

  static TextStyle get labelLarge => const TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    color: AppColors.white,
    fontFamily: _fontFamilyEnglish,
  );

  static TextStyle get labelMedium => const TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w500,
    color: AppColors.white,
    fontFamily: _fontFamilyEnglish,
  );

  static TextStyle get labelSmall => const TextStyle(
    fontSize: 10,
    fontWeight: FontWeight.w500,
    color: AppColors.white,
    fontFamily: _fontFamilyEnglish,
  );

  static TextStyle get buttonText => const TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: AppColors.white,
    fontFamily: _fontFamilyEnglish,
  );

  static TextStyle get arabicHeadline => const TextStyle(
    fontSize: 32,
    fontWeight: FontWeight.bold,
    color: AppColors.secondary,
    fontFamily: _fontFamilyArabic,
  );

  static TextStyle get arabicBody => const TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.normal,
    color: AppColors.white,
    fontFamily: _fontFamilyArabic,
  );
}
