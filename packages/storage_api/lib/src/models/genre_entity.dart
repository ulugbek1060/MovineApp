import 'package:equatable/equatable.dart';

class GenreEntity extends Equatable {
  final String name;
  final String id;
  final bool isSelected;

  const GenreEntity({
    required this.name,
    required this.id,
    this.isSelected = false,
  });

  GenreEntity changeFlag() {
    return GenreEntity(
      name: name,
      id: id,
      isSelected: !isSelected,
    );
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['is_selected'] = isSelected;
    return map;
  }

  @override
  List<Object?> get props => [id, name, isSelected];
}
