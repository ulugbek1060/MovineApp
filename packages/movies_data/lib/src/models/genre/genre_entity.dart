import 'package:movies_data/src/models/genre/genre_item.dart';

class GenreEntity {
  final List<GenreItem>? genres;
  final Object? error;

  GenreEntity({
    this.genres,
    this.error,
  });

  @override
  String toString() => {
        'genres': genres,
        'error': error,
      }.toString();
}
