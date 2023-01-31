import 'package:flutter/material.dart';
import 'package:movie_app/pages/detail/detail_screen.dart';
import 'package:movie_app/utils/strings.dart';
import 'package:movie_app/widgets/home_bottom_slider.dart';
import 'package:movie_app/theme/app_typography.dart';
import 'package:movie_app/widgets/home_top_movies.dart';

class HomeWidget extends StatefulWidget {
  const HomeWidget({super.key});

  @override
  State<HomeWidget> createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<HomeWidget> {
  late PageController _bottomPageController;

  @override
  void initState() {
    _bottomPageController = PageController(
      // small partition left and right
      viewportFraction: 0.7,
      initialPage: 1,
    );
    super.initState();
  }

  @override
  void dispose() {
    _bottomPageController.dispose();
    super.dispose();
  }

  final Map<int, String> contents = {
    12: 'assets/images/on-boarding.png',
    11: 'assets/images/on-boarding.png',
    10: 'assets/images/on-boarding.png',
    8: 'assets/images/on-boarding.png',
    9: 'assets/images/on-boarding.png',
    6: 'assets/images/on-boarding.png',
  };

  void _onMoveTapped() {
    Navigator.of(context).pushNamed(DetailScreen.routeName);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final mediaQuery = MediaQuery.of(context);
    final width = mediaQuery.size.width;
    final height = mediaQuery.size.height - mediaQuery.padding.top - 70;
    return Container(
      color: theme.colorScheme.background,
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
                topMovies,
                style: AppTypography.titleLarge,
              ),
            ),

            // height = 0.97 -> 0.67
            HomeTopMoviesList(
              height: height * 0.3,
              width: double.infinity,
              onTap: _onMoveTapped,
            ),

            // height = 0.67 -> 0.64
            Container(
              margin: EdgeInsets.symmetric(
                horizontal: width * 0.05,
                vertical: height * 0.03,
              ),
              child: const Text(
                'Trending',
                style: AppTypography.titleLarge,
              ),
            ),

            // height = 0.64 -> 0.14
            HomeBottomSlider(
              height: height * 0.5,
              width: width * 0.1,
              controller: _bottomPageController,
              contents: contents.values.toList(),
              onTap: _onMoveTapped,
            ),
          ],
        ),
      ),
    );
  }
}
