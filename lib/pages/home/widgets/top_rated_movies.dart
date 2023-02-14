import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/pages/home/bloc/home_bloc.dart';
import 'package:movie_app/pages/home/movies_see_all.dart';
import 'package:movie_app/pages/widgets/movie_item_card.dart';
import 'package:movie_app/theme/app_typography.dart';
import 'package:movie_app/utils/status.dart';
import 'package:movie_app/utils/strings.dart' show seeAll, top_rated;
import 'package:movies_data/movies_data.dart';

class TopRatedMovies extends StatelessWidget {
  final double size;

  const TopRatedMovies({Key? key, required this.size}) : super(key: key);

  void navigateToAllMovies(BuildContext context) {
    Navigator.of(context).push(MoviesSeeAll.route(MovieType.NOW_PLAYING));
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Container(
          margin: const EdgeInsets.all(20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(top_rated, style: AppTypography.labelLarge),
              GestureDetector(
                  onTap: () {
                    navigateToAllMovies(context);
                  },
                  child: const Text(seeAll, style: AppTypography.bodyText1))
            ],
          ),
        ),
        SizedBox(
          height: size,
          child: BlocBuilder<HomeBloc, HomeState>(
              buildWhen: (prev, current) =>
                  prev.topRatedState != current.topRatedState,
              builder: (context, homeState) {
                return _buildComponents(homeState.topRatedState);
              }),
        )
      ],
    );
  }

  Widget _buildComponents(TopRatedMoviesState state) {
    switch (state.status) {
      case Status.success:
        return _MoviesView(movies: state.movies, itemSize: size);
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
  const _MoviesView({Key? key, required this.movies, required this.itemSize})
      : super(key: key);

  /// Single Item size
  final double itemSize;

  /// Movies coming remote or local storage
  final List<MovieItem> movies;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: movies.length,
      itemBuilder: (context, index) {
        return Container(
          margin: EdgeInsets.only(
            left: 8,
            right: index == movies.length - 1 ? 8 : 0,
          ),
          height: itemSize,
          width: itemSize * 0.8,
          child: MovieItemCard(movie: movies[index]),
        );
      },
    );
  }
}
