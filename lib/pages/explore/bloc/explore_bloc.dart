import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:movie_app/utils/status.dart';
import 'package:movies_data/movies_data.dart';

part 'explore_event.dart';

part 'explore_state.dart';

const defaultPageSize = 20;

class ExploreBloc extends Bloc<ExploreEvent, ExploreState> {
  final MoviesRepository repository;
  StreamSubscription? _streamSubscription;

  ExploreBloc({required this.repository}) : super(ExploreState.initial()) {
    on<FetchMoviesEvent>(_onFetchEvent, transformer: droppable());
    on<SearchMoviesEvent>(_onSearchEvent);
    on<ClearStateEvent>(_onClearStateEvent);
    on<FilterEvent>(_onFilterEvent);

    /// internal events
    on<_EmitResponseEvent>(_onEmitResponseEvent);
    on<_EmitErrorEvent>(_onEmitErrorEvent);
  }

  Future<void> _onFetchEvent(
      FetchMoviesEvent event, Emitter<ExploreState> emit) async {
    if (state.isLoading || state.hasReached) return;
    emit(state.copyWith(isLoading: true));

    final genre = state.filter?.genre?.value;
    final year = state.filter?.year?.value;
    final language = state.filter?.language?.value;

    _streamSubscription?.cancel();

    if (state.query != null) {
      _streamSubscription = repository
          .getMoviesByQuery(
            page: state.page,
            query: state.query!,
          )
          .asStream()
          .listen((response) {
        add(_EmitResponseEvent(response));
      }, onError: (error) {
        add(_EmitErrorEvent(error));
      });
    }

    if (state.filter != null) {
      _streamSubscription = repository
          .discoverMovies(
            page: state.page,
            genreId: genre,
            year: year,
            language: language,
          )
          .asStream()
          .listen((response) {
        add(_EmitResponseEvent(response));
      }, onError: (error) {
        add(_EmitErrorEvent(error));
      });
    }
  }

  /// Function refreshes all [ExploreState] and cancelling [StreamSubscription]
  /// and recalls [FetchMoviesEvent] from UI scroll event with query.
  Future<void> _onSearchEvent(
      SearchMoviesEvent event, Emitter<ExploreState> emit) async {
    _streamSubscription?.cancel();
    emit(ExploreState.initial().copyWith(
      isLoading: true,
      query: event.query,
    ));

    _streamSubscription = repository
        .getMoviesByQuery(page: state.page, query: event.query)
        .asStream()
        .listen(
      (response) {
        add(_EmitResponseEvent(response));
      },
      onError: (error) {
        add(_EmitErrorEvent(error));
      },
    );
  }

  /// Function refreshes all [ExploreState] and cancelling [StreamSubscription]
  /// and recalls [FetchMoviesEvent] from UI scroll event with query.
  Future<void> _onFilterEvent(
      FilterEvent event, Emitter<ExploreState> emit) async {
    _streamSubscription?.cancel();
    emit(ExploreState.initial().copyWith(
      isLoading: true,
      filter: event.filter,
    ));
  }

  Future<void> _onClearStateEvent(
      ClearStateEvent event, Emitter<ExploreState> emit) async {
    _streamSubscription?.cancel();
    emit(ExploreState.initial());
  }

  Future<void> _onEmitErrorEvent(
      _EmitErrorEvent event, Emitter<ExploreState> emit) async {
    final error = event.error;
    emit(state.copyWith(isLoading: false, error: error));
  }

  Future<void> _onEmitResponseEvent(
      _EmitResponseEvent event, Emitter<ExploreState> emit) async {
    final result = event.response;
    final movies = result.movies;
    final nextPage = (result.page ?? state.page) + 1;
    final hasReached = movies!.length < defaultPageSize;

    emit(state.copyWith(
      isLoading: false,
      movies: movies,
      page: nextPage,
      hasReached: hasReached,
      error: null,
    ));
  }

  @override
  Future<void> close() {
    _streamSubscription?.cancel();
    return super.close();
  }
}
