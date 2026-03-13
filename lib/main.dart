import 'package:flutter/material.dart';
import 'models/prompt.dart';
import 'widgets/prompt_card.dart';
import 'screens/add_prompt_screen.dart';
import 'screens/prompt_detail_screen.dart';
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
  final TextEditingController _searchController = TextEditingController();

  List<Prompt> prompts = [];
  String searchQuery = '';

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

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
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

  Future<void> openPromptDetailScreen(Prompt prompt) async {
    final shouldDelete = await Navigator.push<bool>(
      context,
      MaterialPageRoute(
        builder: (context) => PromptDetailScreen(prompt: prompt),
      ),
    );

    if (shouldDelete == true) {
      setState(() {
        prompts = prompts.where((item) => item.id != prompt.id).toList();
      });

      savePrompts();
    }
  }

  void updateSearchQuery(String value) {
    setState(() {
      searchQuery = value.trim().toLowerCase();
    });
  }

  List<Prompt> get filteredPrompts {
    if (searchQuery.isEmpty) {
      return prompts;
    }

    return prompts.where((prompt) {
      final title = prompt.title.toLowerCase();
      final category = prompt.category.toLowerCase();
      final content = prompt.content.toLowerCase();

      return title.contains(searchQuery) ||
          category.contains(searchQuery) ||
          content.contains(searchQuery);
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final visiblePrompts = filteredPrompts;

    return Scaffold(
      appBar: AppBar(
        title: const Text('AI Prompt Vault'),
      ),
      body: prompts.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(12, 12, 12, 8),
                  child: TextField(
                    controller: _searchController,
                    onChanged: updateSearchQuery,
                    decoration: InputDecoration(
                      hintText: 'Search prompts...',
                      prefixIcon: const Icon(Icons.search),
                      suffixIcon: searchQuery.isNotEmpty
                          ? IconButton(
                              onPressed: () {
                                _searchController.clear();
                                updateSearchQuery('');
                              },
                              icon: const Icon(Icons.clear),
                            )
                          : null,
                      border: const OutlineInputBorder(),
                    ),
                  ),
                ),
                Expanded(
                  child: visiblePrompts.isEmpty
                      ? const Center(
                          child: Text('No prompts match your search.'),
                        )
                      : ListView.builder(
                          itemCount: visiblePrompts.length,
                          itemBuilder: (context, index) {
                            final prompt = visiblePrompts[index];

                            return PromptCard(
                              prompt: prompt,
                              onFavoriteToggle: () {
                                toggleFavorite(prompt.id);
                              },
                              onTap: () {
                                openPromptDetailScreen(prompt);
                              },
                            );
                          },
                        ),
                ),
              ],
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: openAddPromptScreen,
        child: const Icon(Icons.add),
      ),
    );
  }
}