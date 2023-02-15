import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:movie_app/theme/app_typography.dart';
import 'package:movie_app/utils/strings.dart';

typedef OnRetry = void Function();

class ErrorView extends StatelessWidget {
  const ErrorView({Key? key, this.message, this.onRetry}) : super(key: key);

  final String? message;
  final OnRetry? onRetry;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(IconlyBold.document,
              size: 100, color: Theme.of(context).colorScheme.onSurface),
          Text(message ?? errorMessage, style: AppTypography.titleLarge),
          ElevatedButton(onPressed: onRetry, child: const Text(tryAgain))
        ],
      ),
    );
  }
}
