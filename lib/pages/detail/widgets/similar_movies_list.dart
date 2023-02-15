import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/pages/detail/bloc/detail_movie_bloc.dart';
import 'package:movie_app/pages/widgets/empty_view.dart';
import 'package:movie_app/pages/widgets/movie_item_card.dart';

class SimilarMoviesList extends StatelessWidget {
  const SimilarMoviesList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DetailMovieBloc, DetailMovieState>(
      buildWhen: (prev, current) => prev.movies != current.movies,
      builder: (context, state) {
        final movies = state.movies;
        if (movies.isEmpty) {
          return const SliverToBoxAdapter(child: EmptyView());
        }
        return SliverGrid(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            childAspectRatio: 100 / 150,
            crossAxisCount: 2,
            mainAxisSpacing: 16,
            crossAxisSpacing: 16,
          ),
          delegate: SliverChildBuilderDelegate(
            (context, index) => MovieItemCard(movie: movies[index]),
            childCount: state.movies.length,
          ),
        );
      },
    );
  }
}
