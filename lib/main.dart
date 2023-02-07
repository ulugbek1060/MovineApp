import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:movie_app/bootstrap.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final sharedPrefs = await SharedPreferences.getInstance();

  final directory = await getApplicationDocumentsDirectory();

  final boxCollection = await BoxCollection.open(
    databaseName,
    {collectionFavorites},
    path: directory.path,
  );

  bootstrap(sharedPref: sharedPrefs, boxCollection: boxCollection);
}
