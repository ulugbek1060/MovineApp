part of 'movies_bloc.dart';

@immutable
abstract class MoviesEvent {
  const MoviesEvent();
}

class MovieFetchedEvent extends MoviesEvent {
  final MovieType movieType;

  const MovieFetchedEvent({required this.movieType});
}
