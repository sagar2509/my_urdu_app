import 'package:flutter/material.dart';
import 'urdu_char.dart' show colorForFamily;

/// A short Urdu word used in a [WritingLesson] assignment, with its
/// meaning in English and Hindi so a prompt can be shown in either.
class UrduWord {
  final String urdu;
  final String english;
  final String hindi;

  /// Purely cosmetic — cycles through the same palette [UrduChar] uses so
  /// the word list looks as colorful as the alphabet grid.
  final String family;

  const UrduWord({
    required this.urdu,
    required this.english,
    required this.hindi,
    this.family = 'default',
  });

  /// A stable identity for progress tracking.
  String get id => urdu;

  Color get familyColor => colorForFamily(family);
}
