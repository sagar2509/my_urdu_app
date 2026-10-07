import 'package:flutter/material.dart';

/// Maps a content "family" tag to a pastel card color. Shared by [UrduChar]
/// (grouped by shared base-glyph shape) and [UrduWord] (just cycled for
/// visual variety) so both grids feel like the same colorful system.
Color colorForFamily(String family) {
  switch (family) {
    case 'alif':
      return Colors.red.shade50;
    case 'boat':
      return Colors.blue.shade50;
    case 'hook':
      return Colors.green.shade50;
    case 'angle':
      return Colors.orange.shade50;
    case 'slide':
      return Colors.purple.shade50;
    case 'stick':
      return Colors.teal.shade50;
    case 'loop':
      return Colors.yellow.shade50;
    case 'oval':
      return Colors.pink.shade50;
    case 'vertical':
      return Colors.cyan.shade50;
    case 'ccurve':
      return Colors.lime.shade50;
    case 'round':
      return Colors.indigo.shade50;
    case 'hooked_stick':
      return Colors.brown.shade50;
    case 'vessel':
      return Colors.grey.shade50;
    case 'curve':
      return Colors.amber.shade50;
    case 'number':
      return Colors.blueGrey.shade50;
    case 'hamza':
      return Colors.deepOrange.shade50;
    default:
      return Colors.grey.shade100;
  }
}

/// A single Urdu alphabet letter or number glyph and its learning metadata.
class UrduChar {
  final String glyph;
  final String phonetic;
  final String hindi;
  final bool isDelta;
  final String family; // e.g., "boat", "hook", "angle"
  final String? initial;
  final String? middle;
  final String? finalForm;

  const UrduChar({
    required this.glyph,
    required this.phonetic,
    required this.hindi,
    this.isDelta = false,
    required this.family,
    this.initial,
    this.middle,
    this.finalForm,
  });

  /// Whether this glyph has distinct positional (initial/middle/final) forms.
  /// Numbers and other non-letter glyphs don't.
  bool get hasPositionalForms => initial != null || middle != null || finalForm != null;

  /// A stable identity for progress tracking and quiz lookups.
  String get id => glyph;

  Color get familyColor => colorForFamily(family);
}
