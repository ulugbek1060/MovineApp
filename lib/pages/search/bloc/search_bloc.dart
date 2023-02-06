import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';
import 'package:movies_data/movies_data.dart';

part 'search_event.dart';

part 'search_state.dart';

const _defaultPage = 20;

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final MoviesRepository repository;

  SearchBloc({required this.repository}) : super(SearchState.initialState()) {
    on<NextPageEvent>(_onNextPageEvent);
    on<FindMoviesEvent>(_onFindEvent);
    on<ClearItemsEvent>(_onClearItemsEvent);
  }

  Future<void> _onFindEvent(
      FindMoviesEvent event, Emitter<SearchState> emit) async {
    if (event.query == null || state.query == event.query) return;

    //initial search state
    emit(state.copyWith(
      query: event.query,
      movies: [],
      page: 1,
      isLoading: true,
      hasReached: false,
      error: null,
    ));

    try {
      final result = await repository.getMoviesByQuery(
        query: state.query!,
        page: state.page,
      );

      final movies = result.movies;
      final nextPage = (result.page ?? state.page) + 1;
      // final hasReached = movies!.length < _defaultPage;

      emit(state.copyWith(
        movies: movies,
        isLoading: false,
        page: nextPage,
      ));
    } catch (error) {
      emit(state.copyWith(isLoading: false, error: error));
    }
  }

  Future<void> _onNextPageEvent(
      NextPageEvent event, Emitter<SearchState> emit) async {
    if (state.query == null) return;

    if (state.isLoading) return;

    if (state.hasReached) return;

    emit(state.copyWith(isLoading: true));

    try {
      final result = await repository.getMoviesByQuery(
        query: state.query!,
        page: state.page,
      );

      final movies = result.movies;
      final nextPage = (result.page ?? state.page) + 1;
      final hasReached = movies!.length < _defaultPage;

      emit(state.copyWith(
        movies: movies,
        isLoading: false,
        hasReached: hasReached,
        page: nextPage,
      ));
    } catch (error) {
      emit(state.copyWith(isLoading: false, error: error));
    }
  }

  Future<void> _onClearItemsEvent(
      ClearItemsEvent event, Emitter<SearchState> emit) async {
    emit(SearchState.initialState());
  }
}
