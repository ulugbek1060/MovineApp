part of 'typed_movies_bloc.dart';

@immutable
abstract class TypedMoviesEvent {
  const TypedMoviesEvent();
}

class FetchTypedMoviesEvent extends TypedMoviesEvent {
  final MovieType type;

  const FetchTypedMoviesEvent({required this.type});
}
