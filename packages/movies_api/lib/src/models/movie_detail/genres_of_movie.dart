part of 'movie_detail_response.dart';

class GenreOfMovie {
  late final int? id;
  late final String? name;

  GenreOfMovie({
    this.id,
    this.name,
  });

  GenreOfMovie.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    return data;
  }
}
