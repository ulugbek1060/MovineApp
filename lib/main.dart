import 'package:flutter/material.dart';
import 'package:movie_app/bootstrap.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  bootstrap(
    sharedPref: await SharedPreferences.getInstance(),
  );
}
