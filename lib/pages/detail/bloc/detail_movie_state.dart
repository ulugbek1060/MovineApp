part of 'detail_movie_bloc.dart';

class DetailMovieState extends Equatable {
  final MovieDetail? movie;
  final List<MovieItem>? movies;
  final bool isLoading;
  final Object? error;

  const DetailMovieState({
    required this.isLoading,
    this.movies,
    this.error,
    this.movie,
  });

  const DetailMovieState.initialState() : this(isLoading: false);

  DetailMovieState copyWith({
    bool? isLoading,
    List<MovieItem>? movies,
    Object? error,
    MovieDetail? movie,
  }) {
    return DetailMovieState(
      movie: movie ?? this.movie,
      movies: movies ?? this.movies,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
    );
  }

  @override
  List<Object?> get props => [movie, movies, isLoading, error];

  @override
  String toString() => {
        'isLoading': isLoading,
        'movie': movie,
        'error': error,
      }.toString();
}
