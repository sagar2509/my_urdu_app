import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/urdu_char.dart';
import '../state/progress_provider.dart';
import 'char_detail_dialog.dart';

class CharCard extends StatelessWidget {
  final UrduChar char;

  const CharCard({super.key, required this.char});

  @override
  Widget build(BuildContext context) {
    final isViewed = context.watch<ProgressProvider>().isViewed(char.id);

    return GestureDetector(
      onTap: () {
        showDialog(
          context: context,
          builder: (_) => CharDetailDialog(char: char),
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
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  char.glyph,
                  style: const TextStyle(
                    fontFamily: 'Nastaliq', // matches pubspec.yaml font family
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
            if (isViewed)
              const Positioned(
                top: 4,
                right: 4,
                child: Icon(Icons.check_circle, size: 16, color: Colors.green),
              ),
          ],
        ),
      ),
    );
  }
}
