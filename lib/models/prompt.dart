class Prompt {
  final String id;
  final String title;
  final String content;
  final String category;
  final bool isFavorite;

  const Prompt({
    required this.id,
    required this.title,
    required this.content,
    required this.category,
    this.isFavorite = false,
  });
}