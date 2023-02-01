import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/pages/home/bloc/movies_bloc.dart';
import 'package:movie_app/pages/home/widgets/movie_page_card.dart';
import 'package:movies_data/movies_data.dart';
import 'dart:math' as math;

class BottomSliderWidget extends StatefulWidget {
  final double height;
  final double width;

  const BottomSliderWidget({
    super.key,
    required this.height,
    required this.width,
  });

  @override
  State<BottomSliderWidget> createState() => _BottomSliderWidgetState();
}

class _BottomSliderWidgetState extends State<BottomSliderWidget> {
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

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => MoviesBloc(
        repository: RepositoryProvider.of<MoviesRepository>(context),
      )..add(const MovieFetchedEvent(movieType: MovieType.UPCOMING)),
      child: _SliderWidget(
        height: widget.height,
        width: widget.width,
        controller: _bottomPageController,
      ),
    );
  }
}

class _SliderWidget extends StatelessWidget {
  final double height;
  final double width;
  final PageController controller;

  const _SliderWidget({
    Key? key,
    required this.height,
    required this.width,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MoviesBloc, MoviesState>(
      listener: (context, state) {},
      builder: (context, state) {
        if (state.movies.isEmpty && !state.isLoading) {
          return SizedBox(
            height: height,
            width: double.infinity,
            child: const Center(
              child: Text('There is no movies'),
            ),
          );
        }
        if (state.isLoading) {
          return SizedBox(
            height: height,
            width: double.infinity,
            child: const Center(
              child: CircularProgressIndicator(),
            ),
          );
        }

        return Container(
          width: double.infinity,
          height: height,
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: AspectRatio(
            aspectRatio: 0.85,
            child: PageView.builder(
              controller: controller,
              itemCount: state.movies.length,
              itemBuilder: (context, index) {
                final movie = state.movies[index];
                return _pageItemBuilder(context, index, movie, controller);
              },
            ),
          ),
        );
      },
    );
  }

  Widget _pageItemBuilder(BuildContext context, int index, MovieItem movie, controller) {
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
            movieItem:movie,
            width: width,
            height: height,
            onTap: () {},
          ),
        );
      },
    );
  }
}
