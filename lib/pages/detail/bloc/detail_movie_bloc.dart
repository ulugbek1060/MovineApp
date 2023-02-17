import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:movie_app/utils/status.dart';
import 'package:movies_data/movies_data.dart';

part 'detail_movie_state.dart';

part 'detail_movie_event.dart';

class DetailMovieBloc extends Bloc<DetailMovieEvent, DetailMovieState> {
  final MoviesRepository moviesRepository;
  final StorageRepository storageRepository;

  DetailMovieBloc({
    required this.moviesRepository,
    required this.storageRepository,
  }) : super(DetailMovieState.initialState()) {
    on<FetchedMovieEvent>(_onFetchMovieDetailEvent);
    on<BookmarkEvent>(_onBookmarkEvent);
  }

  Future<void> _onFetchMovieDetailEvent(
    FetchedMovieEvent event,
    Emitter<DetailMovieState> emit,
  ) async {
    try {
      emit(state.copyWith(status: Status.pending));

      final movie = await moviesRepository.getMovieDetail(event.movieId);

      final movies =
          await moviesRepository.getSimilarMovies(movieId: event.movieId);

      final isMarked =
          await storageRepository.checkWhetherIsMarkedOrNot(movie.id);

      final videos =
          await moviesRepository.getVideosByMovieId(movieId: movie.id);

      final casts = await moviesRepository.getCastsById(movieId: event.movieId);

      emit(state.copyWith(
        status: Status.success,
        movie: movie,
        videos: videos.videos,
        movies: movies.movies,
        casts: casts,
        isMarked: isMarked,
      ));
    } catch (error) {
      emit(state.copyWith(status: Status.error, error: error));
    }
  }

  Future<void> _onBookmarkEvent(
    BookmarkEvent event,
    Emitter<DetailMovieState> emit,
  ) async {
    if (state.isMarked) {
      storageRepository.deleteMovie(event.item.id);
      emit(state.copyWith(isMarked: false));
    } else {
      storageRepository.saveMovies(event.item);
      emit(state.copyWith(isMarked: true));
    }
  }
}
