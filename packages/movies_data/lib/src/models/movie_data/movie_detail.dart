import 'package:equatable/equatable.dart';

class MovieDetail extends Equatable {
  final String id;
  final String title;
  final String poserPath;
  final String backdropPath;
  final String quality;
  final String duration;
  final String rating;
  final String releaseData;
  final List<String> genres;
  final String overview;
  final String language;

  MovieDetail({
    required this.id,
    required this.title,
    required this.poserPath,
    required this.backdropPath,
    required this.quality,
    required this.duration,
    required this.rating,
    required this.releaseData,
    required this.genres,
    required this.overview,
    required this.language,
  });

  @override
  String toString() => {
        'id': id,
        'title': title,
        'posterPath': poserPath,
        'backdropPath': backdropPath,
        'quality': quality,
        'duration': duration,
        'rating': rating,
        'releaseDate': releaseData,
        'genres': genres,
        'overview': overview,
        'language': language,
      }.toString();

  @override
  List<Object?> get props => [
        id,
        title,
        poserPath,
        backdropPath,
        quality,
        duration,
        rating,
        releaseData,
        genres,
        overview,
        language,
      ];
}
