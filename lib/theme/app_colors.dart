import 'package:flutter/material.dart';

class AppColors {
  static const primarySwatch = MaterialColor(
    0xFF15141F,
    <int, Color>{
      50: Color(0xFFE3F2FD),
      100: Color(0xFFBBDEFB),
      200: Color(0xFF90CAF9),
      300: Color(0xFF64B5F6),
      400: Color(0xFF42A5F5),
      500: primaryColor,
      600: Color(0xFF1E88E5),
      700: Color(0xFF1976D2),
      800: Color(0xFF1565C0),
      900: Color(0xFF0D47A1),
    },
  );

  static const backgroundColor = Color(0xFF15141F);
  static const primaryColor = Color(0xFF15141F);
  static const onPrimaryColor = Color(0xFFFFFFFF);
  static const secondaryColor = Color.fromARGB(255, 255, 112, 72);
  static const onSecondaryColor = Color(0xFFFF8F71);
  static const onBackgroundColor = Color(0xFFFFFFFF);
  static const surfaceColor = Color(0xFF211F30);
  static const onSurfaceColor = Color(0xFF211F30);
  static const errorColor = Color(0xFFF44336);
  static const onErrorColor = Color(0xFFFFFFFF);
  static const highEmphosized = Color.fromARGB(255, 7, 7, 7);
  static const mediumEmphosized = Color(0xFFBBBBBB);
}
