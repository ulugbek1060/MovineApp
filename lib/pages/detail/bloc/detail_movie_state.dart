part of 'detail_movie_bloc.dart';

class DetailMovieState extends Equatable {
  final MovieDetail? movie;
  final bool isMarked;
  final List<MovieItem>? movies;
  final bool isLoading;
  final Object? error;

  const DetailMovieState({
    required this.isLoading,
    required this.isMarked,
    this.movies,
    this.error,
    this.movie,
  });

  const DetailMovieState.initialState()
      : this(isLoading: false, isMarked: false);

  DetailMovieState copyWith({
    bool? isLoading,
    List<MovieItem>? movies,
    bool? isMarked,
    Object? error,
    MovieDetail? movie,
  }) {
    return DetailMovieState(
      movie: movie ?? this.movie,
      movies: movies ?? this.movies,
      isMarked: isMarked ?? this.isMarked,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
    );
  }

  @override
  List<Object?> get props => [movie, movies, isMarked, isLoading, error];

  @override
  String toString() => {
        'isLoading': isLoading,
        'movie': movie,
        'error': error,
      }.toString();
}
