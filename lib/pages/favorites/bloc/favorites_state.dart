part of 'favorites_bloc.dart';

class FavoritesState extends Equatable {
  final List<MovieItem> movies;
  final MovieItem? temporary;

  const FavoritesState({required this.movies, this.temporary});

  FavoritesState.initial() : this(movies: [], temporary: null);

  FavoritesState copyWith({
    List<MovieItem>? movies,
    MovieItem? temporary,
  }) {
    return FavoritesState(
      movies: movies ?? this.movies,
      temporary: temporary ?? this.temporary,
    );
  }

  @override
  List<Object?> get props => [movies, temporary];
}
