import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/urdu_word.dart';
import '../state/progress_provider.dart';
import 'word_detail_dialog.dart';

class WordCard extends StatelessWidget {
  final UrduWord word;

  const WordCard({super.key, required this.word});

  @override
  Widget build(BuildContext context) {
    final isViewed = context.watch<ProgressProvider>().isViewed(word.id);

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      color: word.familyColor,
      child: ListTile(
        onTap: () => showDialog(
          context: context,
          builder: (_) => WordDetailDialog(word: word),
        ),
        leading: Text(
          word.urdu,
          style: const TextStyle(fontFamily: 'Nastaliq', fontSize: 32),
        ),
        title: Text(word.english),
        subtitle: Text(word.hindi),
        trailing: isViewed
            ? Semantics(
                label: 'Already viewed',
                child: const Icon(Icons.check_circle, size: 20, color: Colors.green),
              )
            : null,
      ),
    );
  }
}
