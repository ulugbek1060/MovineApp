part of 'detail_movie_bloc.dart';

class DetailMovieState {
  final bool isLoading;
  final Object? error;
  final MovieDetail? movie;

  DetailMovieState({required this.isLoading, this.error, this.movie});

  DetailMovieState.initialState() : this(isLoading: false);

  DetailMovieState copyWith({
    required bool? isLoading,
    required Object? error,
    required MovieDetail? movie,
  }) {
    return DetailMovieState(
      movie: movie ?? this.movie,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
    );
  }
}
