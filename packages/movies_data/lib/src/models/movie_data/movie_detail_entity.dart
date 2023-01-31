import 'package:movies_data/src/models/movie_data/movie_detail.dart';

class MovieDetailEntity {
  final MovieDetail? movieDetail;
  final Object? error;

  MovieDetailEntity({
    this.movieDetail,
    this.error,
  });

  @override
  String toString() => {
        'movieDetail': movieDetail,
        'error': error,
      }.toString();
}
