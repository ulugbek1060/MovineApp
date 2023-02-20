import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
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
    final upcomingMovState = state.upcomingState;

    final newUpcomingMovState = upcomingMovState.copyWith(
      status: Status.pending,
      movies: upcomingMovState.movies,
    );

    emit(state.copyWith(upcomingState: newUpcomingMovState));

    final responseState = await moviesRepository.getMoviesByType(
      page: 1,
      type: MovieType.UPCOMING,
    );

    if (responseState is Success) {
      final data = (responseState as Success<MoviesList>).data;
      final movies = data.movies ?? [];
      final newUpcomingMovState = upcomingMovState.copyWith(
        status: Status.success,
        movies: movies,
      );
      emit(state.copyWith(upcomingState: newUpcomingMovState));
    } else if (responseState is Fail) {
      final newUpcomingMovState = upcomingMovState.copyWith(
        status: Status.error,
        movies: [],
      );
      emit(state.copyWith(upcomingState: newUpcomingMovState));
    } else if (responseState is NoConnection) {
      final newUpcomingMovState =
          upcomingMovState.copyWith(status: Status.noConnection);
      emit(state.copyWith(upcomingState: newUpcomingMovState));
    } else {
      emit(state.copyWith(upcomingState: upcomingMovState));
    }
  }

  Future<void> _onFetchNowPlayingMovies(
    FetchNowPlayingMoviesEvent event,
    Emitter<HomeState> emit,
  ) async {
    final nowPlayingMovsState = state.nowPlayingState;

    final newNowPlayingMosState = nowPlayingMovsState.copyWith(
      status: Status.pending,
      movies: nowPlayingMovsState.movies,
    );

    emit(state.copyWith(nowPlayingState: newNowPlayingMosState));

    final responseState = await moviesRepository.getMoviesByType(
      page: 1,
      type: MovieType.NOW_PLAYING,
    );

    if (responseState is Success) {
      final data = (responseState as Success<MoviesList>).data;
      final movies = data.movies ?? [];
      final newNowPlayingMosState = nowPlayingMovsState.copyWith(
        status: Status.success,
        movies: movies,
      );
      emit(state.copyWith(nowPlayingState: newNowPlayingMosState));
    } else if (responseState is Fail) {
      final newNowPlayingMosState = nowPlayingMovsState.copyWith(
        status: Status.error,
        movies: [],
      );
      emit(state.copyWith(nowPlayingState: newNowPlayingMosState));
    } else if (responseState is NoConnection) {
      final newNowPlayingMosState =
          nowPlayingMovsState.copyWith(status: Status.noConnection);
      emit(state.copyWith(nowPlayingState: newNowPlayingMosState));
    } else {
      emit(state.copyWith(nowPlayingState: nowPlayingMovsState));
    }
  }

  Future<void> _onFetchTopRatedMovies(
    FetchTopRatedMoviesEvent event,
    Emitter<HomeState> emit,
  ) async {
    final topRatedMosState = state.topRatedState;

    final newTopRatedMovsState = topRatedMosState.copyWith(
      status: Status.pending,
      movies: topRatedMosState.movies,
    );

    emit(state.copyWith(topRatedState: newTopRatedMovsState));

    final responseState = await moviesRepository.getMoviesByType(
      page: 1,
      type: MovieType.TOP_RATED,
    );

    if (responseState is Success) {
      final data = (responseState as Success<MoviesList>).data;
      final movies = data.movies ?? [];
      final newTopRatedMovsState = topRatedMosState.copyWith(
        status: Status.success,
        movies: movies,
      );
      emit(state.copyWith(topRatedState: newTopRatedMovsState));
    } else if (responseState is Fail) {
      final newTopRatedMovsState = topRatedMosState.copyWith(
        status: Status.error,
        movies: [],
      );
      emit(state.copyWith(topRatedState: newTopRatedMovsState));
    } else if (responseState is NoConnection) {
      final newTopRatedMovsState = topRatedMosState.copyWith(
        status: Status.noConnection,
      );
      emit(state.copyWith(topRatedState: newTopRatedMovsState));
    } else {
      emit(state.copyWith(topRatedState: topRatedMosState));
    }
  }

  Future<void> _onFetchPopularMovies(
    FetchPopularMoviesEvent event,
    Emitter<HomeState> emit,
  ) async {
    final popularMovsState = state.popularState;

    final newPopularMovsState = popularMovsState.copyWith(
      status: Status.pending,
      movies: popularMovsState.movies,
    );

    emit(state.copyWith(popularState: newPopularMovsState));

    final responseState = await moviesRepository.getMoviesByType(
      page: 1,
      type: MovieType.POPULAR,
    );

    if (responseState is Success) {
      final data = (responseState as Success<MoviesList>).data;
      final movies = data.movies ?? [];
      final newPopularMovsState = popularMovsState.copyWith(
        status: Status.success,
        movies: movies,
      );
      emit(state.copyWith(popularState: newPopularMovsState));
    } else if (responseState is Fail) {
      final newPopularMovsState = popularMovsState.copyWith(
        status: Status.error,
        movies: [],
      );
      emit(state.copyWith(popularState: newPopularMovsState));
    } else if (responseState is NoConnection) {
      final newPopularMovsState = popularMovsState.copyWith(
        status: Status.noConnection,
      );
      emit(state.copyWith(popularState: newPopularMovsState));
    } else {
      emit(state.copyWith(popularState: popularMovsState));
    }
  }
}
