import 'package:equatable/equatable.dart';

class GenreItem extends Equatable {
  final int id;
  final String name;

  GenreItem({
    required this.id,
    required this.name,
  });

  @override
  String toString() => {
        'id': id,
        'name': name,
      }.toString();

  @override
  List<Object?> get props => [id, name];
}
