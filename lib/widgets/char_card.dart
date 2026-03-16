import 'package:flutter/material.dart';
import '../models/urdu_char.dart';

class CharCard extends StatelessWidget {
  final UrduChar char;

  const CharCard({super.key, required this.char});

  @override
  Widget build(BuildContext context) {
    return Container(
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
          Text(
            char.glyph,
            style: const TextStyle(
              fontSize: 56, // Large for clarity
              fontFamily: 'Nastaliq',
              height: 1.2, // Adjust for Nastaliq's vertical cascade
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
    );
  }
}
