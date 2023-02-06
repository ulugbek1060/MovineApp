part of 'search_bloc.dart';

abstract class SearchEvent extends Equatable {
  const SearchEvent();
}

class FindMoviesEvent extends SearchEvent {
  final String? query;

  const FindMoviesEvent({required this.query});

  @override
  List<Object?> get props => [query];
}

class NextPageEvent extends SearchEvent {
  @override
  List<Object?> get props => [];
}

class ClearItemsEvent extends SearchEvent {
  @override
  List<Object?> get props => [];
}


