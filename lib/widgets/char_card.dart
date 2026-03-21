import 'package:flutter/material.dart';
import '../models/urdu_char.dart';
import 'char_detail_dialog.dart';

class CharCard extends StatelessWidget {
  final UrduChar char;

  const CharCard({super.key, required this.char});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Show the detail dialog when tapped
        showDialog(
          context: context,
          builder: (context) => CharDetailDialog(char: char),
        );
      },
      child: Container(
        margin: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: char.familyColor, // Visual grouping
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            // Highlight Deltas with a stronger border
            color: char.isDelta ? Colors.blue.shade700 : Colors.transparent,
            width: 2,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Inside widgets/char_card.dart
            Text(
              char.glyph,
              style: const TextStyle(
                fontFamily: 'UrduNastaliq', // Match the name in pubspec.yaml
                fontSize: 48,
                height: 1.5, // Important for Nastaliq height
              ),
            ),
            const SizedBox(height: 4),
            Text(
              char.phonetic,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 14,
                color: Colors.black87,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
