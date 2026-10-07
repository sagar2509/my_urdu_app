import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:my_urdu_app/services/audio_service.dart';
import 'package:my_urdu_app/services/progress_service.dart';

import '../test_helpers.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('ProgressService', () {
    late ProgressService service;

    setUp(() async {
      SharedPreferences.setMockInitialValues({});
      service = await ProgressService.create();
    });

    test('isViewed is false for an unseen id', () {
      expect(service.isViewed('ا'), isFalse);
    });

    test('markViewed makes isViewed true', () async {
      await service.markViewed('ا');
      expect(service.isViewed('ا'), isTrue);
    });

    test('viewedCountIn counts only the viewed ids', () async {
      await service.markViewed('ا');
      expect(service.viewedCountIn(['ا', 'ب', 'ج']), 1);
    });

    test('bestScoreFor defaults to 0', () {
      expect(service.bestScoreFor('alphabet'), 0);
    });

    test('recordExerciseScore stores a new high score', () async {
      await service.recordExerciseScore('alphabet', 7);
      expect(service.bestScoreFor('alphabet'), 7);
    });

    test('recordExerciseScore keeps the higher of two scores', () async {
      await service.recordExerciseScore('alphabet', 7);
      await service.recordExerciseScore('alphabet', 3);
      expect(service.bestScoreFor('alphabet'), 7);

      await service.recordExerciseScore('alphabet', 9);
      expect(service.bestScoreFor('alphabet'), 9);
    });
  });

  group('AudioService', () {
    setUp(() {
      mockFlutterTtsChannel();
    });

    test('pronounce initializes the TTS engine and speaks', () async {
      final audio = AudioService();
      await audio.pronounce('ا');
      // Second call exercises the "already initialized" short-circuit.
      await audio.pronounce('ب');
    });

    test('dispose stops playback', () async {
      final audio = AudioService();
      await audio.pronounce('ا');
      await audio.dispose();
    });
  });
}
