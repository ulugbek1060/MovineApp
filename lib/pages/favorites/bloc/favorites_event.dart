part of 'favorites_bloc.dart';

@immutable
abstract class FavoritesEvent {
  const FavoritesEvent();
}

class AddAndRemoveEvent extends FavoritesEvent {
  final MovieItem movie;

  const AddAndRemoveEvent({required this.movie});
}

class GetMovieItems extends FavoritesEvent {}
