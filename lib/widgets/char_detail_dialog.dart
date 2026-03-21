import 'package:flutter/material.dart';
import '../models/urdu_char.dart';

class CharDetailDialog extends StatelessWidget {
  final UrduChar char;

  const CharDetailDialog({super.key, required this.char});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisSize: MainAxisSize.min, // Wrap content
          children: [
            // 1. The "Hero" Glyph
            Text(
              char.glyph,
              style: TextStyle(
                fontFamily: 'UrduNastaliq',
                fontSize: 80,
                color: theme.primaryColor,
                height: 1.2,
              ),
            ),
            Text(
              char.phonetic,
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const Divider(height: 32),

            // 2. The Positional Logic Row
            const Text("Positional Forms",
                style: TextStyle(color: Colors.grey)),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildFormColumn("Initial", char.initial ?? char.glyph),
                _buildFormColumn("Middle", char.middle ?? char.glyph),
                _buildFormColumn("Final", char.finalForm ?? char.glyph),
              ],
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  Widget _buildFormColumn(String label, String form) {
    return Column(
      children: [
        Text(
          form,
          style: const TextStyle(fontFamily: 'UrduNastaliq', fontSize: 32),
        ),
        const SizedBox(height: 4),
        Text(label, style: const TextStyle(fontSize: 10, color: Colors.grey)),
      ],
    );
  }
}
