import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/pages/detail/detail_page.dart';
import 'package:movie_app/pages/home/bloc/home_bloc.dart';
import 'package:movie_app/pages/home/movies_page.dart';
import 'package:movie_app/pages/widgets/movie_item_card.dart';
import 'package:movie_app/theme/app_typography.dart';
import 'package:movie_app/utils/strings.dart' show populars, seeAll;
import 'package:movies_data/movies_data.dart';

class PopularMovies extends StatelessWidget {
  final double size;

  const PopularMovies({Key? key, required this.size}) : super(key: key);

  void navigateToAllMovies(BuildContext context) {
    Navigator.of(context).push(MoviesPage.route(MovieType.NOW_PLAYING));
  }

  void navigateToDetail(BuildContext context, String movieId) {
    Navigator.of(context).push(DetailPage.route(movieId));
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
              const Text(populars, style: AppTypography.labelLarge),
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
            builder: (context, homeState) {
              final state = homeState.popularState;

              // loading
              if (state.isLoading) {
                return Center(
                  child: CircularProgressIndicator(
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                );
              }

              // error handling
              if (state.error != null) {
                return Center(
                  child: Text(state.error.toString(),
                      style: AppTypography.bodyText1),
                );
              }

              // movies
              final movies = state.popularMovies;
              logger(movies);
              return ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: movies.length,
                itemBuilder: (context, index) {
                  return Container(
                    margin: EdgeInsets.only(
                      left: 8,
                      right: index == movies.length - 1 ? 8 : 0,
                    ),
                    height: size,
                    width: size * 0.8,
                    child: MovieItemCard(
                        onPressed: () {
                          navigateToDetail(context, movies[index].id);
                        },
                        posterPath: movies[index].posterPath,
                        title: movies[index].title,
                        rate: movies[index].rate),
                  );
                },
              );
            },
          ),
        )
      ],
    );
  }
}
