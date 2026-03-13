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

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'content': content,
      'category': category,
      'isFavorite': isFavorite,
    };
  }

  factory Prompt.fromJson(Map<String, dynamic> json) {
    return Prompt(
      id: json['id'] as String,
      title: json['title'] as String,
      content: json['content'] as String,
      category: json['category'] as String,
      isFavorite: json['isFavorite'] as bool? ?? false,
    );
  }
}