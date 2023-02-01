part of 'movies_bloc.dart';

class MoviesState extends Equatable {
  final List<MovieItem> movies;
  final int page;
  final bool hasReached;
  final bool isLoading;
  final Object? error;

  const MoviesState({
    required this.movies,
    required this.page,
    required this.hasReached,
    required this.isLoading,
    this.error,
  });

  MoviesState.initialState()
      : this(
            movies: [],
            page: 1,
            hasReached: false,
            isLoading: false,
            error: null);

  MoviesState copyWith({
    List<MovieItem>? movies,
    int? page,
    bool? hasReached,
    bool? isLoading,
    Object? error,
  }) {
    return MoviesState(
      movies: [...this.movies, ...movies ?? []],
      page: page ?? this.page,
      hasReached: hasReached ?? this.hasReached,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
    );
  }

  @override
  List<Object?> get props => [movies, page, hasReached, isLoading, error];
}
