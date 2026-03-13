import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/prompt.dart';

class StorageService {
  static const _promptsKey = 'saved_prompts';

  Future<void> savePrompts(List<Prompt> prompts) async {
    final prefs = await SharedPreferences.getInstance();

    final jsonList = prompts.map((prompt) => prompt.toJson()).toList();
    final jsonString = jsonEncode(jsonList);

    await prefs.setString(_promptsKey, jsonString);
  }

  Future<List<Prompt>> loadPrompts() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString(_promptsKey);

    if (jsonString == null || jsonString.isEmpty) {
      return [];
    }

    final List<dynamic> decoded = jsonDecode(jsonString);

    return decoded
        .map<Prompt>((item) => Prompt.fromJson(item as Map<String, dynamic>))
        .toList();
  }
}