import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:movie_app/utils/status.dart';
import 'package:movies_data/movies_data.dart';

part 'home_event.dart';

part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final MoviesRepository moviesRepository;

  HomeBloc({required this.moviesRepository}) : super(HomeState.initial()) {
    on<FetchUpcomingMoviesEvent>(_onFetchUpcomingMovies);
    on<FetchNowPlayingMoviesEvent>(_onFetchNowPlayingMovies);
    on<FetchPopularMoviesEvent>(_onFetchPopularMovies);
    on<FetchTopRatedMoviesEvent>(_onFetchTopRatedMovies);
  }

  Future<void> _onFetchUpcomingMovies(
    FetchUpcomingMoviesEvent event,
    Emitter<HomeState> emit,
  ) async {
    final upcomingState = state.upcomingState;

    emit(state.copyWith(
        upcomingState: upcomingState.copyWith(status: Status.pending)));

    try {
      final result = await moviesRepository.getMoviesByType(
        page: 1,
        type: MovieType.UPCOMING,
      );

      final movies = result.movies ?? [];

      if (movies.isEmpty) {
        emit(state.copyWith(
            upcomingState: upcomingState.copyWith(
                status: Status.empty, movies: movies, error: null)));
        return;
      }

      emit(state.copyWith(
          upcomingState: upcomingState.copyWith(
              status: Status.success, movies: movies, error: null)));
    } catch (error) {
      emit(state.copyWith(
          upcomingState:
              upcomingState.copyWith(status: Status.error, error: error)));
    }
  }

  Future<void> _onFetchNowPlayingMovies(
    FetchNowPlayingMoviesEvent event,
    Emitter<HomeState> emit,
  ) async {
    final nowPlayingState = state.nowPlayingState;
    emit(state.copyWith(
        nowPlayingState: nowPlayingState.copyWith(status: Status.pending)));
    try {
      final result = await moviesRepository.getMoviesByType(
        page: 1,
        type: MovieType.NOW_PLAYING,
      );

      final movies = result.movies ?? [];

      if (movies.isEmpty) {
        emit(state.copyWith(
            nowPlayingState: nowPlayingState.copyWith(
                status: Status.empty, movies: movies, error: null)));
        return;
      }
      emit(state.copyWith(
          nowPlayingState: nowPlayingState.copyWith(
              status: Status.success, movies: movies, error: null)));
    } catch (error) {
      emit(state.copyWith(
          nowPlayingState:
              nowPlayingState.copyWith(status: Status.error, error: error)));
    }
  }

  Future<void> _onFetchPopularMovies(
    FetchPopularMoviesEvent event,
    Emitter<HomeState> emit,
  ) async {
    final popularState = state.popularState;
    emit(state.copyWith(
        popularState: popularState.copyWith(status: Status.pending)));
    try {
      final result = await moviesRepository.getMoviesByType(
        page: 1,
        type: MovieType.POPULAR,
      );

      final movies = result.movies ?? [];

      if (movies.isEmpty) {
        emit(state.copyWith(
            popularState: popularState.copyWith(
                status: Status.empty, movies: movies, error: null)));
        return;
      }

      emit(state.copyWith(
          popularState: popularState.copyWith(
              status: Status.success, movies: movies, error: null)));
    } catch (error) {
      emit(state.copyWith(
          popularState:
              popularState.copyWith(status: Status.error, error: error)));
    }
  }

  Future<void> _onFetchTopRatedMovies(
    FetchTopRatedMoviesEvent event,
    Emitter<HomeState> emit,
  ) async {
    final topRatedState = state.topRatedState;
    emit(state.copyWith(
        topRatedState: topRatedState.copyWith(status: Status.pending)));
    try {
      final result = await moviesRepository.getMoviesByType(
        page: 1,
        type: MovieType.TOP_RATED,
      );

      final movies = result.movies ?? [];

      if (movies.isEmpty) {
        emit(state.copyWith(
            topRatedState: topRatedState.copyWith(
                status: Status.empty, movies: movies, error: null)));
        return;
      }

      emit(state.copyWith(
          topRatedState: topRatedState.copyWith(
              status: Status.success, movies: movies, error: null)));
    } catch (error) {
      emit(state.copyWith(
          topRatedState:
              topRatedState.copyWith(status: Status.error, error: error)));
    }
  }
}
