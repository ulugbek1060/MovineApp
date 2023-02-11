part of 'explore_bloc.dart';

@immutable
abstract class ExploreState extends Equatable {}

class ExploreByQueryState extends ExploreState {
  final String? query;
  final List<MovieItem> movies;
  final Status status;

  ExploreByQueryState({this.query, required this.movies, required this.status});

  ExploreByQueryState copyWith({
    String? query,
    List<MovieItem>? movies,
    Status? status,
  }) {
    return ExploreByQueryState(
        query: query ?? this.query,
        movies: [...this.movies, ...movies ?? []],
        status: status ?? this.status);
  }

  @override
  List<Object?> get props => [query, movies, status];
}

class ExploreByFilterState extends ExploreState {
  final Filter? filter;
  final List<MovieItem> movies;
  final Status status;

  ExploreByFilterState(
      {this.filter, required this.movies, required this.status});

  ExploreByFilterState copyWith({
    Filter? filter,
    List<MovieItem>? movies,
    Status? status,
  }) {
    return ExploreByFilterState(
        filter: filter ?? this.filter,
        movies: [...this.movies, ...movies ?? []],
        status: status ?? this.status);
  }

  @override
  List<Object?> get props => [filter, movies, status];
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
