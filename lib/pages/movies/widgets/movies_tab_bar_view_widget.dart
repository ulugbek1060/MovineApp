import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/pages/movies/bloc/typed_movies_bloc.dart';
import 'package:movie_app/pages/movies/widgets/movie_grid_item.dart';
import 'package:movies_data/movies_data.dart';

class PageOfTabWidget extends StatelessWidget {
  final MovieType type;

  const PageOfTabWidget({
    Key? key,
    required this.type,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => TypedMoviesBloc(
        repository: RepositoryProvider.of<MoviesRepository>(context),
      )..add(FetchTypedMoviesEvent(type: type)),
      child: const _MoviesGridView(),
    );
  }
}

class _MoviesGridView extends StatelessWidget {
  const _MoviesGridView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TypedMoviesBloc, TypedMoviesState>(
      builder: (context, state) {
        return GridView.builder(
          itemCount: state.movies.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
          ),
          itemBuilder: (context, index) {
            final movie = state.movies[index];
            return MovieGridItem(key: Key(movie.id), onTap: () {}, movie: movie);
          },
        );
      },
    );
  }
}
