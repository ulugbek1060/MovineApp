import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:movies_data/movies_data.dart';
import 'package:rxdart/rxdart.dart';

enum FilterStatus { success, loading, error }

class FilterState extends Equatable {
  final List<GenreItem> genres;
  final FilterStatus status;

  const FilterState(this.genres, this.status);

  FilterState.loading() : this([], FilterStatus.loading);

  const FilterState.success(List<GenreItem> genres)
      : this(genres, FilterStatus.success);

  FilterState.fail() : this([], FilterStatus.error);

  @override
  List<Object?> get props => [genres, status];
}

class FilterViewModel {
  final MoviesRepository repository;

  FilterViewModel(MoviesRepository? moviesRepository)
      : repository = moviesRepository ?? MoviesRepository();

  StreamSubscription? _streamSubscription;

  final _genresStreamController =
      BehaviorSubject<FilterState>.seeded(FilterState.loading());

  Stream<FilterState> get getGenresStream => _genresStreamController;

  Future<void> loadGenres() async {
    _streamSubscription?.cancel();
    _streamSubscription = repository.getGenres().asStream().listen((genres) {
      _genresStreamController.sink.add(FilterState.success(genres));
    }, onError: (error) {
      _genresStreamController.sink.add(FilterState.fail());
    });
  }

  void close() {
    _streamSubscription?.cancel();
    _genresStreamController.close();
  }
}
