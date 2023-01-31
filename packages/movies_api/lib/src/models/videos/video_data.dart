class Results {
  late final String? iso6391;
  late final String? iso31661;
  late final String? name;
  late final String? key;
  late final String? site;
  late final int? size;
  late final String? type;
  late final bool? official;
  late final String? publishedAt;
  late final String? id;

  Results({
    required this.iso6391,
    required this.iso31661,
    required this.name,
    required this.key,
    required this.site,
    required this.size,
    required this.type,
    required this.official,
    required this.publishedAt,
    required this.id,
  });

  Results.fromJson(dynamic json)
      : iso6391 = json['iso_639_1'],
        iso31661 = json['iso_3166_1'],
        name = json['name'],
        key = json['key'],
        site = json['site'],
        size = json['size'],
        type = json['type'],
        official = json['official'],
        publishedAt = json['published_at'],
        id = json['id'];


  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['iso_639_1'] = iso6391;
    map['iso_3166_1'] = iso31661;
    map['name'] = name;
    map['key'] = key;
    map['site'] = site;
    map['size'] = size;
    map['type'] = type;
    map['official'] = official;
    map['published_at'] = publishedAt;
    map['id'] = id;
    return map;
  }
}
