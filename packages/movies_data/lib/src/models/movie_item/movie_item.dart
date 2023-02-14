import 'package:equatable/equatable.dart';
import 'package:storage_api/storage_api.dart';

class MovieItem extends Equatable {
  final String id;
  final String title;
  final String rate;
  final String posterPath;
  final String backdropPath;

  MovieItem({
    required this.id,
    required this.title,
    required this.rate,
    required this.posterPath,
    required this.backdropPath,
  });

  MovieItem.fromStorage(MovieItemEntity entity)
      : this.id = entity.id,
        this.title = entity.title,
        this.posterPath = entity.posterPath,
        this.rate = entity.rating,
        this.backdropPath = entity.backdropPath ?? '';

  @override
  List<Object?> get props => [id, title, rate, posterPath, backdropPath];
}
