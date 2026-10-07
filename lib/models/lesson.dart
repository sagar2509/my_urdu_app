import 'package:flutter/material.dart';
import 'urdu_char.dart';
import 'urdu_word.dart';

/// A single unit of content inside a [Module]. Sealed so each module can
/// contribute a different kind of exercise (browsing glyphs, writing
/// words, ...) while navigation code stays exhaustive and compiler-checked
/// — adding a new variant forces every `switch` that handles it to be updated.
sealed class Lesson {
  final String id;
  final String title;
  final IconData icon;

  const Lesson({required this.id, required this.title, required this.icon});
}

/// A list of glyphs the learner browses and can quiz themselves on
/// (e.g. "Basics", "Numbers") — Module 1's lesson type.
class CharLesson extends Lesson {
  final List<UrduChar> Function() charsBuilder;

  /// Whether search/filter UI applies (e.g. the full alphabet list
  /// benefits from filtering; a short list like Numbers doesn't).
  final bool showFilters;

  /// Text direction the grid should render in.
  final TextDirection direction;

  const CharLesson({
    required super.id,
    required super.title,
    required super.icon,
    required this.charsBuilder,
    this.showFilters = false,
    this.direction = TextDirection.rtl,
  });

  List<UrduChar> get chars => charsBuilder();
}

/// A browsable list of words the learner can study before being tested on
/// them — shows each word's letter-by-letter breakdown and its English/Hindi
/// meaning. Pairs with a [WritingLesson] the same way Module 1's CharLessons
/// pair with a quiz: learn first, then practice.
class WordLesson extends Lesson {
  final List<UrduWord> Function() wordsBuilder;

  /// The [WritingLesson.id] of the companion practice exercise over the
  /// same words, if any — lets the screen offer a "Practice" shortcut.
  final String? practiceLessonId;

  const WordLesson({
    required super.id,
    required super.title,
    required super.icon,
    required this.wordsBuilder,
    this.practiceLessonId,
  });

  List<UrduWord> get words => wordsBuilder();
}

/// A set of words the learner must write in Urdu given an English or Hindi
/// prompt, typed with the device's own Urdu keyboard — Module 2's lesson type.
class WritingLesson extends Lesson {
  final List<UrduWord> Function() wordsBuilder;

  const WritingLesson({
    required super.id,
    required super.title,
    required super.icon,
    required this.wordsBuilder,
  });

  List<UrduWord> get words => wordsBuilder();
}

/// A group of related [Lesson]s, shown as a section in the app drawer.
/// Adding a new Module only requires adding an entry to the module
/// registry — no changes to app shell code.
class Module {
  final String id;
  final String title;
  final IconData icon;
  final List<Lesson> lessons;

  const Module({
    required this.id,
    required this.title,
    required this.icon,
    required this.lessons,
  });
}
