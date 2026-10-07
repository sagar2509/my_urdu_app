import 'package:flutter/foundation.dart';
import '../services/progress_service.dart';

/// App-wide learning progress, backed by [ProgressService]. Wrapped in a
/// ChangeNotifier so any screen (lesson grid, drawer, home dashboard) can
/// reactively show completion state without threading callbacks manually.
class ProgressProvider extends ChangeNotifier {
  final ProgressService _service;

  ProgressProvider(this._service);

  bool isViewed(String charId) => _service.isViewed(charId);

  Future<void> markViewed(String charId) async {
    if (_service.isViewed(charId)) return;
    await _service.markViewed(charId);
    notifyListeners();
  }

  int viewedCountIn(Iterable<String> charIds) =>
      _service.viewedCountIn(charIds);

  int bestScoreFor(String lessonId) => _service.bestScoreFor(lessonId);

  Future<void> recordExerciseScore(String lessonId, int score) async {
    await _service.recordExerciseScore(lessonId, score);
    notifyListeners();
  }
}
