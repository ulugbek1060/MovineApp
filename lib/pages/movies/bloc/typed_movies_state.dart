part of 'typed_movies_bloc.dart';

class TypedMoviesState extends Equatable {
  final List<MovieItem> movies;
  final Object? error;
  final bool isLoading;
  final bool hasReached;
  final int nextPage;

  const TypedMoviesState({
    required this.movies,
    this.error,
    required this.isLoading,
    required this.hasReached,
    required this.nextPage,
  });

  TypedMoviesState.initialState()
      : this(
            movies: [],
            isLoading: false,
            hasReached: false,
            error: null,
            nextPage: 1);

  TypedMoviesState copyWith({
    List<MovieItem>? movies,
    int? nextPage,
    bool? isLoading,
    bool? hasReached,
    Object? error,
  }) =>
      TypedMoviesState(
        movies: [...this.movies, ...movies ?? []],
        isLoading: isLoading ?? this.isLoading,
        hasReached: hasReached ?? this.hasReached,
        nextPage: nextPage ?? this.nextPage,
      );

  @override
  List<Object?> get props => [movies, nextPage, isLoading, hasReached, error];
}
