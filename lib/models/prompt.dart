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

  Prompt copyWith({
    String? id,
    String? title,
    String? content,
    String? category,
    bool? isFavorite,
  }) {
    return Prompt(
      id: id ?? this.id,
      title: title ?? this.title,
      content: content ?? this.content,
      category: category ?? this.category,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }
}