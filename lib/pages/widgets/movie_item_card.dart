import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/theme/app_typography.dart';

class MovieItemCard extends StatelessWidget {
  const MovieItemCard(
      {Key? key,
      required this.posterPath,
      required this.title,
      required this.rate,
      required this.onPressed})
      : super(key: key);

  final String posterPath;
  final String title;
  final String rate;
  final void Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: ClipRRect(
        borderRadius: const BorderRadius.all(Radius.circular(10)),
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
              margin: const EdgeInsets.all(6.0),
              child: Container(
                padding: const EdgeInsets.all(4.0),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.0),
                    color: Theme.of(context).colorScheme.secondary),
                child: Text(rate, style: AppTypography.labelSmall),
              ),
            )
          ],
        ),
      ),
    );
  }
}
