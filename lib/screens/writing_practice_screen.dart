import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:provider/provider.dart';
import '../core/urdu_text.dart';
import '../models/lesson.dart';
import '../models/urdu_word.dart';
import '../services/audio_service.dart';
import '../state/progress_provider.dart';

enum _PromptLanguage { english, hindi }

class _WritingQuestion {
  final UrduWord word;
  final _PromptLanguage promptLanguage;

  const _WritingQuestion(this.word, this.promptLanguage);

  String get prompt =>
      promptLanguage == _PromptLanguage.english ? word.english : word.hindi;
}

/// Shows a word's meaning in English or Hindi and asks the learner to type
/// the Urdu spelling using their device's own keyboard. Mirrors QuizScreen's
/// one-question-at-a-time / feedback / results flow, but with free-text
/// input instead of multiple choice.
class WritingPracticeScreen extends StatefulWidget {
  final WritingLesson lesson;

  const WritingPracticeScreen({super.key, required this.lesson});

  @override
  State<WritingPracticeScreen> createState() => _WritingPracticeScreenState();
}

class _WritingPracticeScreenState extends State<WritingPracticeScreen> {
  late final List<_WritingQuestion> _questions;
  final TextEditingController _controller = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  int _index = 0;
  int _score = 0;
  bool _checked = false;
  bool _wasCorrect = false;
  bool _finished = false;

  @override
  void initState() {
    super.initState();
    _questions = _buildQuestions();
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  List<_WritingQuestion> _buildQuestions() {
    final rng = Random();
    final words = List<UrduWord>.from(widget.lesson.words)..shuffle(rng);
    return [
      for (final word in words.take(min(10, words.length)))
        _WritingQuestion(
          word,
          rng.nextBool() ? _PromptLanguage.english : _PromptLanguage.hindi,
        ),
    ];
  }

  void _check() {
    if (_checked) return;
    final question = _questions[_index];
    final correct = urduTextMatches(_controller.text, question.word.urdu);
    setState(() {
      _checked = true;
      _wasCorrect = correct;
      if (correct) _score++;
    });
  }

  void _next() {
    if (_index + 1 < _questions.length) {
      setState(() {
        _index++;
        _checked = false;
        _wasCorrect = false;
        _controller.clear();
      });
      _focusNode.requestFocus();
    } else {
      context.read<ProgressProvider>().recordExerciseScore(widget.lesson.id, _score);
      setState(() => _finished = true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.lesson.title)),
      // SafeArea + a scrollable content area (rather than a fixed Column with
      // a Spacer) so the layout can't overflow when the on-screen keyboard
      // shrinks the available height.
      body: SafeArea(child: _finished ? _buildResult() : _buildQuestionLayout()),
    );
  }

  Widget _buildResult() {
    final best = context.watch<ProgressProvider>().bestScoreFor(widget.lesson.id);
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24.0),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.emoji_events, size: 72, color: Colors.amber),
            const SizedBox(height: 16),
            Text('$_score / ${_questions.length} correct',
                style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Text('Best score: $best / ${_questions.length}',
                style: TextStyle(color: Colors.grey.shade700)),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Done'),
            ),
          ],
        ),
      ),
    );
  }

  /// The question content scrolls on its own; the action button stays
  /// pinned below it instead of relying on a Spacer to push it down.
  Widget _buildQuestionLayout() {
    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(24, 24, 24, 0),
            child: _buildQuestion(),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(24.0),
          child: ElevatedButton(
            onPressed: _checked ? _next : _check,
            child: Text(
              !_checked
                  ? 'Check'
                  : (_index + 1 < _questions.length ? 'Next' : 'Finish'),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildQuestion() {
    final question = _questions[_index];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text('Question ${_index + 1} of ${_questions.length}',
            textAlign: TextAlign.center, style: TextStyle(color: Colors.grey.shade700)),
        const SizedBox(height: 8),
        Text(
          question.promptLanguage == _PromptLanguage.english
              ? 'Write this word in Urdu:'
              : 'اس لفظ کو اردو میں لکھیں:',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 14, color: Colors.grey.shade700),
        ),
        const SizedBox(height: 12),
        Text(
          question.prompt,
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 24),
        TextField(
          controller: _controller,
          focusNode: _focusNode,
          enabled: !_checked,
          autofocus: true,
          textAlign: TextAlign.center,
          textDirection: TextDirection.rtl,
          style: const TextStyle(fontFamily: 'Nastaliq', fontSize: 32),
          decoration: InputDecoration(
            hintText: 'لکھیں',
            border: const OutlineInputBorder(),
            filled: _checked,
            fillColor: _checked
                ? (_wasCorrect ? Colors.green.shade50 : Colors.red.shade50)
                : null,
          ),
          onSubmitted: (_) => _check(),
        ),
        const SizedBox(height: 8),
        TextButton.icon(
          onPressed: _showKeyboardHelp,
          icon: const Icon(Icons.keyboard, size: 18),
          label: const Text("Don't have an Urdu keyboard?"),
        ),
        if (_checked) ...[
          const SizedBox(height: 16),
          _buildFeedback(question),
        ],
      ],
    );
  }

  Widget _buildFeedback(_WritingQuestion question) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              _wasCorrect ? Icons.check_circle : Icons.cancel,
              color: _wasCorrect ? Colors.green : Colors.red,
            ),
            const SizedBox(width: 8),
            Text(
              _wasCorrect ? 'Correct!' : 'Correct answer:',
              style: TextStyle(
                color: _wasCorrect ? Colors.green.shade700 : Colors.red.shade700,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        if (!_wasCorrect) ...[
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                question.word.urdu,
                style: const TextStyle(fontFamily: 'Nastaliq', fontSize: 32),
              ),
              IconButton(
                icon: const Icon(Icons.volume_up),
                tooltip: 'Pronounce',
                onPressed: () =>
                    context.read<AudioService>().pronounce(question.word.urdu),
              ),
            ],
          ),
        ],
      ],
    );
  }

  void _showKeyboardHelp() {
    final isApple = defaultTargetPlatform == TargetPlatform.iOS ||
        defaultTargetPlatform == TargetPlatform.macOS;
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Add an Urdu keyboard'),
        content: Text(
          isApple
              ? 'Settings -> General -> Keyboard -> Keyboards -> Add New Keyboard -> Urdu. '
                  'Switch to it with the globe icon while typing.'
              : 'Settings -> System -> Languages & input -> On-screen keyboard -> '
                  'Manage keyboards -> add Urdu. Switch to it with the globe/space-bar icon while typing.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Got it'),
          ),
        ],
      ),
    );
  }
}
