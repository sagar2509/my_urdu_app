import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../core/constants.dart';
import '../data/module_registry.dart';
import '../models/lesson.dart';
import '../navigation/lesson_navigation.dart';
import '../state/progress_provider.dart';
import '../widgets/app_drawer.dart';
import '../widgets/word_card.dart';

/// Browsable "learn" screen for a [WordLesson] — tap a word to see its
/// letter breakdown and meaning. Offers a shortcut to the paired
/// [WritingLesson] practice exercise, if the lesson names one.
class WordLessonScreen extends StatelessWidget {
  final WordLesson lesson;

  const WordLessonScreen({super.key, required this.lesson});

  @override
  Widget build(BuildContext context) {
    final progress = context.watch<ProgressProvider>();
    final words = lesson.words;
    final viewedCount = progress.viewedCountIn(words.map((w) => w.id));
    final practiceLessonId = lesson.practiceLessonId;
    final practiceLesson = practiceLessonId == null
        ? null
        : ModuleRegistry.findLesson(practiceLessonId);

    return Scaffold(
      appBar: AppBar(title: Text(lesson.title)),
      drawer: const AppDrawer(),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('$viewedCount / ${words.length} explored',
                    style: const TextStyle(fontSize: 12, color: Colors.grey)),
                const SizedBox(height: 4),
                ClipRRect(
                  borderRadius: BorderRadius.circular(4),
                  child: LinearProgressIndicator(
                    value: words.isEmpty ? 0 : viewedCount / words.length,
                    minHeight: 6,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.only(
                top: AppConstants.gridSpacing,
                bottom: 80,
              ),
              itemCount: words.length,
              itemBuilder: (context, index) => WordCard(word: words[index]),
            ),
          ),
        ],
      ),
      floatingActionButton: practiceLesson == null
          ? null
          : FloatingActionButton.extended(
              onPressed: () => pushLesson(context, practiceLesson),
              icon: const Icon(Icons.edit),
              label: const Text('Practice'),
            ),
    );
  }
}
