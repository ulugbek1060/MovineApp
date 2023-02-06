import 'package:flutter/material.dart';
import 'package:movie_app/pages/home/widgets/bottom_slider_widget.dart';
import 'package:movie_app/pages/home/widgets/top_slider_widget.dart';
import 'package:movie_app/theme/app_typography.dart';

class HomeWidget extends StatelessWidget {
  const HomeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final width = mediaQuery.size.width;
    final height = mediaQuery.size.height - mediaQuery.padding.top - 70;
    return Container(
      color:  Theme.of(context).colorScheme.background,
      width: double.infinity,
      height: double.infinity,
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // height = 1.0 -> 0.97
            Container(
              margin: EdgeInsets.symmetric(
                horizontal: width * 0.05,
                vertical: height * 0.03,
              ),
              child: const Text(
                'Now Playing',
                style: AppTypography.titleLarge,
              ),
            ),

            // height = 0.97 -> 0.77
            TopSlideWidget(
              height: height * 0.2,
              width: double.infinity,
            ),

            // height = 0.77 -> 0.64
            Container(
              margin: EdgeInsets.symmetric(
                horizontal: width * 0.05,
                vertical: height * 0.03,
              ),
              child: const Text(
                'Upcoming',
                style: AppTypography.titleLarge,
              ),
            ),

            // height = 0.74 -> 0.14
            BottomSliderWidget(
              height: height * 0.6,
              width: width * 0.1,
            ),
          ],
        ),
      ),
    );
  }
}
