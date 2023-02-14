import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/pages/detail/detail_page.dart';
import 'package:movie_app/pages/home/bloc/home_bloc.dart';
import 'package:movie_app/pages/widgets/movies_item_page.dart';
import 'package:movie_app/theme/app_typography.dart';
import 'package:movie_app/utils/status.dart';
import 'package:movies_data/movies_data.dart';

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
        buildWhen: (prev, current) =>
            prev.upcomingState != current.upcomingState,
        builder: (context, homeState) {
          return _buildComponents(homeState.upcomingState);
        });
  }

  Widget _buildComponents(UpcomingMoviesState state) {
    switch (state.status) {
      case Status.success:
        return _MoviesView(
            movies: state.movies, pageController: _pageController);
      case Status.pending:
        return const _PendingView();
      case Status.error:
        return _ErrorView(error: state.error);
      case Status.empty:
        return Container();
    }
  }
}

class _ErrorView extends StatelessWidget {
  const _ErrorView({Key? key, required this.error}) : super(key: key);
  final Object? error;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(error?.toString() ?? 'Something went wrong!',
          style: AppTypography.titleLarge),
    );
  }
}

class _PendingView extends StatelessWidget {
  const _PendingView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(
        color: Theme.of(context).colorScheme.secondary,
      ),
    );
  }
}

class _MoviesView extends StatelessWidget {
  const _MoviesView(
      {Key? key, required this.movies, required this.pageController})
      : super(key: key);

  /// Movies coming remote or local storage
  final List<MovieItem> movies;

  final PageController pageController;

  void navigateToDetail(BuildContext context, String movieId) {
    Navigator.of(context).push(DetailPage.route(movieId));
  }

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      controller: pageController,
      itemCount: movies.length,
      itemBuilder: (context, index) {
        final movie = movies[index];
        return MovieItemPage(
          onPressed: () {
            navigateToDetail(context, movies[index].id);
          },
          onBookmarkPressed: () {},
          title: movie.title,
          posterPath: movie.backdropPath,
          rating: movie.rate,
        );
      },
    );
  }
}
