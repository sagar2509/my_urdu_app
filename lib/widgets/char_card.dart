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
    final brandColor = Theme.of(context).primaryColor;

    return Padding(
      padding: const EdgeInsets.all(8),
      child: Material(
        // Real cast elevation instead of an approximated BoxShadow — deltas
        // (letters with a dot/mark variant) sit a little higher to stand out.
        elevation: char.isDelta ? 6 : 3,
        shadowColor: brandColor.withValues(alpha: 0.45),
        borderRadius: BorderRadius.circular(16),
        color: char.familyColor,
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: () {
            showDialog(
              context: context,
              builder: (_) => CharDetailDialog(char: char),
            );
          },
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                // Highlight Deltas with a stronger border
                color: char.isDelta ? Colors.blue.shade700 : Colors.transparent,
                width: 2,
              ),
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
                    const SizedBox(height: 2),
                    Text(
                      char.phonetic,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                        color: Colors.black87,
                      ),
                    ),
                    Text(
                      char.hindi,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 10,
                        color: Colors.grey.shade700,
                      ),
                    ),
                  ],
                ),
                if (isViewed)
                  Positioned(
                    top: 4,
                    right: 4,
                    child: Semantics(
                      label: 'Already viewed',
                      child: const Icon(Icons.check_circle, size: 16, color: Colors.green),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
