import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:bloc/bloc.dart';
import 'package:hive/hive.dart';
import 'package:movie_app/app/app.dart';
import 'package:movie_app/app/app_bloc_observer.dart';
import 'package:shared_preferences/shared_preferences.dart';

void bootstrap({
  required SharedPreferences sharedPref,
  required BoxCollection boxCollection,
}) {
  FlutterError.onError = (details) {
    log(details.exceptionAsString(), stackTrace: details.stack);
  };
  Bloc.observer = AppBlocObserver();

  runZonedGuarded(
    () => runApp(App(sharedPref: sharedPref, boxCollection: boxCollection)),
    (error, stackTrace) => log(error.toString(), stackTrace: stackTrace),
  );
}
