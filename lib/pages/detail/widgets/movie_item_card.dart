import 'package:flutter/material.dart';
import 'package:movies_data/movies_data.dart';

class MovieItemCard extends StatelessWidget {
  final MovieItem movieItem;
  final void Function() onTap;

  const MovieItemCard({
    Key? key,
    required this.movieItem,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage(movieItem.posterPath),
            fit: BoxFit.cover,
          ),
          borderRadius: const BorderRadius.all(
            Radius.circular(12),
          ),
        ),
      ),
    );
  }
}
