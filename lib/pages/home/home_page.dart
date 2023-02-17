import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/pages/home/bloc/home_bloc.dart';
import 'package:movie_app/pages/home/widgets/now_playing_movies.dart';
import 'package:movie_app/pages/home/widgets/popular_movies.dart';
import 'package:movie_app/pages/home/widgets/top_rated_movies.dart';
import 'package:movie_app/pages/home/widgets/upcoming_movies.dart';
import 'package:movies_data/movies_data.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  MoviesRepository repository(BuildContext context) =>
      RepositoryProvider.of<MoviesRepository>(context);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeBloc(
        moviesRepository: repository(context),
      )
        ..add(FetchUpcomingMoviesEvent())
        ..add(FetchNowPlayingMoviesEvent())
        ..add(FetchPopularMoviesEvent())
        ..add(FetchTopRatedMoviesEvent()),
      child: const _HomeView(),
    );
  }
}

class _HomeView extends StatelessWidget {
  const _HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      color: Theme.of(context).colorScheme.onPrimary,
      onRefresh: () async {
        context.read<HomeBloc>()
          ..add(FetchUpcomingMoviesEvent())
          ..add(FetchNowPlayingMoviesEvent())
          ..add(FetchPopularMoviesEvent())
          ..add(FetchTopRatedMoviesEvent());
      },
      child: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: SizedBox(
              height: MediaQuery.of(context).size.height * 0.5,
              child: const UpcomingMovies(),
            ),
          ),
          const SliverToBoxAdapter(
            child: SizedBox(
              child: LatestMovies(size: 200),
            ),
          ),
          const SliverToBoxAdapter(
            child: SizedBox(
              child: PopularMovies(size: 200),
            ),
          ),
          const SliverToBoxAdapter(
            child: SizedBox(
              child: TopRatedMovies(size: 200),
            ),
          ),
          const SliverToBoxAdapter(
            child: SizedBox(height: 8),
          )
        ],
      ),
    );
  }
}
