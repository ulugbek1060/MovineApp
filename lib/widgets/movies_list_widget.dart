import 'package:flutter/material.dart';
import 'package:movie_app/widgets/movie_list_card.dart';

class MoviesListWidget extends StatelessWidget {
  const MoviesListWidget({
    required this.moviesType,
    super.key,
  });
  final String moviesType;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final dummyList = [
      MovieListCard(
        onTap: () {},
        contentImage: 'assets/images/on-boarding.png',
        movieName: 'Knives Out (2019)',
        movieId: 12,
      ),
      MovieListCard(
        onTap: () {},
        contentImage: 'assets/images/on-boarding.png',
        movieName: 'Knives Out (2019)',
        movieId: 12,
      ),
      MovieListCard(
        onTap: () {},
        contentImage: 'assets/images/on-boarding.png',
        movieName: 'Knives Out (2019)',
        movieId: 12,
      ),
      MovieListCard(
        onTap: () {},
        contentImage: 'assets/images/on-boarding.png',
        movieName: 'Knives Out (2019)',
        movieId: 12,
      ),
      MovieListCard(
        onTap: () {},
        contentImage: 'assets/images/on-boarding.png',
        movieName: 'Knives Out (2019)',
        movieId: 12,
      ),
      MovieListCard(
        onTap: () {},
        contentImage: 'assets/images/on-boarding.png',
        movieName: 'Knives Out (2019)',
        movieId: 12,
      ),
      MovieListCard(
        onTap: () {},
        contentImage: 'assets/images/on-boarding.png',
        movieName: 'Knives Out (2019)',
        movieId: 12,
      ),
      MovieListCard(
        onTap: () {},
        contentImage: 'assets/images/on-boarding.png',
        movieName: 'Knives Out (2019)',
        movieId: 12,
      ),
      MovieListCard(
        onTap: () {},
        contentImage: 'assets/images/on-boarding.png',
        movieName: 'Knives Out (2019)',
        movieId: 12,
      ),
      MovieListCard(
        onTap: () {},
        contentImage: 'assets/images/on-boarding.png',
        movieName: 'Knives Out (2019)',
        movieId: 12,
      ),
      MovieListCard(
        onTap: () {},
        contentImage: 'assets/images/on-boarding.png',
        movieName: 'Star Wars: The Last Jedi',
        movieId: 12,
      ),
      MovieListCard(
        onTap: () {},
        contentImage: 'assets/images/on-boarding.png',
        movieName: 'Star Wars: The Last Jedi',
        movieId: 12,
      ),
    ];
    return SizedBox(
      width: double.infinity,
      height: double.infinity,
      child: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: width > 400 ? 3 : 2,
        ),
        itemCount: dummyList.length,
        itemBuilder: (_, index) {
          return dummyList[index];
        },
      ),
    );
  }
}
