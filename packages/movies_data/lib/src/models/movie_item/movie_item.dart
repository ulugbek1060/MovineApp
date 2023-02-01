import 'package:equatable/equatable.dart';

class MovieItem extends Equatable {
  final String id;
  final String title;
  final String rate;
  final String language;
  final String posterPath;

  MovieItem({
    required this.id,
    required this.title,
    required this.rate,
    required this.language,
    required this.posterPath,
  });

  @override
  String toString() => {
        'id': id,
        'title': title,
        'rate': rate,
        'language': language,
        'posterPath': posterPath,
      }.toString();

  @override
  List<Object?> get props => [
        id,
        title,
        rate,
        language,
        posterPath,
      ];
}
