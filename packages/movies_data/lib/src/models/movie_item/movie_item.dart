import 'package:equatable/equatable.dart';

class MovieItem extends Equatable {
  final String id;
  final String title;
  final String rate;
  final String posterPath;

  MovieItem({
    required this.id,
    required this.title,
    required this.rate,
    required this.posterPath,
  });

  @override
  String toString() => {
        'id': id,
        'title': title,
        'rate': rate,
        'posterPath': posterPath,
      }.toString();

  @override
  List<Object?> get props => [
        id,
        title,
        rate,
        posterPath,
      ];
}
