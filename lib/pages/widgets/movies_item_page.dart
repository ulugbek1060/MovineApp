import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/theme/app_colors.dart';
import 'package:movie_app/theme/app_typography.dart';

class MovieItemPage extends StatelessWidget {
  final void Function() onPressed;
  final void Function() onBookmarkPressed;
  final String title;
  final String posterPath;
  final String rating;

  const MovieItemPage({
    Key? key,
    required this.title,
    required this.rating,
    required this.posterPath,
    required this.onPressed,
    required this.onBookmarkPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Stack(
        children: [
          SizedBox(
            height: double.infinity,
            width: double.infinity,
            child: CachedNetworkImage(
              imageUrl: posterPath,
              placeholder: (context, url) => Center(
                  child: CircularProgressIndicator(
                color: Theme.of(context).colorScheme.secondary,
              )),
              errorWidget: (context, url, error) => const Icon(Icons.error),
              fit: BoxFit.cover,
            ),
          ),
          Container(
            height: double.infinity,
            width: double.infinity,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomLeft,
                  colors: [Colors.transparent, AppColors.primaryColor]),
            ),
          ),
          Container(
            margin: const EdgeInsets.all(20),
            height: double.infinity,
            width: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: AppTypography.titleLarge,
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    ElevatedButton.icon(
                      onPressed: () {},
                      icon: const Icon(Icons.play_circle),
                      label: const Text('Play'),
                      style: ElevatedButton.styleFrom(padding: EdgeInsets.zero),
                    ),
                    const SizedBox(width: 12),
                    OutlinedButton.icon(
                      onPressed: onBookmarkPressed,
                      icon: const Icon(Icons.add,
                          color: AppColors.onPrimaryColor),
                      label:
                          const Text('My List', style: AppTypography.bodyText1),
                    )
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
