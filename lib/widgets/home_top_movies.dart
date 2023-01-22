import 'package:flutter/material.dart';
import 'package:movie_app/widgets/movie_list_card.dart';

class HomeTopMoviesList extends StatelessWidget {
  final double height;
  final double width;
  final void Function() onTap;

  final Map<int, String> contents = {
    12: 'assets/images/on-boarding.png',
    11: 'assets/images/on-boarding.png',
    10: 'assets/images/on-boarding.png',
    8: 'assets/images/on-boarding.png',
    9: 'assets/images/on-boarding.png',
    6: 'assets/images/on-boarding.png',
  };

  HomeTopMoviesList({
    required this.height,
    required this.width,
    required this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: double.infinity,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: contents.length,
        itemBuilder: (context, index) {
          return MovieListCard(
            onTap: onTap,
            contentImage: contents.values.elementAt(index),
            movieName: 'Star Wars: The Last Jedi',
            movieId: contents.keys.elementAt(index),
          );
        },
      ),
    );
  }
}
