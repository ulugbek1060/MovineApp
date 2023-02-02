import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:movies_data/movies_data.dart';

part 'typed_movies_event.dart';

part 'typed_movies_state.dart';

const defaultPageSize = 20;

class TypedMoviesBloc extends Bloc<TypedMoviesEvent, TypedMoviesState> {
  final MoviesRepository repository;

  TypedMoviesBloc({
    required this.repository,
  }) : super(TypedMoviesState.initialState()) {
    on<FetchTypedMoviesEvent>(_onFetchTypedMoviesEvent);
  }

  Future<void> _onFetchTypedMoviesEvent(
    FetchTypedMoviesEvent event,
    Emitter<TypedMoviesState> emit,
  ) async {
    if (state.isLoading) return;

    if (state.hasReached) return;

    emit(state.copyWith(isLoading: true));

    try {
      final movies = await repository.getMoviesByType(
        page: state.nextPage,
        type: event.type,
      );

      final hasReached = movies.movies!.length < defaultPageSize;
      final nextPage = (movies.page ?? state.nextPage) + 1;

      emit(state.copyWith(
        isLoading: false,
        movies: movies.movies,
        hasReached: hasReached,
        nextPage: nextPage,
      ));
    } catch (error) {
      emit(state.copyWith(isLoading: false, error: error));
    }
  }
}
