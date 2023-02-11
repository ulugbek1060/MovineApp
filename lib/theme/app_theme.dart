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
    side: const BorderSide(color: AppColors.onPrimaryColor, width: 2),
    padding: const EdgeInsets.symmetric(horizontal: 16),
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(20)),
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
    bottomSheetTheme: BottomSheetThemeData(
        backgroundColor: Colors.black.withOpacity(0)),
  );
}



//  static void configure(ThemeName themeName) {
//     _themeName = themeName;
//   }
//
//   ThemeData get appTheme {
//     switch (_themeName) {
//       case ThemeName.DARK:
//         return _buildDarkTheme();
//       default: // Flavor.PRO:
//         return _buildLightTheme();
//     }
//   }

// ThemeData _buildDarkTheme() {
//     const Color primaryColor = const Color(0xFF3B3B48);
//     final ThemeData base = new ThemeData.dark();
//     return base.copyWith(
//       primaryColor: primaryColor,
//       buttonColor: primaryColor,
//       indicatorColor: const Color(0xFF3F3F4C),
//       accentColor: Colors.blueAccent,
//       canvasColor: const Color(0xFF2B2B2B),
//       scaffoldBackgroundColor: const Color(0xFF2E2E3B),
//       backgroundColor: const Color(0xFF2E2E3B),
//       errorColor: const Color(0xFFB00020),
//       buttonTheme: const ButtonThemeData(
//         textTheme: ButtonTextTheme.primary,
//       ),
//       textTheme: _buildTextTheme(base.textTheme),
//       primaryTextTheme: _buildTextTheme(base.primaryTextTheme),
//       accentTextTheme: _buildTextTheme(base.accentTextTheme),
//     );
//   }
