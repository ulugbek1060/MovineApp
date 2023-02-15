part of 'detail_movie_bloc.dart';

class DetailMovieState extends Equatable {
  final MovieDetail? movie;
  final bool isMarked;
  final List<MovieItem> movies;
  final List<VideoItem> videos;
  final Status status;
  final Object? error;

  const DetailMovieState({
    required this.status,
    required this.isMarked,
    required this.videos,
    required this.movies,
    this.error,
    this.movie,
  });

  DetailMovieState.initialState()
      : this(status: Status.empty, movies: [], videos: [], isMarked: false);

  DetailMovieState copyWith({
    Status? status,
    List<MovieItem>? movies,
    List<VideoItem>? videos,
    bool? isMarked,
    Object? error,
    MovieDetail? movie,
  }) {
    return DetailMovieState(
      movie: movie ?? this.movie,
      videos: videos ?? this.videos,
      movies: movies ?? this.movies,
      isMarked: isMarked ?? this.isMarked,
      status: status ?? this.status,
      error: error ?? this.error,
    );
  }

  @override
  List<Object?> get props => [movie, movies, isMarked, videos, status, error];
}
