import 'package:flutter/material.dart';

class UrduChar {
  final String glyph;
  final String phonetic;
  final bool isDelta;
  final String family; // e.g., "boat", "hook", "angle"
  final String? initial;
  final String? middle;
  final String? finalForm;

  UrduChar({
    required this.glyph,
    required this.phonetic,
    this.isDelta = false,
    required this.family,
    this.initial,
    this.middle,
    this.finalForm,
  });

  // Helper logic to get a color based on family
  Color get familyColor {
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
      default:
        return Colors.grey.shade100;
    }
  }
}
