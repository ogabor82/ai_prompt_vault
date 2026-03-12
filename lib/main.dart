import 'package:flutter/material.dart';
import 'models/prompt.dart';
import 'widgets/prompt_card.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AI Prompt Vault',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
      ),
      home: const PromptListScreen(),
    );
  }
}

class PromptListScreen extends StatelessWidget {
  const PromptListScreen({super.key});

  final List<Prompt> prompts = const [
    Prompt(
      id: '1',
      title: 'Blog post intro generator',
      content: 'Write 5 engaging introductions for a blog post about AI tools.',
      category: 'Writing',
      isFavorite: true,
    ),
    Prompt(
      id: '2',
      title: 'Fantasy character creator',
      content: 'Generate a fantasy character with backstory, flaws, and goals.',
      category: 'Creative',
    ),
    Prompt(
      id: '3',
      title: 'React code reviewer',
      content: 'Review this React component for readability and performance.',
      category: 'Coding',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AI Prompt Vault'),
      ),
      body: ListView.builder(
        itemCount: prompts.length,
        itemBuilder: (context, index) {
          final prompt = prompts[index];
          return PromptCard(prompt: prompt);
        },
      ),
    );
  }
}