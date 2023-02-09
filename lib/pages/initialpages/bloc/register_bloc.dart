import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:movies_data/movies_data.dart'
    show AuthRepository, GenreItem, MoviesRepository, StorageRepository, logger;

part 'register_event.dart';

part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final AuthRepository authRepository;
  final StorageRepository storageRepository;
  final MoviesRepository moviesRepository;

  late StreamSubscription<List<GenreItem>> _streamSubscription;

  RegisterBloc({
    required this.authRepository,
    required this.storageRepository,
    required this.moviesRepository,
  }) : super(RegisterState.initial()) {
    on<FetchGenresEvent>(_onFetchGenresEvent);
    on<FinishRegisterEvent>(_onFinishRegisterEvent);
    on<ChangeFlagEvent>(_onChangeFlagEvent);
    on<_RefreshEvent>(_onRefreshEvent);

    _streamSubscription = storageRepository.getSavedGenres().listen((genres) {
      logger(genres);
      add(_RefreshEvent(genres));
    });
  }

  Future<void> _onRefreshEvent(
    _RefreshEvent event,
    Emitter<RegisterState> emit,
  ) async {
    emit(state.copyWith(genres: event.genres));
  }

  Future<void> _onFetchGenresEvent(
      FetchGenresEvent event, Emitter<RegisterState> emit) async {
    emit(state.copyWith(isLoading: true));

    await Future.delayed(const Duration(seconds: 3));

    try {
      // from remote
      final genres = await moviesRepository.getGenres();
      // save to local
      await storageRepository.saveListOfGenres({...genres});

      emit(state.copyWith(isLoading: false));
    } catch (error) {
      emit(state.copyWith(isLoading: false, error: error));
    }
  }

  Future<void> _onChangeFlagEvent(
      ChangeFlagEvent event, Emitter<RegisterState> emit) async {
    storageRepository.changeGenreFlag(event.genre);
  }

  Future<void> _onFinishRegisterEvent(
      RegisterEvent event, Emitter<RegisterState> state) async {
    authRepository.login();
  }

  @override
  Future<void> close() {
    _streamSubscription.cancel();
    return super.close();
  }
}
