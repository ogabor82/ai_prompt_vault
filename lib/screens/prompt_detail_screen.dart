import 'package:flutter/material.dart';
import '../models/prompt.dart';

class PromptDetailScreen extends StatelessWidget {
  final Prompt prompt;

  const PromptDetailScreen({
    super.key,
    required this.prompt,
  });

  void _deletePrompt(BuildContext context) {
    Navigator.pop(context, true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Prompt Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              prompt.title,
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                const Icon(Icons.folder_outlined, size: 18),
                const SizedBox(width: 8),
                Text(
                  prompt.category,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Icon(
                  prompt.isFavorite ? Icons.star : Icons.star_border,
                  color: prompt.isFavorite ? Colors.amber : Colors.grey,
                ),
                const SizedBox(width: 8),
                Text(
                  prompt.isFavorite ? 'Favorite prompt' : 'Not favorite',
                ),
              ],
            ),
            const SizedBox(height: 24),
            Text(
              'Prompt Content',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 8),
            Expanded(
              child: SingleChildScrollView(
                child: Text(
                  prompt.content,
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ),
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: FilledButton.icon(
                onPressed: () => _deletePrompt(context),
                icon: const Icon(Icons.delete_outline),
                label: const Text('Delete Prompt'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}