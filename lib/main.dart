import 'package:flutter/material.dart';
import 'package:movie_app/screens/detail_screen.dart';
import 'package:movie_app/screens/home_screen.dart';
import 'package:movie_app/screens/main_screen.dart';
import 'package:movie_app/screens/on_boarding_widget.dart';
import 'package:movie_app/screens/splash_screen.dart';
import 'package:movie_app/theme/app_theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: AppTheme.themeData,
      debugShowCheckedModeBanner: false,
      home: const MainScreen(),
      routes: {
        DetailScreen.routeName: (_) => const DetailScreen(),
      },
    );
  }
}
