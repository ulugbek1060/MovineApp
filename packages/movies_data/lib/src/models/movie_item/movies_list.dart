import 'package:equatable/equatable.dart';

import 'movie_item.dart';

class MoviesList extends Equatable {
  final List<MovieItem>? movies;
  final int? page;
  final int? totalPages;

  MoviesList({
    this.movies,
    this.totalPages,
    this.page,
  });

  MoviesList replaceWith({required MoviesList newData}) {
    return MoviesList(
      movies: [...movies ?? [], ...newData.movies ?? []],
      page: newData.page ?? this.page,
      totalPages: newData.totalPages ?? this.totalPages,
    );
  }

  @override
  String toString() => {
        'movies': movies,
        'totalPages': totalPages,
        'page': page,
      }.toString();

  @override
  List<Object?> get props => [
        movies,
        page,
        totalPages,
      ];
}
