import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:my_urdu_app/services/progress_service.dart';
import 'package:my_urdu_app/state/progress_provider.dart';

void main() {
  late ProgressProvider provider;

  setUp(() async {
    SharedPreferences.setMockInitialValues({});
    provider = ProgressProvider(await ProgressService.create());
  });

  test('markViewed notifies listeners on a new id', () async {
    var notifications = 0;
    provider.addListener(() => notifications++);

    await provider.markViewed('ا');

    expect(provider.isViewed('ا'), isTrue);
    expect(notifications, 1);
  });

  test('markViewed is a no-op (no notification) if already viewed', () async {
    await provider.markViewed('ا');

    var notifications = 0;
    provider.addListener(() => notifications++);
    await provider.markViewed('ا');

    expect(notifications, 0);
  });

  test('viewedCountIn delegates to the service', () async {
    await provider.markViewed('ا');
    await provider.markViewed('ب');
    expect(provider.viewedCountIn(['ا', 'ب', 'ج']), 2);
  });

  test('recordExerciseScore updates bestScoreFor and notifies', () async {
    var notifications = 0;
    provider.addListener(() => notifications++);

    await provider.recordExerciseScore('alphabet', 5);

    expect(provider.bestScoreFor('alphabet'), 5);
    expect(notifications, 1);
  });
}
