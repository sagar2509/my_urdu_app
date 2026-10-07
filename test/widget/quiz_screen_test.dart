import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:my_urdu_app/models/lesson.dart';
import 'package:my_urdu_app/models/urdu_char.dart';
import 'package:my_urdu_app/screens/quiz_screen.dart';
import 'package:my_urdu_app/services/progress_service.dart';
import 'package:my_urdu_app/state/progress_provider.dart';

const _testChars = [
  UrduChar(glyph: 'ا', phonetic: 'Alif', hindi: 'अलिफ़', family: 'alif'),
  UrduChar(glyph: 'ب', phonetic: 'Be', hindi: 'बे', family: 'boat'),
  UrduChar(glyph: 'ت', phonetic: 'Te', hindi: 'ते', family: 'boat'),
  UrduChar(glyph: 'ج', phonetic: 'Jeem', hindi: 'जीम', family: 'hook'),
  UrduChar(glyph: 'د', phonetic: 'Dal', hindi: 'दाल', family: 'angle'),
];

String _glyphToPhonetic(String glyph) =>
    _testChars.firstWhere((c) => c.glyph == glyph).phonetic;

Finder _optionButton(String phonetic) => find.widgetWithText(ElevatedButton, phonetic);

Future<void> main() async {
  late ProgressProvider progressProvider;

  setUp(() async {
    SharedPreferences.setMockInitialValues({});
    progressProvider = ProgressProvider(await ProgressService.create());
  });

  Future<void> pumpQuizBehindAButton(WidgetTester tester, CharLesson lesson) async {
    await tester.pumpWidget(
      ChangeNotifierProvider.value(
        value: progressProvider,
        child: MaterialApp(
          home: Builder(
            builder: (context) => ElevatedButton(
              onPressed: () => Navigator.of(context).push(
                MaterialPageRoute(builder: (_) => QuizScreen(lesson: lesson)),
              ),
              child: const Text('go'),
            ),
          ),
        ),
      ),
    );
    await tester.tap(find.text('go'));
    await tester.pumpAndSettle();
  }

  testWidgets('full quiz: correct answer, incorrect answer, finish, and see results',
      (tester) async {
    final lesson = CharLesson(
      id: 'test_quiz',
      title: 'Test Quiz',
      icon: Icons.abc,
      charsBuilder: () => _testChars,
    );
    await pumpQuizBehindAButton(tester, lesson);

    for (var i = 0; i < _testChars.length; i++) {
      final glyphFinder =
          find.byWidgetPredicate((w) => w is Text && w.style?.fontSize == 96);
      expect(glyphFinder, findsOneWidget);
      final glyph = (tester.widget<Text>(glyphFinder)).data!;
      final correctPhonetic = _glyphToPhonetic(glyph);

      if (i == 0) {
        // Correct answer, tapped twice — the second tap must be a no-op
        // (QuizScreen ignores further taps once an option is selected).
        await tester.tap(_optionButton(correctPhonetic));
        await tester.pump();
        await tester.tap(_optionButton(correctPhonetic));
        await tester.pump();
      } else if (i == 1) {
        final wrongChar = _testChars.firstWhere((c) =>
            c.phonetic != correctPhonetic &&
            _optionButton(c.phonetic).evaluate().isNotEmpty);
        await tester.tap(_optionButton(wrongChar.phonetic));
        await tester.pump();
      } else {
        final anyChar = _testChars.firstWhere(
            (c) => _optionButton(c.phonetic).evaluate().isNotEmpty);
        await tester.tap(_optionButton(anyChar.phonetic));
        await tester.pump();
      }

      final nextOrFinish = find.widgetWithText(ElevatedButton, 'Next').evaluate().isNotEmpty
          ? find.widgetWithText(ElevatedButton, 'Next')
          : find.widgetWithText(ElevatedButton, 'Finish');
      await tester.tap(nextOrFinish);
      await tester.pumpAndSettle();
    }

    expect(find.textContaining('/ 5 correct'), findsOneWidget);
    expect(find.textContaining('Best score:'), findsOneWidget);

    await tester.tap(find.widgetWithText(ElevatedButton, 'Done'));
    await tester.pumpAndSettle();

    expect(find.text('go'), findsOneWidget);
    expect(progressProvider.bestScoreFor('test_quiz'), greaterThanOrEqualTo(1));
  });

  testWidgets('fewer than 4 glyphs pulls distractors from the rest of the app',
      (tester) async {
    final tinyLesson = CharLesson(
      id: 'tiny',
      title: 'Tiny',
      icon: Icons.abc,
      charsBuilder: () => _testChars.take(2).toList(),
    );
    await pumpQuizBehindAButton(tester, tinyLesson);

    expect(find.text('What is this letter called?'), findsOneWidget);
    expect(find.byType(ElevatedButton), findsNWidgets(4));
  });
}
