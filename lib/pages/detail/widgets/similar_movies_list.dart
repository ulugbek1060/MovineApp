import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/pages/detail/bloc/detail_movie_bloc.dart';
import 'package:movie_app/pages/detail/widgets/movie_item_card.dart';
import 'package:movie_app/theme/app_colors.dart';

class SimilarMoviesList extends StatelessWidget {
  final double size;
  final void Function(String movieId) navigate;

  const SimilarMoviesList({
    Key? key,
    required this.size,
    required this.navigate,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DetailMovieBloc, DetailMovieState>(
      buildWhen: (prev, current) => prev.movies != current.movies,
      builder: (context, state) {
        if (state.isLoading) {
          return const Center(
            child: CircularProgressIndicator(
              color: AppColors.secondaryColor,
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
                key: Key(movie.id),
                height: size,
                width: size * 0.5,
                movieItem: movie,
                onTap: () {
                  navigate(movie.id);
                },
              );
            },
          ),
        );
      },
    );
  }
}
