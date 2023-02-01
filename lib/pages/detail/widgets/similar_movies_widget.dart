import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/pages/detail/bloc/detail_movie_bloc.dart';
import 'package:movie_app/pages/detail/detail_page.dart';
import 'package:movie_app/pages/detail/widgets/movie_item_card.dart';

class SimilarMoviesWidget extends StatelessWidget {
  final double height;

  const SimilarMoviesWidget({
    Key? key,
    required this.height,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DetailMovieBloc, DetailMovieState>(
      buildWhen: (prev, current) => prev.movies != current.movies,
      builder: (context, state) {
        if (state.isLoading) {
          return const Center(
            child: CircularProgressIndicator(
              color: Colors.white,
            ),
          );
        }
        if (state.movies == null) {
          return Container();
        }
        return Container(
          padding: const EdgeInsets.symmetric(vertical: 16),
          color: Theme.of(context).primaryColor,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: state.movies!.length,
            itemBuilder: (_, index) {
              final movie = state.movies![index];
              return MovieItemCard(
                width: height * 0.6,
                height: height,
                movieItem: movie,
                onTap: () {
                  Navigator.of(context).push(DetailPage.route(movie.id));
                },
              );
            },
          ),
        );
      },
    );
  }
}
