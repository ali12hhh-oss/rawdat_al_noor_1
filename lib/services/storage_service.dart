import 'dart:convert';
import 'package:flutter/services.dart';
import '../models/letter_model.dart';
import '../models/word_model.dart';
import '../models/story_model.dart';
import '../models/level_model.dart';

class StorageService {
  static final StorageService _instance = StorageService._internal();
  factory StorageService() => _instance;
  StorageService._internal();

  // ====== تحميل البيانات من ملفات JSON ======

  Future<List<LetterModel>> loadArabicLetters() async {
    try {
      String jsonString = await rootBundle.loadString('assets/json/arabic_letters.json');
      Map<String, dynamic> jsonData = json.decode(jsonString);
      List<dynamic> lettersJson = jsonData['letters'] ?? [];
      return lettersJson.map((json) => LetterModel.fromJson(json)).toList();
    } catch (e) {
      return [];
    }
  }

  Future<List<LetterModel>> loadEnglishLetters() async {
    try {
      String jsonString = await rootBundle.loadString('assets/json/english_letters.json');
      Map<String, dynamic> jsonData = json.decode(jsonString);
      List<dynamic> lettersJson = jsonData['letters'] ?? [];
      return lettersJson.map((json) => LetterModel.fromJson(json)).toList();
    } catch (e) {
      return [];
    }
  }

  Future<List<WordModel>> loadWords() async {
    try {
      String jsonString = await rootBundle.loadString('assets/json/words.json');
      Map<String, dynamic> jsonData = json.decode(jsonString);
      List<dynamic> wordsJson = jsonData['words'] ?? [];
      return wordsJson.map((json) => WordModel.fromJson(json)).toList();
    } catch (e) {
      return [];
    }
  }

  Future<List<StoryModel>> loadStories() async {
    try {
      String jsonString = await rootBundle.loadString('assets/json/stories.json');
      Map<String, dynamic> jsonData = json.decode(jsonString);
      List<dynamic> storiesJson = jsonData['stories'] ?? [];
      return storiesJson.map((json) => StoryModel.fromJson(json)).toList();
    } catch (e) {
      return [];
    }
  }

  Future<List<LevelModel>> loadLevels() async {
    try {
      String jsonString = await rootBundle.loadString('assets/json/levels.json');
      Map<String, dynamic> jsonData = json.decode(jsonString);
      List<dynamic> levelsJson = jsonData['levels'] ?? [];
      return levelsJson.map((json) => LevelModel.fromJson(json)).toList();
    } catch (e) {
      return [];
    }
  }

}
