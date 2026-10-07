import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../core/urdu_text.dart';
import '../data/char_registry.dart';
import '../models/urdu_word.dart';
import '../services/audio_service.dart';
import '../state/progress_provider.dart';

class WordDetailDialog extends StatefulWidget {
  final UrduWord word;

  const WordDetailDialog({super.key, required this.word});

  @override
  State<WordDetailDialog> createState() => _WordDetailDialogState();
}

class _WordDetailDialogState extends State<WordDetailDialog> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) context.read<ProgressProvider>().markViewed(widget.word.id);
    });
  }

  String? _phoneticFor(String glyph) {
    for (final char in CharRegistry.masterList) {
      if (char.glyph == glyph) return char.phonetic;
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final word = widget.word;
    final letters = splitIntoLetters(word.urdu);

    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  word.urdu,
                  style: TextStyle(
                    fontFamily: 'Nastaliq',
                    fontSize: 56,
                    color: theme.primaryColor,
                    height: 1.2,
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.volume_up),
                  color: theme.primaryColor,
                  tooltip: 'Pronounce',
                  onPressed: () =>
                      context.read<AudioService>().pronounce(word.urdu),
                ),
              ],
            ),
            Text(word.english, style: const TextStyle(fontSize: 18)),
            Text(
              word.hindi,
              style: TextStyle(fontSize: 16, color: Colors.grey.shade700),
            ),
            const Divider(height: 32),
            Text("Built from these letters", style: TextStyle(color: Colors.grey.shade700)),
            const SizedBox(height: 16),
            Wrap(
              alignment: WrapAlignment.center,
              spacing: 16,
              runSpacing: 12,
              children: [
                for (final letter in letters) _buildLetterColumn(letter),
              ],
            ),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }

  Widget _buildLetterColumn(String letter) {
    final phonetic = _phoneticFor(letter);
    return Column(
      children: [
        Text(letter, style: const TextStyle(fontFamily: 'Nastaliq', fontSize: 32)),
        if (phonetic != null) ...[
          const SizedBox(height: 4),
          Text(phonetic, style: TextStyle(fontSize: 10, color: Colors.grey.shade700)),
        ],
      ],
    );
  }
}
