import 'package:flutter/material.dart';
import 'package:movie_app/screens/movie_card.dart';

class MoviesListWidget extends StatelessWidget {
  const MoviesListWidget({
    required this.moviesType,
    super.key,
  });
  final String moviesType;

  @override
  Widget build(BuildContext context) {
    final dummyList = [
      MovieCard(
        onTap: () {},
        contentImae: 'assets/images/on-boarding.png',
        movieName: 'Knives Out (2019)',
        movieId: 12,
      ),
      MovieCard(
        onTap: () {},
        contentImae: 'assets/images/on-boarding.png',
        movieName: 'Knives Out (2019)',
        movieId: 12,
      ),
      MovieCard(
        onTap: () {},
        contentImae: 'assets/images/on-boarding.png',
        movieName: 'Knives Out (2019)',
        movieId: 12,
      ),
      MovieCard(
        onTap: () {},
        contentImae: 'assets/images/on-boarding.png',
        movieName: 'Knives Out (2019)',
        movieId: 12,
      ),
      MovieCard(
        onTap: () {},
        contentImae: 'assets/images/on-boarding.png',
        movieName: 'Knives Out (2019)',
        movieId: 12,
      ),
      MovieCard(
        onTap: () {},
        contentImae: 'assets/images/on-boarding.png',
        movieName: 'Knives Out (2019)',
        movieId: 12,
      ),
      MovieCard(
        onTap: () {},
        contentImae: 'assets/images/on-boarding.png',
        movieName: 'Knives Out (2019)',
        movieId: 12,
      ),
      MovieCard(
        onTap: () {},
        contentImae: 'assets/images/on-boarding.png',
        movieName: 'Knives Out (2019)',
        movieId: 12,
      ),
      MovieCard(
        onTap: () {},
        contentImae: 'assets/images/on-boarding.png',
        movieName: 'Knives Out (2019)',
        movieId: 12,
      ),
      MovieCard(
        onTap: () {},
        contentImae: 'assets/images/on-boarding.png',
        movieName: 'Knives Out (2019)',
        movieId: 12,
      ),
      MovieCard(
        onTap: () {},
        contentImae: 'assets/images/on-boarding.png',
        movieName: 'Star Wars: The Last Jedi',
        movieId: 12,
      ),
      MovieCard(
        onTap: () {},
        contentImae: 'assets/images/on-boarding.png',
        movieName: 'Star Wars: The Last Jedi',
        movieId: 12,
      ),
    ];
    return SizedBox(
      width: double.infinity,
      height: double.infinity,
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
        ),
        itemCount: dummyList.length,
        itemBuilder: (_, index) {
          return dummyList[index];
        },
      ),
    );
  }
}
