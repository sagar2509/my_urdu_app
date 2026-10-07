import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:my_urdu_app/models/lesson.dart';
import 'package:my_urdu_app/models/urdu_word.dart';
import 'package:my_urdu_app/screens/writing_practice_screen.dart';
import 'package:my_urdu_app/services/audio_service.dart';
import 'package:my_urdu_app/services/progress_service.dart';
import 'package:my_urdu_app/state/progress_provider.dart';

import '../test_helpers.dart';

const _testWords = [
  UrduWord(urdu: 'اب', english: 'now', hindi: 'अब'),
  UrduWord(urdu: 'تب', english: 'then', hindi: 'तब'),
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

  testWidgets(
      'does not overflow when the on-screen keyboard shrinks the viewport',
      (tester) async {
    final lesson = WritingLesson(
      id: 'test_writing',
      title: 'Test Writing',
      icon: Icons.edit,
      wordsBuilder: () => _testWords,
    );

    // A short physical screen with a large bottom inset mimics a phone
    // whose on-screen keyboard is open — this is what previously overflowed.
    await tester.binding.setSurfaceSize(const Size(400, 500));
    tester.view.viewInsets = const FakeViewPadding(bottom: 300);
    addTearDown(() {
      tester.view.resetViewInsets();
      tester.binding.setSurfaceSize(null);
    });

    await tester.pumpWidget(harness(WritingPracticeScreen(lesson: lesson)));
    await tester.pumpAndSettle();

    expect(tester.takeException(), isNull);
  });

  testWidgets('submitting via the keyboard checks the answer too', (tester) async {
    final lesson = WritingLesson(
      id: 'test_writing_submit',
      title: 'Test Writing',
      icon: Icons.edit,
      wordsBuilder: () => _testWords,
    );

    await tester.pumpWidget(harness(WritingPracticeScreen(lesson: lesson)));
    await tester.pumpAndSettle();

    await tester.enterText(find.byType(TextField), 'غلط');
    await tester.testTextInput.receiveAction(TextInputAction.done);
    await tester.pumpAndSettle();

    expect(find.text('Correct answer:'), findsOneWidget);
  });

  testWidgets('incorrect answer shows the correct spelling and a pronounce button',
      (tester) async {
    final lesson = WritingLesson(
      id: 'test_writing_2',
      title: 'Test Writing',
      icon: Icons.edit,
      wordsBuilder: () => _testWords,
    );

    await tester.pumpWidget(harness(WritingPracticeScreen(lesson: lesson)));
    await tester.pumpAndSettle();

    await tester.enterText(find.byType(TextField), 'غلط');
    await tester.tap(find.widgetWithText(ElevatedButton, 'Check'));
    await tester.pumpAndSettle();

    expect(find.text('Correct answer:'), findsOneWidget);
    expect(find.byIcon(Icons.volume_up), findsOneWidget);
    await tester.tap(find.byIcon(Icons.volume_up));
    await tester.pumpAndSettle();

    await tester.tap(find.widgetWithText(ElevatedButton, 'Next'));
    await tester.pumpAndSettle();

    // Questions are shuffled, so look up which word is now being asked
    // instead of assuming a fixed order.
    final promptFinder =
        find.byWidgetPredicate((w) => w is Text && w.style?.fontSize == 36);
    final prompt = (tester.widget<Text>(promptFinder)).data!;
    final currentWord = _testWords
        .firstWhere((w) => w.english == prompt || w.hindi == prompt);

    await tester.enterText(find.byType(TextField), currentWord.urdu);
    await tester.tap(find.widgetWithText(ElevatedButton, 'Check'));
    await tester.pumpAndSettle();
    expect(find.text('Correct!'), findsOneWidget);

    await tester.tap(find.widgetWithText(ElevatedButton, 'Finish'));
    await tester.pumpAndSettle();

    expect(find.textContaining('/ 2 correct'), findsOneWidget);

    // Running it again should retain the earlier (non-zero) best score even
    // if this run scores lower.
    await tester.tap(find.widgetWithText(ElevatedButton, 'Done'));
  });

  testWidgets("keyboard-help dialog shows platform-specific instructions",
      (tester) async {
    final lesson = WritingLesson(
      id: 'test_writing_3',
      title: 'Test Writing',
      icon: Icons.edit,
      wordsBuilder: () => _testWords,
    );
    await tester.pumpWidget(harness(WritingPracticeScreen(lesson: lesson)));
    await tester.pumpAndSettle();

    await tester.tap(find.text("Don't have an Urdu keyboard?"));
    await tester.pumpAndSettle();
    expect(find.text('Add an Urdu keyboard'), findsOneWidget);

    await tester.tap(find.text('Got it'));
    await tester.pumpAndSettle();

    debugDefaultTargetPlatformOverride = TargetPlatform.iOS;
    await tester.tap(find.text("Don't have an Urdu keyboard?"));
    await tester.pumpAndSettle();
    expect(find.textContaining('Add New Keyboard'), findsOneWidget);

    // Reset synchronously (not via addTearDown) so the framework's
    // end-of-test invariant check sees it already cleared.
    debugDefaultTargetPlatformOverride = null;
    await tester.tap(find.text('Got it'));
    await tester.pumpAndSettle();
  });
}
