import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:my_urdu_app/models/lesson.dart';
import 'package:my_urdu_app/models/urdu_word.dart';
import 'package:my_urdu_app/screens/word_lesson_screen.dart';
import 'package:my_urdu_app/services/audio_service.dart';
import 'package:my_urdu_app/services/progress_service.dart';
import 'package:my_urdu_app/state/progress_provider.dart';

import '../test_helpers.dart';

const _testWords = [
  UrduWord(urdu: 'اب', english: 'now', hindi: 'अब', family: 'alif'),
  UrduWord(urdu: 'تب', english: 'then', hindi: 'तब', family: 'boat'),
];

Future<void> main() async {
  late ProgressProvider progressProvider;

  setUp(() async {
    mockFlutterTtsChannel();
    SharedPreferences.setMockInitialValues({});
    progressProvider = ProgressProvider(await ProgressService.create());
  });

  Widget harness(Widget child) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: progressProvider),
        Provider(create: (_) => AudioService()),
      ],
      child: MaterialApp(home: child),
    );
  }

  testWidgets('shows words, opens a word dialog, and marks it viewed',
      (tester) async {
    final lesson = WordLesson(
      id: 'test_words',
      title: 'Test Words',
      icon: Icons.menu_book,
      wordsBuilder: () => _testWords,
    );

    await tester.pumpWidget(harness(WordLessonScreen(lesson: lesson)));
    await tester.pumpAndSettle();

    expect(find.text('0 / 2 explored'), findsOneWidget);
    expect(find.text('now'), findsOneWidget);
    expect(find.text('then'), findsOneWidget);

    await tester.tap(find.text('now'));
    await tester.pumpAndSettle();

    expect(find.text('Built from these letters'), findsOneWidget);
    expect(find.text('अब'), findsWidgets);

    await tester.tap(find.byIcon(Icons.volume_up));
    await tester.pumpAndSettle();

    await tester.tapAt(const Offset(10, 10)); // dismiss dialog
    await tester.pumpAndSettle();

    expect(find.text('1 / 2 explored'), findsOneWidget);
  });

  testWidgets('shows no Practice FAB when the lesson has no companion practice',
      (tester) async {
    final lesson = WordLesson(
      id: 'no_practice',
      title: 'No Practice',
      icon: Icons.menu_book,
      wordsBuilder: () => _testWords,
    );

    await tester.pumpWidget(harness(WordLessonScreen(lesson: lesson)));
    await tester.pumpAndSettle();

    expect(find.text('Practice'), findsNothing);
  });

  testWidgets('Practice FAB navigates to the companion writing lesson',
      (tester) async {
    final lesson = WordLesson(
      id: 'has_practice',
      title: 'Has Practice',
      icon: Icons.menu_book,
      wordsBuilder: () => _testWords,
      practiceLessonId: 'common_words_practice',
    );

    await tester.pumpWidget(harness(WordLessonScreen(lesson: lesson)));
    await tester.pumpAndSettle();

    await tester.tap(find.text('Practice'));
    await tester.pumpAndSettle();

    expect(find.text('Practice: Write Common Words'), findsOneWidget);
  });
}
