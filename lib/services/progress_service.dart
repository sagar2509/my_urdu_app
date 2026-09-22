import 'package:shared_preferences/shared_preferences.dart';

/// Persists learning progress (viewed glyphs, quiz best scores) locally.
class ProgressService {
  static const _viewedPrefix = 'viewed_char_';
  static const _quizScorePrefix = 'quiz_best_score_';

  final SharedPreferences _prefs;

  ProgressService(this._prefs);

  static Future<ProgressService> create() async {
    final prefs = await SharedPreferences.getInstance();
    return ProgressService(prefs);
  }

  bool isViewed(String charId) => _prefs.getBool('$_viewedPrefix$charId') ?? false;

  Future<void> markViewed(String charId) =>
      _prefs.setBool('$_viewedPrefix$charId', true);

  int viewedCountIn(Iterable<String> charIds) =>
      charIds.where(isViewed).length;

  int bestScoreFor(String lessonId) =>
      _prefs.getInt('$_quizScorePrefix$lessonId') ?? 0;

  Future<void> recordQuizScore(String lessonId, int score) async {
    final best = bestScoreFor(lessonId);
    if (score > best) {
      await _prefs.setInt('$_quizScorePrefix$lessonId', score);
    }
  }
}
