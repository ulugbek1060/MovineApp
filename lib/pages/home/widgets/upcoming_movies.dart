import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/pages/home/bloc/home_bloc.dart';
import 'package:movie_app/theme/app_colors.dart';
import 'package:movie_app/theme/app_typography.dart';

class UpcomingMovies extends StatefulWidget {
  const UpcomingMovies({super.key});

  @override
  State<UpcomingMovies> createState() => _UpcomingMoviesState();
}

class _UpcomingMoviesState extends State<UpcomingMovies> {
  late PageController _pageController;

  @override
  void initState() {
    _pageController = PageController(initialPage: 0);
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, homeState) {
        final state = homeState.upcomingState;
        if (state.isLoading) {
          return Center(
            child: CircularProgressIndicator(
              color: Theme.of(context).colorScheme.secondary,
            ),
          );
        }
        if (state.error != null) {
          return Center(
            child: Text(state.error.toString()),
          );
        }
        final movies = state.upcomingMovies;
        return PageView.builder(
          controller: _pageController,
          itemCount: movies.length,
          itemBuilder: (context, index) {
            final movie = movies[index];
            return _MovieCardItem(
              onPressed: () {},
              onBookmarkPressed: () {},
              title: movie.title,
              posterPath: movie.posterPath,
              rating: movie.rate,
            );
          },
        );
      },
    );
  }
}

class _MovieCardItem extends StatelessWidget {
  final void Function() onPressed;
  final void Function() onBookmarkPressed;
  final String title;
  final String posterPath;
  final String rating;

  const _MovieCardItem({
    Key? key,
    required this.title,
    required this.rating,
    required this.posterPath,
    required this.onPressed,
    required this.onBookmarkPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
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
          Container(
            height: double.infinity,
            width: double.infinity,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomLeft,
                  colors: [Colors.transparent, AppColors.primaryColor]),
            ),
          ),
          Container(
            margin: const EdgeInsets.all(20),
            height: double.infinity,
            width: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: AppTypography.titleLarge,
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    ElevatedButton.icon(
                      onPressed: () {},
                      icon: const Icon(Icons.play_circle),
                      label: const Text('Play'),
                      style: ElevatedButton.styleFrom(padding: EdgeInsets.zero),
                    ),
                    const SizedBox(width: 12),
                    OutlinedButton.icon(
                      onPressed: onBookmarkPressed,
                      icon: const Icon(Icons.add,
                          color: AppColors.onPrimaryColor),
                      label:
                          const Text('My List', style: AppTypography.bodyText1),
                    )
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
