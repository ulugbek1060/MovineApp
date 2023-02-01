import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:movie_app/pages/home/widgets/movie_list_card.dart';
import 'package:movie_app/utils/strings.dart';
import 'package:movie_app/theme/app_colors.dart';
import 'package:movie_app/theme/app_shape.dart';
import 'package:movie_app/theme/app_typography.dart';
import 'package:readmore/readmore.dart';
import 'package:solid_bottom_sheet/solid_bottom_sheet.dart';

class DetailScreen extends StatefulWidget {
  static const routeName = '/detail-screen';

  const DetailScreen({super.key});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  late SolidController _controller;

  @override
  void initState() {
    super.initState();
    _controller = SolidController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  final List<String> gente = [
    "Animation",
    "Action",
    "Adventure",
    "Comedy",
    "Family",
    "Fantasy"
  ];

  final Map<int, String> contents = {
    12: 'assets/images/on-boarding.png',
    11: 'assets/images/on-boarding.png',
    10: 'assets/images/on-boarding.png',
    8: 'assets/images/on-boarding.png',
    9: 'assets/images/on-boarding.png',
    6: 'assets/images/on-boarding.png',
  };

  /*
              ----------------------- + 0.1
            + ----------------------- +
            | |                     | |
    I       | |                     | | 
    F       | |                     | | 0.3 Movie Image 
            | |                     | |
    E       | |                     | |
    X       | |                     | +
    P  0.6  | |                     | +
    A       | |                     | |
    N       | |                     | | 
    D       | |                     | | 0.4 BottomSheet Header Section
    E       | |                     | |
    D       | |                     | |
            + |                     | +
            | |                     | +
            | |                     | |
            | |                     | |
      0.4   | |                     | | 0.3  BottomSheet Body Section
            | |                     | |
            | |                     | |
            | |                     | |
            + ----------------------- +
  */

  void _onMoveTapped() {
    Navigator.of(context).pushNamed(DetailScreen.routeName);
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      // Main background of screen with movie image with animation
      body: Stack(children: [
        StreamBuilder<double>(
          stream: _controller.heightStream,
          initialData: 0.0,
          builder: (_, snapshot) {
            return AnimatedContainer(
              curve: Curves.easeOut,
              duration: const Duration(milliseconds: 100),
              height: height * 0.65 - snapshot.data!,
              width: double.infinity,
              child: Image.asset(
                'assets/images/on-boarding.png',
                fit: BoxFit.cover,
              ),
            );
          },
        ),
        Positioned(
          top: 30,
          left: 16,
          child: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
          ),
        )
      ]),

      // Bottom sheet with some information
      bottomSheet: SolidBottomSheet(
        maxHeight: height * 0.3, //bottomSheetBody MaxHeight
        controller: _controller,
        draggableBody: true,
        headerBar: Container(
          color: Theme.of(context).primaryColor,
          height: height * 0.4,
          child: Container(
            margin: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // video name and quality
                _nameAndQuality(
                  name: "Star Wars: The Last Jedi",
                  quality: '4k',
                ),

                const SizedBox(height: 10),
                // video time and rating on imdb
                _timeAndRating(
                  time: '152',
                  rating: '7',
                ),

                const SizedBox(height: 10),
                Divider(color: Colors.white.withAlpha(15)),

                _releaseDateAndGenre(
                  genre: gente,
                  releaseDate: 'December 9, 2017',
                  width: width,
                ),

                const SizedBox(height: 10),
                Divider(color: Colors.white.withAlpha(15)),

                const SizedBox(height: 10),

                Expanded(
                  child: ReadMoreText(
                    content,
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
        ),

        // bottomsheet body movies list depnd on type of movies
        body: _moviesRelatedCurrentMovie(
          height: height * 0.3, // contents height
          movies: contents.values.toList(),
        ),
      ),
    );
  }

  Widget _moviesRelatedCurrentMovie({
    required double height,
    required List<String> movies,
  }) {
    final contentHeight = height;
    final contentWidth = height * 0.6;

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16),
      color: Theme.of(context).primaryColor,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: contents.length,
        itemBuilder: (_, index) {
          return MovieListCard(
            height: contentHeight,
            width: contentWidth,
            movieId: '12',
            movieName: movies.elementAt(index),
            onTap: _onMoveTapped,
            contentImage: movies.elementAt(index),
          );
        },
      ),
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

  Widget _nameAndQuality({
    required String name,
    required String quality,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          name,
          style: AppTypography.headline2.copyWith(
            fontWeight: FontWeight.w500,
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
    required List<String> genre,
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
                'Relese date: ',
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
                child: _genreListWidget(genre),
              )
            ],
          ),
        ],
      ),
    );
  }

  Widget _genreListWidget(List<String> genre) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      runAlignment: WrapAlignment.end,
      children: genre
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
                borderRadius: BorderRadius.circular(AppShape.normalShaper),
                gradient: AppColors.gradient,
              ),
              child: Text(
                text,
                style: AppTypography.bodyText1,
              ),
            ),
          )
          .toList(),
    );
  }
}
