import 'package:equatable/equatable.dart';

class Videos extends Equatable {
  final String id;
  final List<VideoItem> videos;

  Videos({
    required this.id,
    required this.videos,
  });

  @override
  String toString() => {
        'id': id,
        'videos': videos,
      }.toString();

  @override
  List<Object?> get props => [id, videos];
}

class VideoItem extends Equatable{
  final String id;
  final String size;
  final String key;

  VideoItem({
    required this.id,
    required this.size,
    required this.key,
  });

  @override
  String toString() => {
        'id': id,
        'key': key,
        'size': size,
      }.toString();

  @override
  List<Object?> get props => [id, key, size];
}
