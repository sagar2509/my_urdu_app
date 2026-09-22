import 'urdu_char.dart';

/// A single "which glyph makes this sound?" multiple-choice question.
class QuizQuestion {
  final UrduChar answer;
  final List<UrduChar> options;

  const QuizQuestion({required this.answer, required this.options});

  bool isCorrect(UrduChar selected) => selected.glyph == answer.glyph;
}
