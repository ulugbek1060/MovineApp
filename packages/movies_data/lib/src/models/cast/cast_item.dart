import 'package:equatable/equatable.dart';

class CastItem extends Equatable {

  final int? gender;
  final int? id;
  final String? originalName;
  final double? popularity;
  final String? profilePath;
  final int? castId;
  final String? character;
  final String? creditId;
  final int? order;

  CastItem(
      {this.gender,
      this.id,
      this.originalName,
      this.popularity,
      this.profilePath,
      this.castId,
      this.character,
      this.creditId,
      this.order});

  @override
  List<Object?> get props => [
        gender,
        id,
        originalName,
        popularity,
        profilePath,
        castId,
        character,
        creditId,
        order,
      ];
}
