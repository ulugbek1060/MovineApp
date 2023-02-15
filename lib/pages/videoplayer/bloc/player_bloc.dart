import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:movie_app/utils/status.dart';
import 'package:movies_data/movies_data.dart';

part 'player_event.dart';

part 'player_state.dart';

class PlayerBloc extends Bloc<PlayerEvent, PlayerState> {
  final MoviesRepository repository;

  PlayerBloc({required this.repository}) : super(PlayerState.initial()) {
    on<FetchVideosEvent>(_onFetchVideosEvent);
    on<ChangeVideoEvent>(_onChangeVideoEvent);
  }

  Future<void> _onChangeVideoEvent(
    ChangeVideoEvent event,
    Emitter<PlayerState> emit,
  ) async {
    emit(state.copyWith(currentVideoKey: event.videoKey));
  }

  Future<void> _onFetchVideosEvent(
    FetchVideosEvent event,
    Emitter<PlayerState> emit,
  ) async {
    if (state.status == Status.pending) return;

    emit(state.copyWith(status: Status.pending));

    try {
      final result =
          await repository.getVideosByMovieId(movieId: event.movieId!);
      final isEmpty = result.videos.isEmpty;

      if (isEmpty) {
        emit(state.copyWith(status: Status.empty));
      } else {
        emit(state.copyWith(status: Status.success, videos: result.videos));
      }
    } catch (error) {
      emit(state.copyWith(status: Status.error));
    }
  }
}
