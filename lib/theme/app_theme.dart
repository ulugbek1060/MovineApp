import 'package:flutter/material.dart';
import 'package:movie_app/theme/app_colors.dart';

class AppTheme {
//   ElevatedButton(
//   style: ElevatedButton.styleFrom(
//     primary: Colors.red, // background
//     onPrimary: Colors.white, // foreground
//   ),
//   onPressed: () { },
//   child: Text('ElevatedButton with custom foreground/background'),
// )
  static final flatButtonStyle = TextButton.styleFrom(
    padding: const EdgeInsets.symmetric(horizontal: 16.0),
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(2.0)),
    ),
  );

  static final raisedButtonStyle = ElevatedButton.styleFrom(
    backgroundColor: AppColors.secondaryColor,
    minimumSize: const Size(88, 36),
    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(20)),
    ),
  );

  static final outlineButtonStyle = OutlinedButton.styleFrom(
    padding: const EdgeInsets.symmetric(horizontal: 16),
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(2)),
    ),
  );

  static final themeData = ThemeData(
    primarySwatch: AppColors.primarySwatch,
    fontFamily: 'Urbanist',
    colorScheme: const ColorScheme(
      brightness: Brightness.light,
      primary: AppColors.primaryColor,
      onPrimary: AppColors.onPrimaryColor,
      secondary: AppColors.secondaryColor,
      onSecondary: AppColors.onSecondaryColor,
      background: AppColors.backgroundColor,
      onBackground: AppColors.onBackgroundColor,
      error: AppColors.errorColor,
      onError: AppColors.onErrorColor,
      surface: AppColors.surfaceColor,
      onSurface: AppColors.onSurfaceColor,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(style: raisedButtonStyle),
    textButtonTheme: TextButtonThemeData(style: flatButtonStyle),
    outlinedButtonTheme: OutlinedButtonThemeData(style: outlineButtonStyle),
  );
}
