import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../data/module_registry.dart';
import '../models/lesson.dart';
import '../models/quiz_question.dart';
import '../models/urdu_char.dart';
import '../state/progress_provider.dart';

/// A multiple-choice "what is this letter called?" quiz over a lesson's
/// glyphs. Lessons with fewer than 4 glyphs (not enough for distractors)
/// pull extra distractor options from the rest of the app's content.
class QuizScreen extends StatefulWidget {
  final Lesson lesson;

  const QuizScreen({super.key, required this.lesson});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  late final List<QuizQuestion> _questions;
  int _index = 0;
  int _score = 0;
  UrduChar? _selected;
  bool _finished = false;

  @override
  void initState() {
    super.initState();
    _questions = _buildQuestions();
  }

  List<QuizQuestion> _buildQuestions() {
    final distractorPool = widget.lesson.chars.length >= 4
        ? widget.lesson.chars
        : ModuleRegistry.allLessons.expand((l) => l.chars).toSet().toList();
    final rng = Random();
    final targets = List<UrduChar>.from(widget.lesson.chars)..shuffle(rng);
    final take = min(10, targets.length);

    return targets.take(take).map((answer) {
      final distractors = distractorPool
          .where((c) => c.glyph != answer.glyph)
          .toList()
        ..shuffle(rng);
      final options = [answer, ...distractors.take(3)]..shuffle(rng);
      return QuizQuestion(answer: answer, options: options);
    }).toList();
  }

  void _select(UrduChar option) {
    if (_selected != null) return;
    setState(() {
      _selected = option;
      if (_questions[_index].isCorrect(option)) _score++;
    });
  }

  void _next() {
    if (_index + 1 < _questions.length) {
      setState(() {
        _index++;
        _selected = null;
      });
    } else {
      context.read<ProgressProvider>().recordQuizScore(widget.lesson.id, _score);
      setState(() => _finished = true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('${widget.lesson.title} Quiz')),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: _finished ? _buildResult() : _buildQuestion(),
      ),
    );
  }

  Widget _buildResult() {
    final best = context.watch<ProgressProvider>().bestScoreFor(widget.lesson.id);
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.emoji_events, size: 72, color: Colors.amber),
          const SizedBox(height: 16),
          Text('$_score / ${_questions.length} correct',
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          Text('Best score: $best / ${_questions.length}',
              style: const TextStyle(color: Colors.grey)),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Done'),
          ),
        ],
      ),
    );
  }

  Widget _buildQuestion() {
    final question = _questions[_index];
    return Column(
      children: [
        Text('Question ${_index + 1} of ${_questions.length}',
            style: const TextStyle(color: Colors.grey)),
        const SizedBox(height: 16),
        Text(
          question.answer.glyph,
          style: const TextStyle(fontFamily: 'Nastaliq', fontSize: 96, height: 1.2),
        ),
        const Text('What is this letter called?', style: TextStyle(fontSize: 16)),
        const SizedBox(height: 24),
        ...question.options.map((option) {
          final isSelected = identical(_selected, option);
          final isCorrectOption = question.isCorrect(option);
          Color? color;
          if (_selected != null) {
            if (isCorrectOption) {
              color = Colors.green.shade100;
            } else if (isSelected) {
              color = Colors.red.shade100;
            }
          }
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 6),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: color,
                foregroundColor: Colors.black87,
                minimumSize: const Size.fromHeight(48),
              ),
              onPressed: () => _select(option),
              child: Text(option.phonetic),
            ),
          );
        }),
        const Spacer(),
        if (_selected != null)
          ElevatedButton(
            onPressed: _next,
            child: Text(_index + 1 < _questions.length ? 'Next' : 'Finish'),
          ),
      ],
    );
  }
}
