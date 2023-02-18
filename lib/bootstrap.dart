import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:movie_app/app/app.dart';
import 'package:shared_preferences/shared_preferences.dart';

void bootstrap({
  required SharedPreferences sharedPref,
  required BoxCollection boxCollection,
}) {
  // FlutterError.onError = (details) {
  //   log(details.exceptionAsString(), stackTrace: details.stack);
  // };
  // Bloc.observer = AppBlocObserver();
  runApp(App(sharedPref: sharedPref, boxCollection: boxCollection));
  // runZonedGuarded(
  //   () => ,
  //   (error, stackTrace) => log(error.toString(), stackTrace: stackTrace),
  // );
}
