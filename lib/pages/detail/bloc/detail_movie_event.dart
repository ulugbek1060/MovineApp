part of 'detail_movie_bloc.dart';

@immutable
abstract class DetailMovieEvent {
  const DetailMovieEvent();
}

class FetchedMovieDetailEvent extends DetailMovieEvent {
  final String movieId;

  const FetchedMovieDetailEvent({required this.movieId});
}

