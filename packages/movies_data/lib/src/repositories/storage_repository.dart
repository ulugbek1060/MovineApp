import 'package:hive/hive.dart';
import 'package:movies_data/movies_data.dart';
import 'package:movies_data/src/service/storage_service_impl.dart';
import 'package:storage_api/storage_api.dart';

const collectionFavorites = 'favorites.box';

class StorageRepository {
  final StorageService _storage;

  StorageRepository({required BoxCollection boxCollection})
      : this._storage = StorageServiceImpl(
          boxCollection: boxCollection,
          collectionName: collectionFavorites,
        );

  /// Provides a [Stream] of all movies.
  Stream<List<MovieItem>> getMovies() => _storage.getMovies().map(
        (list) => list.map((movie) => MovieItem.fromStorage(movie)).toList(),
      );

  /// Saves a [movie].
  ///
  /// If a [movie] with the same id already exists, it will be replaced.
  Future<void> saveTodo(MovieItem movie) => _storage.saveMovie(
        MovieItemEntity(movie.id, movie.posterPath, movie.title, movie.rate),
      );

  /// Deletes the movie with the given id.
  ///
  /// If no movie with the given id exists, a [MovieNotFoundException] error is
  /// thrown.
  Future<void> deleteMovie(String movieId) => _storage.deleteMovie(movieId);

  /// Sets the `isCompleted` state of all movies to the given value.
  ///
  /// Returns the number of updated movies.
  Future<void> clearAllMovies() => _storage.clearAll();

  Future<bool> checkWhetherIsMarkedOrNot(String movieId) =>
      _storage.checkWhetherIsMarkedOrNot(movieId);

  void close() {
    _storage.close();
  }
}
