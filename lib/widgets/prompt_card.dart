import 'package:flutter/material.dart';
import '../models/prompt.dart';

class PromptCard extends StatelessWidget {
  final Prompt prompt;

  const PromptCard({
    super.key,
    required this.prompt,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: ListTile(
        contentPadding: const EdgeInsets.all(12),
        leading: Icon(
          prompt.isFavorite ? Icons.star : Icons.chat_bubble_outline,
          color: prompt.isFavorite ? Colors.amber : Colors.grey,
        ),
        title: Text(
          prompt.title,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 6),
          child: Text('${prompt.category} • ${prompt.content}'),
        ),
        trailing: const Icon(Icons.chevron_right),
      ),
    );
  }
}