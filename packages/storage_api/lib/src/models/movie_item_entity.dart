import 'package:equatable/equatable.dart';

const keyId = 'id';
const keyTitle = 'title';
const keyPosterPath = 'poster_path';
const keyRating = 'rating';

class MovieItemEntity extends Equatable {
  final String id;
  final String posterPath;
  final String title;
  final String rating;

  const MovieItemEntity(this.id, this.posterPath, this.title, this.rating);

  MovieItemEntity.fromJson(Map<String, dynamic> json)
      : id = json[keyId],
        posterPath = json[keyPosterPath],
        title = json[keyTitle],
        rating = json[keyRating];

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map[keyId] = id;
    map[keyPosterPath] = posterPath;
    map[keyTitle] = title;
    map[keyRating] = rating;
    return map;
  }

  @override
  List<Object?> get props => [id, posterPath, title, rating];
}
