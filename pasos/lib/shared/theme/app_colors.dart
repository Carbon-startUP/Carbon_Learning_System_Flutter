import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  static const Color background = Color(0xFF110420);
  //  static const Color background = Color.fromARGB(255, 255, 255, 255);

  static const Color primary = Color(0xFF6C36FE);

  static const Color secondary = Color(0xFFE271FD);
  static const Color secondaryAlt = Color(0xFFFA438E);

  static const Color white = Color(0xFFFFFFFF);
  static const Color textPrimary = white;
  static const Color textSecondary = Color(0xFFE271FD);

  static const Color error = Color(0xFFFF5252);
  static const Color success = Color(0xFF4CAF50);
  static const Color warning = Color(0xFFFFC107);
  static const Color info = Color(0xFF2196F3);

  static Color get primaryWithOpacity => primary.withValues(alpha: .1);
  static Color get whiteWithOpacity => white.withValues(alpha: .8);

  static const LinearGradient primaryGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [primary, secondary],
  );

  static const LinearGradient secondaryGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [secondary, secondaryAlt],
  );
}
