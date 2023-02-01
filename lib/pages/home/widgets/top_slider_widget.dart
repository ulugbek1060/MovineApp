import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/pages/home/bloc/movies_bloc.dart';
import 'package:movie_app/pages/home/widgets/movie_list_card.dart';
import 'package:movies_data/movies_data.dart';

class TopSlideWidget extends StatelessWidget {
  final double height;
  final double width;

  const TopSlideWidget({
    super.key,
    required this.height,
    required this.width,
  });

  void onTap() {}

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => MoviesBloc(
        repository: RepositoryProvider.of<MoviesRepository>(context),
      )..add(const MovieFetchedEvent(movieType: MovieType.NOW_PLAYING)),
      child: _MoviesList(
        height: height,
        width: width,
        onTap: onTap,
      ),
    );
  }
}

class _MoviesList extends StatelessWidget {
  final double height;
  final double width;
  final void Function() onTap;

  const _MoviesList({
    super.key,
    required this.height,
    required this.width,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MoviesBloc, MoviesState>(
      listenWhen: (prev, current) => prev.error != current.error,
      listener: (context, current) {
        ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(
            const SnackBar(content: Text('Failure')),
          );
      },
      // buildWhen: (prev, current) => prev.page != current.page,
      builder: (context, state) {
        final movies = state.movies;
        if (movies.isEmpty && !state.isLoading) {
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
        return SizedBox(
          height: height,
          width: double.infinity,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: movies.length,
            itemBuilder: (context, index) {
              return MovieListCard(
                onTap: onTap,
                contentImage: movies[index].posterPath,
                movieName: movies[index].title,
                movieId: movies[index].id,
              );
            },
          ),
        );
      },
    );
  }
}
