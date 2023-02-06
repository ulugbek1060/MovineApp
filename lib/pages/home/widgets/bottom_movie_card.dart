import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:movie_app/theme/app_typography.dart';
import 'package:movies_data/movies_data.dart';

class MoviePageCard extends StatelessWidget {
  final MovieItem movieItem;
  final double width;
  final double height;
  final void Function() onTap;

  const MoviePageCard({
    required this.movieItem,
    required this.width,
    required this.height,
    required this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: height,
        width: width,
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage(movieItem.posterPath),
            fit: BoxFit.cover,
          ),
          borderRadius: const BorderRadius.all(Radius.circular(20)),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            _ratingText(movieItem.rate),
            _bottomTitle(movieItem.title),
          ],
        ),
      ),
    );
  }

  Widget _ratingText(String rating) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.black.withAlpha(150),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(IconlyBold.star, color: Colors.amber),
          const SizedBox(width: 5),
          Text(
            rating,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style:
                AppTypography.labelLarge.copyWith(fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }

  Widget _bottomTitle(String title) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
      decoration: BoxDecoration(
        color: Colors.black.withAlpha(150),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        title,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
        style: AppTypography.labelLarge.copyWith(fontWeight: FontWeight.w500),
      ),
    );
  }
}
