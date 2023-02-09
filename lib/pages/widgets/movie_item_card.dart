import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

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
          ],
        ),
      ),
    );
  }
}
