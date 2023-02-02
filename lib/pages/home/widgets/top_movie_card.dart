import 'package:flutter/material.dart';
import 'package:movies_data/movies_data.dart';

class TopMovieCard extends StatelessWidget {
  final double height;
  final double width;
  final MovieItem movieItem;
  final void Function() onTap;

  const TopMovieCard({
    Key? key,
    required this.width,
    required this.height,
    required this.movieItem,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: height,
        width: width,
        margin: const EdgeInsets.all(6),
        child: _cardItem(movieItem),
      ),
    );
  }

  Widget _cardItem(MovieItem movieItem) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: NetworkImage(movieItem.posterPath),
          fit: BoxFit.cover,
        ),
        borderRadius: const BorderRadius.all(
          Radius.circular(20),
        ),
      ),
    );
  }
}
