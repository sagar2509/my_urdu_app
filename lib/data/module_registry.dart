import 'package:flutter/material.dart';
import '../models/lesson.dart';
import '../models/urdu_char.dart';
import 'char_registry.dart';
import 'word_registry.dart';

/// Single source of truth for the app's content: Modules -> Lessons.
///
/// To add a new module, append a [Module] here — the drawer and navigation
/// pick it up automatically, no other changes needed.
class ModuleRegistry {
  static List<UrduChar> _basics() => CharRegistry.masterList
      .where((c) => CharRegistry.baseShapeGlyphs.contains(c.glyph))
      .toList();

  static List<UrduChar> _advanced() => CharRegistry.masterList
      .where((c) => !CharRegistry.baseShapeGlyphs.contains(c.glyph))
      .toList();

  static final List<Module> modules = [
    Module(
      id: 'module_1',
      title: 'Module 1: Alphabet',
      icon: Icons.book,
      lessons: [
        CharLesson(
          id: 'basics',
          title: 'Basics',
          icon: Icons.architecture,
          charsBuilder: _basics,
        ),
        CharLesson(
          id: 'advanced',
          title: 'Advanced',
          icon: Icons.auto_awesome,
          charsBuilder: _advanced,
        ),
        CharLesson(
          id: 'numbers',
          title: 'Urdu Numbers',
          icon: Icons.numbers,
          charsBuilder: () => CharRegistry.urduNumbers,
          direction: TextDirection.ltr,
        ),
        CharLesson(
          id: 'master_list',
          title: 'Complete Alphabet',
          icon: Icons.format_list_bulleted,
          charsBuilder: () => CharRegistry.masterList,
          showFilters: true,
        ),
      ],
    ),
    Module(
      id: 'module_2',
      title: 'Module 2: Words',
      icon: Icons.menu_book,
      lessons: [
        WritingLesson(
          id: 'two_letter_words',
          title: 'Two-Letter Words',
          icon: Icons.edit,
          wordsBuilder: () => WordRegistry.twoLetterWords,
        ),
      ],
    ),
  ];

  /// Flat list of every lesson across every module — used for global lookups
  /// (e.g. quiz distractor pools) without callers needing to know the module tree.
  static List<Lesson> get allLessons => modules.expand((m) => m.lessons).toList();

  static Lesson? findLesson(String lessonId) {
    for (final lesson in allLessons) {
      if (lesson.id == lessonId) return lesson;
    }
    return null;
  }
}
