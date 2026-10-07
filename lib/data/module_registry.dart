import 'package:flutter/material.dart';
import '../models/lesson.dart';
import 'char_registry.dart';
import 'word_registry.dart';

/// Single source of truth for the app's content: Modules -> Lessons.
///
/// To add a new module, append a [Module] here — the drawer and navigation
/// pick it up automatically, no other changes needed.
class ModuleRegistry {
  static final List<Module> modules = [
    Module(
      id: 'module_1',
      title: 'Module 1: Alphabet',
      icon: Icons.book,
      lessons: [
        CharLesson(
          id: 'alphabet',
          title: 'Alphabet',
          icon: Icons.sort_by_alpha,
          charsBuilder: () => CharRegistry.masterList,
          showFilters: true,
        ),
        CharLesson(
          id: 'numbers',
          title: 'Urdu Numbers',
          icon: Icons.numbers,
          charsBuilder: () => CharRegistry.urduNumbers,
          direction: TextDirection.ltr,
        ),
      ],
    ),
    Module(
      id: 'module_2',
      title: 'Module 2: Words',
      icon: Icons.menu_book,
      lessons: [
        WordLesson(
          id: 'common_words_learn',
          title: 'Learn: Common Words',
          icon: Icons.menu_book,
          wordsBuilder: () => WordRegistry.commonWords,
          practiceLessonId: 'common_words_practice',
        ),
        WritingLesson(
          id: 'common_words_practice',
          title: 'Practice: Write Common Words',
          icon: Icons.edit,
          wordsBuilder: () => WordRegistry.commonWords,
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
