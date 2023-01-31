class GenreItem {
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
}
