


class Debate {
  final String id;
  final String title;
  final String description;
  bool isBookmarked;

  Debate({
    required this.id,
    required this.title,
    required this.description,
    this.isBookmarked = false,
  });
}
