import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:movies_data/movies_data.dart';

part 'detail_movie_state.dart';

part 'detail_movie_event.dart';

class DetailMovieBloc extends Bloc<DetailMovieEvent, DetailMovieState> {
  final MoviesRepository moviesRepository;

  DetailMovieBloc({
    required this.moviesRepository,
  }) : super(DetailMovieState.initialState()) {
    on<FetchedMovieDetailEvent>(_onFetchMovieDetailEvent);
  }

  Future<void> _onFetchMovieDetailEvent(
    FetchedMovieDetailEvent event,
    Emitter<DetailMovieState> emit,
  ) async {
    try {
      emit(state.copyWith(isLoading: true));
      final movie = await moviesRepository.getMovieDetail(event.movieId);
      final movies = await moviesRepository.getSimilarMovies(
        movieId: event.movieId,
      );
      emit(state.copyWith(
        isLoading: false,
        movie: movie,
        movies: movies.movies,
      ));
    } catch (error) {
      emit(state.copyWith(isLoading: false, error: error));
    }
  }
}
