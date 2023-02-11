import 'dart:async';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:movie_app/bootstrap.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

const databaseName = 'movies.db';
const collectionFavorites = 'favorites.box';
const collectionGenres = 'genres.box';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final sharedPrefs = await SharedPreferences.getInstance();

  final directory = await getApplicationDocumentsDirectory();

  final boxCollection = await BoxCollection.open(
    databaseName,
    {collectionFavorites, collectionGenres},
    path: directory.path,
  );

  bootstrap(sharedPref: sharedPrefs, boxCollection: boxCollection);
}
