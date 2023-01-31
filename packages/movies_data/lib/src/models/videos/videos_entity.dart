import 'package:movies_data/src/models/videos/videos_item.dart';

class VideosEntity {
  final Videos? videos;
  final Object? error;

  VideosEntity({this.videos, this.error});

  @override
  String toString() => {
        'videos': videos,
        'error': error,
      }.toString();
}
