import 'package:hive/hive.dart';
import 'package:rxdart/rxdart.dart';
import 'package:storage_api/storage_api.dart';

class GenresStorageApiImpl extends GenresStorageApi {
  GenresStorageApiImpl({
    required this.boxCollection,
    required String collectionName,
  }) {
    _init(collectionName);
  }

  final BoxCollection boxCollection;
  late CollectionBox genresCollection;
  final _genresStreamController = BehaviorSubject<Set<GenreEntity>>.seeded({});

  void _init(String collectionName) async {
    genresCollection = await boxCollection.openBox(collectionName);
    final map = await genresCollection.getAllValues();
    if (map.isNotEmpty) {
      final genres = <GenreEntity>{};
      map.values.forEach((e) {
        genres.add(GenreEntity(
            name: e['name'], id: e['id'], isSelected: e['is_selected']));
      });
      _genresStreamController.add(genres);
    } else {
      _genresStreamController.add({});
    }
  }

  @override
  Stream<Set<GenreEntity>> getGenres() => _genresStreamController;

  @override
  Future<void> saveListOfGenres(Set<GenreEntity> genres) async {
    final values = _genresStreamController.value;
    final ids = values.map((e) => e.id);
    final newValues = <GenreEntity>{};
    genres.forEach((genre) {
      if (!ids.contains(genre.id)) {
        genresCollection.put(genre.id, genre.toJson());
        newValues.add(genre);
      }
    });
    _genresStreamController.add({...values, ...newValues});
  }

  @override
  Future<void> changeFlag(GenreEntity genre) async {
    final newGenre = genre.changeFlag();
    await genresCollection.put(newGenre.id, newGenre.toJson());
    final values = _genresStreamController.value.toList();
    final index = values.indexWhere((e) => e.id == genre.id);
    if (index >= 0) {
      values[index] = newGenre;
      _genresStreamController.add({...values});
    } else {
      throw GenreNotFoundException();
    }
  }

  /// throws [Set] Iterable no element error
  @override
  Future<void> deleteGenre(String id) async {
    final values = {..._genresStreamController.value};
    final genre = values.lastWhere((e) => e.id == id);
    values.remove(genre);
    _genresStreamController.add(values);
    await genresCollection.delete(id);
  }

  @override
  Future<void> clearGenre() async {
    await genresCollection.clear();
    _genresStreamController.add({});
  }

  @override
  void close() {
    _genresStreamController.close();
  }
}
