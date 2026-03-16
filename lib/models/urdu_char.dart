import 'package:flutter/material.dart';

class UrduChar {
  final String glyph;
  final String phonetic;
  final bool isDelta;
  final String family; // e.g., "boat", "hook", "angle"

  UrduChar({
    required this.glyph,
    required this.phonetic,
    this.isDelta = false,
    required this.family,
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
      default:
        return Colors.grey.shade100;
    }
  }
}
