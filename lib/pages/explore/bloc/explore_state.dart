part of 'explore_bloc.dart';

class ExploreState extends Equatable {
  final String? query;
  final List<MovieItem> movies;
  final bool hasReached;
  final bool isLoading;
  final int page;
  final Filter? filter;
  final Object? error;

  const ExploreState({
    required this.movies,
    required this.hasReached,
    required this.isLoading,
    required this.page,
    required this.filter,
    this.query,
    this.error,
  });

  ExploreState.initial()
      : this(
            movies: [],
            hasReached: false,
            isLoading: false,
            page: 1,
            filter: null,
            query: null,
            error: null);

  ExploreState copyWith({
    String? query,
    List<MovieItem>? movies,
    bool? isLoading,
    bool? hasReached,
    int? page,
    Filter? filter,
    Object? error,
  }) {
    return ExploreState(
      query: query ?? this.query,
      movies: [...this.movies, ...movies ?? []],
      hasReached: hasReached ?? this.hasReached,
      isLoading: isLoading ?? this.isLoading,
      page: page ?? this.page,
      filter: filter ?? this.filter,
      error: error ?? this.error,
    );
  }

  @override
  List<Object?> get props =>
      [movies, isLoading, error, filter, hasReached, page, query];
}

class Filter extends Equatable {
  final FilterObject? genre;
  final FilterObject? language;
  final FilterObject? year;

  const Filter({this.genre, this.language, this.year});

  Filter copyWith({
    FilterObject? genre,
    FilterObject? language,
    FilterObject? year,
  }) {
    return Filter(
      genre: genre ?? this.genre,
      language: language ?? this.language,
      year: year ?? this.year,
    );
  }

  @override
  List<Object?> get props => [genre, language, year];
}

class FilterObject extends Equatable {
  final String name;
  final String value;

  const FilterObject(this.name, this.value);

  @override
  List<Object?> get props => [name, value];
}
