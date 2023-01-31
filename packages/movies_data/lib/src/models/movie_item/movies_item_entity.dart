import 'package:movies_data/src/models/movie_item/movie_item.dart';

class MovieItemEntity {
  final List<MovieItem>? movies;
  final int? totalPages;
  final int? page;
  final Object? error;

  MovieItemEntity({
    this.movies,
    this.totalPages,
    this.page,
    this.error,
  });

  @override
  String toString() => {
        'movies': movies,
        'totalPage': totalPages,
        'page': page,
        'error': error,
      }.toString();
}
