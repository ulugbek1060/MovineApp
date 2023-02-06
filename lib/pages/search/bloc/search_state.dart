part of 'search_bloc.dart';

class SearchState extends Equatable {
  final String? query;
  final List<MovieItem> movies;
  final int page;
  final bool isLoading;
  final bool hasReached;
  final Object? error;

  const SearchState({
    this.query,
    required this.isLoading,
    required this.movies,
    required this.page,
    required this.hasReached,
    this.error,
  });

  SearchState.initialState()
      : movies = [],
        query = null,
        page = 1,
        isLoading = false,
        hasReached = false,
        error = null;

  SearchState copyWith({
    String? query,
    List<MovieItem>? movies,
    int? page,
    bool? hasReached,
    bool? isLoading,
    Object? error,
  }) =>
      SearchState(
        query: query ?? this.query,
        isLoading: isLoading ?? this.isLoading,
        movies: [...this.movies, ...movies ?? []],
        page: page ?? this.page,
        hasReached: hasReached ?? this.hasReached,
        error: error ?? this.error,
      );

  @override
  List<Object?> get props =>
      [query, movies, page, isLoading, hasReached, error];
}
