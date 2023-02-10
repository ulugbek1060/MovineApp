part of 'explore_bloc.dart';

@immutable
abstract class ExploreEvent {}

class FetchMoviesEvent extends ExploreEvent {}

class FilterEvent extends ExploreEvent {
  FilterEvent(this.filter);
  final Filter filter;
}

class SearchMoviesEvent extends ExploreEvent {
  SearchMoviesEvent(this.query);

  final String? query;
}

class ClearStateEvent extends ExploreEvent {}

/// Internal event from network
class _EmitResponseEvent extends ExploreEvent {
  _EmitResponseEvent(this.response);

  final MoviesList response;
}

/// Internal event from network
class _EmitErrorEvent extends ExploreEvent {
  _EmitErrorEvent(this.error);

  final Object? error;
}
