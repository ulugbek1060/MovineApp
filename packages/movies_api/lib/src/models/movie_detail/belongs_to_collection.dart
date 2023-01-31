part of 'movie_detail_response.dart';

class BelongsToCollection {
  late final int? id;
  late final String? name;
  late final String? posterPath;
  late final String? backdropPath;

  BelongsToCollection({
    this.id,
    this.name,
    this.posterPath,
    this.backdropPath,
  });

  BelongsToCollection.fromJson(Map<String, dynamic> json):
    id = json['id'],
    name = json['name'],
    posterPath = json['poster_path'],
    backdropPath = json['backdrop_path'];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['poster_path'] = this.posterPath;
    data['backdrop_path'] = this.backdropPath;
    return data;
  }
}
