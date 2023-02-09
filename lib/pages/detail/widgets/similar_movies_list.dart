import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/pages/detail/bloc/detail_movie_bloc.dart';
import 'package:movie_app/pages/widgets/movie_item_card.dart';

class SimilarMoviesList extends StatelessWidget {
  final void Function(String movieId) navigate;

  const SimilarMoviesList({
    Key? key,
    required this.navigate,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DetailMovieBloc, DetailMovieState>(
      buildWhen: (prev, current) => prev.movies != current.movies,
      builder: (context, state) {
        final movies = state.movies;
        if (movies == null) {
          return Container();
        }
        return SliverGrid(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            childAspectRatio: 100 / 150,
            crossAxisCount: 2,
            mainAxisSpacing: 16,
            crossAxisSpacing: 16,
          ),
          delegate: SliverChildBuilderDelegate(
            (context, index) {
              final movie = movies[index];
              return MovieItemCard(
                title: movie.title,
                rate: movie.rate,
                posterPath: movie.posterPath,
                onPressed: () {
                  navigate(movie.id);
                },
              );
            },
            childCount: state.movies!.length,
          ),
        );
      },
    );
  }
}
