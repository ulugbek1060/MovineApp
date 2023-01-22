import 'package:flutter/material.dart';
import 'package:movie_app/theme/app_icons.dart';
import 'dart:math' as math;

import 'package:movie_app/widgets/movie_page_card.dart';

class HomeBottomSlider extends StatelessWidget {
  final double height;
  final double width;
  final PageController controller;
  final List<String> contents;
  final void Function() onTap;

  const HomeBottomSlider({
    required this.height,
    required this.width,
    required this.contents,
    required this.controller,
    required this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: height,
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: AspectRatio(
        aspectRatio: 0.85,
        child: PageView.builder(
          controller: controller,
          itemCount: contents.length,
          itemBuilder: (context, index) {
            return AnimatedBuilder(
              animation: controller,
              builder: (_, child) {
                double value = 0.0;
                if (controller.position.hasContentDimensions) {
                  var page = controller.page ?? 1;
                  value = index.toDouble() - page;
                  value = (value * 0.038).clamp(-1, 1);
                }
                return Transform.rotate(
                  angle: math.pi * value,
                  child: MoviePageCard(
                    name: 'Star Wars: The Last Jedi',
                    imageUrl: AppIcons.onBoardingImage,
                    rating: '7',
                    width: width,
                    height: height,
                    onTap: onTap,
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
