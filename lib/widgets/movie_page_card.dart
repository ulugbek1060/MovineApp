import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:movie_app/theme/app_icons.dart';
import 'package:movie_app/theme/app_typography.dart';
import 'package:movie_app/widgets/custom_blur_widget.dart';

class MoviePageCard extends StatelessWidget {
  final String name;
  final String imageUrl;
  final String rating;
  final double width;
  final double height;
  final void Function() onTap;

  const MoviePageCard({
    required this.name,
    required this.imageUrl,
    required this.rating,
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
        padding: const EdgeInsets.all(8),
        width: width,
        height: height,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Stack(
            children: [
              Positioned(
                left: 0,
                top: 0,
                bottom: 0,
                right: 0,
                child: Image.asset(
                  AppIcons.onBoardingImage,
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(
                left: 0,
                right: 0,
                bottom: 0,
                child: CustomBluerWidget(
                  child: Text(
                    name,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: AppTypography.labelLarge
                        .copyWith(fontWeight: FontWeight.w500),
                  ),
                ),
              ),
              Positioned(
                top: 8,
                right: 8,
                child: CustomBluerWidget(
                  padding: 4,
                  child: Row(
                    children: [
                      SvgPicture.asset(
                        width: 18.0,
                        AppIcons.star,
                        color: Colors.amber,
                      ),
                      const SizedBox(width: 5),
                      Text(
                        rating,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: AppTypography.labelLarge
                            .copyWith(fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
