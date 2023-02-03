import 'package:flutter/material.dart';
import 'package:movies_data/movies_data.dart';

import 'movies_grid_list.dart';

class MoviesPageView extends StatelessWidget {
  final List<MovieType> types;

  const MoviesPageView({
    Key? key,
    required this.types,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TabBarView(
      children: types.map((type) => MoviesGridView(type: type)).toList(),
    );
  }
}
