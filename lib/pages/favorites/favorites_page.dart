import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/pages/favorites/bloc/favorites_bloc.dart';
import 'package:movies_data/movies_data.dart';

class FavoritesPage extends StatelessWidget {
  static Route<void> route() =>
      MaterialPageRoute(builder: (_) => const FavoritesPage());

  const FavoritesPage({Key? key}) : super(key: key);

  StorageRepository repository(BuildContext context) {
    return RepositoryProvider.of<StorageRepository>(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: BlocProvider(
        create: (_) => FavoritesBloc(repository: repository(context)),
        child: const _FavoritesView(),
      ),
    );
  }
}

class _FavoritesView extends StatelessWidget {
  const _FavoritesView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FavoritesBloc, FavoritesState>(
      builder: (context, state) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
                childAspectRatio: 100 / 150,
              ),
              itemCount: state.movies.length,
              itemBuilder: (context, index) {
                final movie = state.movies[index];
                return FavoriteMovieItem(
                  movieItem: movie,
                  onTap: () {},
                );
              },
            ),
          ),
        );
      },
    );
  }
}

class FavoriteMovieItem extends StatelessWidget {
  final MovieItem movieItem;
  final void Function() onTap;

  const FavoriteMovieItem({
    Key? key,
    required this.movieItem,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.all(6),
        child: _cardItem(movieItem),
      ),
    );
  }

  Widget _cardItem(MovieItem movieItem) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: NetworkImage(movieItem.posterPath),
          fit: BoxFit.cover,
        ),
        borderRadius: const BorderRadius.all(
          Radius.circular(20),
        ),
      ),
    );
  }
}
