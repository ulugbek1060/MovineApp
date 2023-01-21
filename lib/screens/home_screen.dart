import 'package:flutter/material.dart';
import 'package:movie_app/screens/detail_screen.dart';
import 'package:movie_app/screens/movie_card.dart';
import 'package:movie_app/theme/app_typography.dart';
import 'dart:math' as math;

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
                'Top Movies Everywhere',
                style: AppTypography.titleLarge,
              ),
            ),

            // height = 0.97 -> 0.67
            SizedBox(
              height: height * 0.3,
              width: double.infinity,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: contents.length,
                itemBuilder: (context, index) {
                  return MovieCard(
                    onTap: _onMoveTapped,
                    contentImae: contents.values.elementAt(index),
                    movieName: 'Star Wars: The Last Jedi',
                    movieId: contents.keys.elementAt(index),
                  );
                },
              ),
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
            SizedBox(
              width: double.infinity,
              child: _buildBottomSlider(
                height: height * 0.5,
                width: width * 0.1,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBottomSlider({
    required double height,
    required double width,
  }) {
    return Container(
      height: height,
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: AspectRatio(
        aspectRatio: 0.85,
        child: PageView.builder(
          controller: _bottomPageController,
          itemCount: contents.length,
          itemBuilder: (context, index) {
            return AnimatedBuilder(
              animation: _bottomPageController,
              builder: (_, child) {
                double value = 0.0;
                if (_bottomPageController.position.hasContentDimensions) {
                  var page = _bottomPageController.page ?? 1;
                  value = index.toDouble() - page;
                  value = (value * 0.038).clamp(-1, 1);
                }
                return Transform.rotate(
                  angle: math.pi * value,
                  child: MovieCard(
                    padding: 16,
                    width: width,
                    onTap: _onMoveTapped,
                    contentImae: contents.values.elementAt(index),
                    movieName: 'Star Wars: The Last Jedi',
                    movieId: contents.keys.elementAt(index),
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
