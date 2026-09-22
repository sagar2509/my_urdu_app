import 'package:flutter/material.dart';
import 'urdu_char.dart';

/// A single unit of content inside a [Module] — a list of glyphs the
/// learner browses and can quiz themselves on (e.g. "Basics", "Numbers").
class Lesson {
  final String id;
  final String title;
  final IconData icon;
  final List<UrduChar> Function() charsBuilder;

  /// Whether search/filter UI applies to this lesson (e.g. the full
  /// alphabet list benefits from filtering; a short list like Numbers doesn't).
  final bool showFilters;

  /// Text direction the grid should render in.
  final TextDirection direction;

  const Lesson({
    required this.id,
    required this.title,
    required this.icon,
    required this.charsBuilder,
    this.showFilters = false,
    this.direction = TextDirection.rtl,
  });

  List<UrduChar> get chars => charsBuilder();
}

/// A group of related [Lesson]s, shown as a section in the app drawer.
/// Adding a new Module (e.g. "Words", "Sentences") only requires adding
/// an entry to the module registry — no changes to app shell code.
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
