import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
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
      upcomingState: upcomingState.copyWith(isLoading: true),
    ));
    try {
      final result = await moviesRepository.getMoviesByType(
        page: 1,
        type: MovieType.UPCOMING,
      );

      final movies = result.movies;

      emit(state.copyWith(
        upcomingState: upcomingState.copyWith(
          isLoading: false,
          upcomingMovies: movies,
          error: null,
        ),
      ));
    } catch (error) {
      emit(state.copyWith(
        upcomingState: upcomingState.copyWith(
          isLoading: false,
          error: null,
        ),
      ));
    }
  }

  Future<void> _onFetchNowPlayingMovies(
    FetchNowPlayingMoviesEvent event,
    Emitter<HomeState> emit,
  ) async {
    final nowPlayingState = state.nowPlayingState;
    emit(state.copyWith(
      nowPlayingState: nowPlayingState.copyWith(isLoading: true),
    ));
    try {
      final result = await moviesRepository.getMoviesByType(
        page: 1,
        type: MovieType.NOW_PLAYING,
      );

      final movies = result.movies;

      emit(state.copyWith(
        nowPlayingState: nowPlayingState.copyWith(
          isLoading: false,
          nowPlayingMovies: movies,
          error: null,
        ),
      ));
    } catch (error) {
      emit(state.copyWith(
        nowPlayingState: nowPlayingState.copyWith(
          isLoading: false,
          error: null,
        ),
      ));
    }
  }

  Future<void> _onFetchPopularMovies(
    FetchPopularMoviesEvent event,
    Emitter<HomeState> emit,
  ) async {
    final popularState = state.popularState;
    emit(state.copyWith(
      popularState: popularState.copyWith(isLoading: true),
    ));
    try {
      final result = await moviesRepository.getMoviesByType(
        page: 1,
        type: MovieType.POPULAR,
      );

      final movies = result.movies;

      emit(state.copyWith(
        popularState: popularState.copyWith(
          isLoading: false,
          popularMovies: movies,
          error: null,
        ),
      ));
    } catch (error) {
      emit(state.copyWith(
        popularState: popularState.copyWith(
          isLoading: false,
          error: null,
        ),
      ));
    }
  }

  Future<void> _onFetchTopRatedMovies(
    FetchTopRatedMoviesEvent event,
    Emitter<HomeState> emit,
  ) async {
    final topRatedState = state.topRatedState;
    emit(state.copyWith(
      topRatedState: topRatedState.copyWith(isLoading: true),
    ));
    try {
      final result = await moviesRepository.getMoviesByType(
        page: 1,
        type: MovieType.TOP_RATED,
      );

      final movies = result.movies;

      emit(state.copyWith(
        topRatedState: topRatedState.copyWith(
          isLoading: false,
          topRatedMovies: movies,
          error: null,
        ),
      ));
    } catch (error) {
      emit(state.copyWith(
        topRatedState: topRatedState.copyWith(
          isLoading: false,
          error: null,
        ),
      ));
    }
  }
}
