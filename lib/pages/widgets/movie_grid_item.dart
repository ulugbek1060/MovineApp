import 'package:flutter/material.dart';
import 'package:movie_app/theme/app_typography.dart';
import 'package:movies_data/movies_data.dart';

class MovieGridItem extends StatelessWidget {
  final MovieItem movie;
  final Function() onTap;

  const MovieGridItem({
    Key? key,
    required this.movie,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: NetworkImage(movie.posterPath),
          fit: BoxFit.cover,
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: InkWell(
        onTap: onTap,
        child: _posterTitle(movie.title),
      ),
    );
  }

  Widget _posterTitle(String title) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          width: double.infinity,
          decoration: BoxDecoration(
              color: Colors.black.withAlpha(150),
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20),
              )),
          child: Text(
            title,
            style: AppTypography.bodyText1,
            textAlign: TextAlign.center,
          ),
        )
      ],
    );
  }
}
