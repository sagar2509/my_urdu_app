import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/urdu_char.dart';
import '../services/audio_service.dart';
import '../state/progress_provider.dart';

class CharDetailDialog extends StatefulWidget {
  final UrduChar char;

  const CharDetailDialog({super.key, required this.char});

  @override
  State<CharDetailDialog> createState() => _CharDetailDialogState();
}

class _CharDetailDialogState extends State<CharDetailDialog> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) context.read<ProgressProvider>().markViewed(widget.char.id);
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final char = widget.char;

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
                fontFamily: 'Nastaliq',
                fontSize: 80,
                color: theme.primaryColor,
                height: 1.2,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  char.phonetic,
                  style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
                IconButton(
                  icon: const Icon(Icons.volume_up),
                  color: theme.primaryColor,
                  tooltip: 'Pronounce',
                  onPressed: () => context.read<AudioService>().pronounce(char.glyph),
                ),
              ],
            ),

            // 2. The Positional Logic Row (letters only — numbers have no forms)
            if (char.hasPositionalForms) ...[
              const Divider(height: 32),
              const Text("Positional Forms", style: TextStyle(color: Colors.grey)),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildFormColumn("Initial", char.initial ?? char.glyph),
                  _buildFormColumn("Middle", char.middle ?? char.glyph),
                  _buildFormColumn("Final", char.finalForm ?? char.glyph),
                ],
              ),
            ],
            const SizedBox(height: 8),
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
          style: const TextStyle(fontFamily: 'Nastaliq', fontSize: 32),
        ),
        const SizedBox(height: 4),
        Text(label, style: const TextStyle(fontSize: 10, color: Colors.grey)),
      ],
    );
  }
}
