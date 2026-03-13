import 'package:flutter/material.dart';
import 'models/prompt.dart';
import 'widgets/prompt_card.dart';
import 'screens/add_prompt_screen.dart';
import 'services/storage_service.dart';

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

class PromptListScreen extends StatefulWidget {
  const PromptListScreen({super.key});

  @override
  State<PromptListScreen> createState() => _PromptListScreenState();
}

class _PromptListScreenState extends State<PromptListScreen> {
  final StorageService _storageService = StorageService();

  List<Prompt> prompts = [];

  final List<Prompt> defaultPrompts = const [
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
  void initState() {
    super.initState();
    loadPrompts();
  }

  Future<void> loadPrompts() async {
    final savedPrompts = await _storageService.loadPrompts();

    setState(() {
      prompts = savedPrompts.isNotEmpty ? savedPrompts : defaultPrompts;
    });
  }

  Future<void> savePrompts() async {
    await _storageService.savePrompts(prompts);
  }

  void toggleFavorite(String promptId) {
    setState(() {
      prompts = prompts.map<Prompt>((prompt) {
        if (prompt.id == promptId) {
          return prompt.copyWith(isFavorite: !prompt.isFavorite);
        }
        return prompt;
      }).toList();
    });

    savePrompts();
  }

  Future<void> openAddPromptScreen() async {
    final newPrompt = await Navigator.push<Prompt>(
      context,
      MaterialPageRoute(
        builder: (context) => const AddPromptScreen(),
      ),
    );

    if (newPrompt != null) {
      setState(() {
        prompts = [newPrompt, ...prompts];
      });

      savePrompts();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AI Prompt Vault'),
      ),
      body: prompts.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: prompts.length,
              itemBuilder: (context, index) {
                final prompt = prompts[index];

                return PromptCard(
                  prompt: prompt,
                  onFavoriteToggle: () {
                    toggleFavorite(prompt.id);
                  },
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: openAddPromptScreen,
        child: const Icon(Icons.add),
      ),
    );
  }
}