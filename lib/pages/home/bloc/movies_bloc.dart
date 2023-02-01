import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:movies_data/movies_data.dart';

part 'movies_event.dart';

part 'movies_state.dart';

const defaultPageSize = 20;

class MoviesBloc extends Bloc<MoviesEvent, MoviesState> {
  final MoviesRepository repository;

  MoviesBloc({
    required this.repository,
  }) : super(MoviesState.initialState()) {
    on<MovieFetchedEvent>(_onMoviesFetchedEvent);
  }

  Future<void> _onMoviesFetchedEvent(
    MovieFetchedEvent event,
    Emitter<MoviesState> emit,
  ) async {
    if (state.isLoading) return;

    if (state.hasReached) return;

    try {
      emit(state.copyWith(isLoading: true));

      final result = await repository.getMoviesByType(
        page: state.page,
        type: event.movieType,
      );

      final newMovies = result.movies;
      final hasReached = newMovies!.length < defaultPageSize;
      final nextPage = (result.page ?? state.page) + 1;

      emit(state.copyWith(
        movies: newMovies,
        isLoading: false,
        hasReached: hasReached,
        page: nextPage,
      ));
    } catch (error) {
      emit(state.copyWith(error: error, isLoading: false));
    }
  }
}
