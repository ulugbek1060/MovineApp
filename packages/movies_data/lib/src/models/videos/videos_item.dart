class Videos {
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
}

class VideoItem {
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
}
