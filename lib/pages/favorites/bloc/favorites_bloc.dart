import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:movies_data/movies_data.dart';

part 'favorites_event.dart';

part 'favorites_state.dart';

class FavoritesBloc extends Bloc<FavoritesEvent, FavoritesState> {
  final StorageRepository repository;

  late StreamSubscription<List<MovieItem>> _moviesStatusSubscription;

  FavoritesBloc({required this.repository}) : super(FavoritesState.initial()) {
    on<AddAndRemoveEvent>((event, emit) async {
      final hasMarked =
          await repository.checkWhetherIsMarkedOrNot(event.movie.id);
      if (hasMarked) {
        repository.deleteMovie(event.movie.id);
      } else {
        repository.saveMovies(event.movie);
      }
    });

    _moviesStatusSubscription = repository.getSavedMovies().listen((list) {
      emit(state.copyWith(movies: list));
    });
  }

  @override
  Future<void> close() {
    logger('closed');
    _moviesStatusSubscription.cancel();
    return super.close();
  }
}
