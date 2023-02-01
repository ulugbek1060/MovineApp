import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:movie_app/pages/detail/widgets/similar_movies_widget.dart';
import 'package:movie_app/theme/app_colors.dart';
import 'package:movie_app/theme/app_shape.dart';
import 'package:movie_app/theme/app_typography.dart';
import 'package:movies_data/movies_data.dart';
import 'package:readmore/readmore.dart';
import 'package:solid_bottom_sheet/solid_bottom_sheet.dart';

class BottomSheetWidget extends StatelessWidget {
  final double height;
  final double width;
  final MovieDetail movie;
  final SolidController controller;

  const BottomSheetWidget({
    Key? key,
    required this.height,
    required this.width,
    required this.movie,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SolidBottomSheet(
      maxHeight: height * 0.3,
      controller: controller,
      draggableBody: true,
      headerBar: Container(
        color: Theme.of(context).primaryColor,
        height: height * 0.4,
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // video name and quality
            _titleAndQuality(
              title: movie.title,
              quality: movie.quality,
            ),

            const SizedBox(height: 10),
            // video time and rating on imdb
            _timeAndRating(
              time: movie.duration,
              rating: movie.rating,
            ),

            const SizedBox(height: 10),
            Divider(color: Colors.white.withAlpha(15)),

            _releaseDateAndGenre(
              genres: movie.genres,
              releaseDate: movie.releaseData,
              width: width,
            ),

            const SizedBox(height: 10),
            Divider(color: Colors.white.withAlpha(15)),

            const SizedBox(height: 10),

            Expanded(
              child: ReadMoreText(
                movie.overview,
                style: AppTypography.bodyText2.copyWith(
                  fontSize: 14,
                ),
                trimLines: 2,
                trimCollapsedText: 'Read more...',
                trimExpandedText: 'Show less',
                trimMode: TrimMode.Line,
                moreStyle: AppTypography.bodyText1.copyWith(
                  fontWeight: FontWeight.w500,
                  fontSize: 14,
                ),
              ),
            ),
          ],
        ),
      ),
      body: SimilarMoviesWidget(height: height * 0.3),
    );
  }

  Widget _timeAndRating({
    required String time,
    required String rating,
  }) {
    return Row(
      children: [
        SvgPicture.asset('assets/images/ic-time.svg'),
        const SizedBox(width: 10),
        Text(
          '$time minutes',
          style: AppTypography.bodyText2,
        ),
        const SizedBox(width: 10),
        SvgPicture.asset('assets/images/ic-star.svg'),
        const SizedBox(width: 10),
        Text(
          '$rating (IMDb)',
          style: AppTypography.bodyText2,
        ),
      ],
    );
  }

  Widget _titleAndQuality({
    required String title,
    required String quality,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Flexible(
          child: Text(
            title,
            style: AppTypography.headline2.copyWith(
              fontWeight: FontWeight.w500,
            ),
            overflow: TextOverflow.fade,
          ),
        ),
        const SizedBox(width: 12),
        Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 8,
            vertical: 4,
          ),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.white.withAlpha(20)),
            borderRadius: BorderRadius.circular(5),
            gradient: AppColors.gradient,
          ),
          child: Text(
            quality,
            style: AppTypography.bodyText2,
          ),
        )
      ],
    );
  }

  Widget _releaseDateAndGenre({
    required List<String> genres,
    String releaseDate = '',
    required double width,
  }) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Release Date section
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Release date: ',
                style: AppTypography.bodyText1.copyWith(
                  fontWeight: FontWeight.w500,
                  fontSize: 16,
                ),
              ),
              const SizedBox(width: 5),
              Expanded(
                child: Text(
                  releaseDate,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                  style: AppTypography.bodyText2.copyWith(
                    fontSize: 14,
                  ),
                ),
              )
            ],
          ),

          const SizedBox(height: 5),

          // Genre section
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Genre',
                style: AppTypography.bodyText1.copyWith(
                  fontWeight: FontWeight.w500,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 8),
              SizedBox(
                width: width,
                child: Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  runAlignment: WrapAlignment.end,
                  children: genres
                      .map(
                        (text) => Container(
                          // margin: const EdgeInsets.only(top: 4, right: 8),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.white.withAlpha(20),
                            ),
                            borderRadius:
                                BorderRadius.circular(AppShape.normalShaper),
                            gradient: AppColors.gradient,
                          ),
                          child: Text(
                            text,
                            style: AppTypography.bodyText1,
                          ),
                        ),
                      )
                      .toList(),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
