part of 'detail_movie_bloc.dart';

class DetailMovieState extends Equatable {
  final MovieDetail? movie;
  final bool isMarked;
  final List<MovieItem>? movies;
  final Status status;
  final Object? error;

  const DetailMovieState({
    required this.status,
    required this.isMarked,
    this.movies,
    this.error,
    this.movie,
  });

  const DetailMovieState.initialState()
      : this(status: Status.empty, isMarked: false);

  DetailMovieState copyWith({
    Status? status,
    List<MovieItem>? movies,
    bool? isMarked,
    Object? error,
    MovieDetail? movie,
  }) {
    return DetailMovieState(
      movie: movie ?? this.movie,
      movies: movies ?? this.movies,
      isMarked: isMarked ?? this.isMarked,
      status: status ?? this.status,
      error: error ?? this.error,
    );
  }

  @override
  List<Object?> get props => [movie, movies, isMarked, status, error];
}
