import 'package:flutter/material.dart';

class LetterModel {
  final String id;
  final String character;
  final String name;
  final String nameEn;
  final Map<String, String> harakat;
  final String emoji;
  final String exampleWord;
  final String exampleWordEn;
  final int level;
  final Color color;
  final bool isArabic;
  
  LetterModel({
    required this.id,
    required this.character,
    required this.name,
    required this.nameEn,
    required this.harakat,
    required this.emoji,
    required this.exampleWord,
    required this.exampleWordEn,
    required this.level,
    required this.color,
    required this.isArabic,
  });
  
  factory LetterModel.fromJson(Map<String, dynamic> json) {
    return LetterModel(
      id: json['id'] ?? '',
      character: json['char'] ?? '',
      name: json['name'] ?? '',
      nameEn: json['nameEn'] ?? '',
      harakat: Map<String, String>.from(json['harakat'] ?? {}),
      emoji: json['emoji'] ?? '',
      exampleWord: json['exampleWord'] ?? '',
      exampleWordEn: json['exampleWordEn'] ?? '',
      level: json['level'] ?? 1,
      color: Color(int.parse(json['color']?.replaceAll('#', '0xFF') ?? '0xFFFF6B6B')),
      isArabic: json['isArabic'] ?? true,
    );
  }
  
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'char': character,
      'name': name,
      'nameEn': nameEn,
      'harakat': harakat,
      'emoji': emoji,
      'exampleWord': exampleWord,
      'exampleWordEn': exampleWordEn,
      'level': level,
      'color': '#${color.value.toRadixString(16).substring(2)}',
      'isArabic': isArabic,
    };
  }
  
  // الحصول على الحرف مع حركة معينة
  String getCharWithHaraka(String haraka) {
    return harakat[haraka] ?? character;
  }
  
  // قائمة الحركات المتاحة
  List<String> get availableHarakat => harakat.keys.toList();

  // النص الذي يجب نطقه لتعليم "صوت" الحرف (وليس اسمه)
  // عربي: الحرف بحركة الفتحة (مثلاً "بَ" بدل "باء") وهو أساس تعليم القراءة الصوتي
  // إنجليزي: تقريب صوتي مكتوب بالحروف (مثلاً "buh" لحرف B) لأن رموز IPA
  // المخزّنة في harakat['sound'] لا يمكن أن تُنطق حرفياً عبر محرك TTS عادي
  String get spokenSound {
    if (isArabic) {
      return harakat['fatha'] ?? character;
    }
    return _englishPhonicsSounds[id.toLowerCase()] ?? character;
  }

  static const Map<String, String> _englishPhonicsSounds = {
    'a': 'ahh',
    'b': 'buh',
    'c': 'kuh',
    'd': 'duh',
    'e': 'ehh',
    'f': 'fff',
    'g': 'guh',
    'h': 'huh',
    'i': 'ihh',
    'j': 'juh',
    'k': 'kuh',
    'l': 'lll',
    'm': 'mmm',
    'n': 'nnn',
    'o': 'ahh',
    'p': 'puh',
    'q': 'kwuh',
    'r': 'rrr',
    's': 'sss',
    't': 'tuh',
    'u': 'uhh',
    'v': 'vvv',
    'w': 'wuh',
    'x': 'ks',
    'y': 'yuh',
    'z': 'zzz',
  };
}