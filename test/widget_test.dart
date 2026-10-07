import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:my_urdu_app/app.dart';
import 'package:my_urdu_app/models/lesson.dart';
import 'package:my_urdu_app/models/urdu_char.dart';
import 'package:my_urdu_app/services/audio_service.dart';
import 'package:my_urdu_app/services/progress_service.dart';
import 'package:my_urdu_app/state/progress_provider.dart';
import 'package:my_urdu_app/screens/lesson_screen.dart';
import 'package:my_urdu_app/screens/writing_practice_screen.dart';
import 'package:my_urdu_app/data/char_registry.dart';
import 'package:my_urdu_app/data/module_registry.dart';
import 'package:my_urdu_app/widgets/char_card.dart';

import 'test_helpers.dart';

void main() {
  late ProgressService progressService;

  setUp(() async {
    mockFlutterTtsChannel();
    SharedPreferences.setMockInitialValues({});
    progressService = await ProgressService.create();
  });

  testWidgets('Home screen shows app title and entry point button',
      (WidgetTester tester) async {
    await tester.pumpWidget(UrduCoreApp(progressService: progressService));
    await tester.pumpAndSettle();

    expect(find.text('Urdu Qalam'), findsWidgets);
    expect(find.text('Begin with the Alphabet'), findsOneWidget);
  });

  testWidgets('Tapping a glyph marks it as viewed and updates progress',
      (WidgetTester tester) async {
    final lesson = ModuleRegistry.modules
        .expand((m) => m.lessons)
        .whereType<CharLesson>()
        .first;

    await tester.pumpWidget(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => ProgressProvider(progressService)),
          Provider(create: (_) => AudioService()),
        ],
        child: MaterialApp(home: LessonScreen(lesson: lesson)),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('0 / ${lesson.chars.length} explored'), findsOneWidget);

    await tester.tap(find.text(lesson.chars.first.glyph).first);
    await tester.pumpAndSettle();
    await tester.tap(find.byIcon(Icons.volume_up));
    await tester.pumpAndSettle();
    await tester.tapAt(const Offset(10, 10)); // dismiss dialog
    await tester.pumpAndSettle();

    expect(find.text('1 / ${lesson.chars.length} explored'), findsOneWidget);

    await tester.tap(find.text('Quiz'));
    await tester.pumpAndSettle();
    expect(find.text('What is this letter called?'), findsOneWidget);
  });

  testWidgets('Writing the correct Urdu word shows a Correct result',
      (WidgetTester tester) async {
    final lesson = ModuleRegistry.modules
        .expand((m) => m.lessons)
        .whereType<WritingLesson>()
        .first;

    await tester.pumpWidget(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => ProgressProvider(progressService)),
          Provider(create: (_) => AudioService()),
        ],
        child: MaterialApp(home: WritingPracticeScreen(lesson: lesson)),
      ),
    );
    await tester.pumpAndSettle();

    // Find the word matching whichever prompt (English or Hindi) is shown.
    final prompts = {
      for (final w in lesson.words) w.english: w,
      for (final w in lesson.words) w.hindi: w,
    };
    final shownPrompt = prompts.keys.firstWhere(
      (p) => find.text(p).evaluate().isNotEmpty,
    );
    final expectedWord = prompts[shownPrompt]!;

    await tester.enterText(find.byType(TextField), expectedWord.urdu);
    await tester.tap(find.text('Check'));
    await tester.pumpAndSettle();

    expect(find.text('Correct!'), findsOneWidget);
  });

  testWidgets('Begin with the Alphabet navigates to the Alphabet lesson',
      (WidgetTester tester) async {
    await tester.pumpWidget(UrduCoreApp(progressService: progressService));
    await tester.pumpAndSettle();

    await tester.tap(find.text('Begin with the Alphabet'));
    await tester.pumpAndSettle();

    expect(find.text('Urdu Alphabets Only'), findsOneWidget);
  });

  testWidgets('search filters the grid by phonetic name and can be closed',
      (WidgetTester tester) async {
    final lesson = ModuleRegistry.modules
        .expand((m) => m.lessons)
        .whereType<CharLesson>()
        .first;

    await tester.pumpWidget(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => ProgressProvider(progressService)),
        ],
        child: MaterialApp(home: LessonScreen(lesson: lesson)),
      ),
    );
    await tester.pumpAndSettle();

    await tester.tap(find.byTooltip('Search'));
    await tester.pumpAndSettle();
    await tester.enterText(find.byType(TextField), 'Alif');
    await tester.pumpAndSettle();

    // find.text() also matches the TextField's own EditableText echoing back
    // what we just typed, so scope the "did it filter" check to the grid.
    final gridAlif = find.descendant(of: find.byType(GridView), matching: find.text('Alif'));
    expect(gridAlif, findsOneWidget);
    expect(find.text('Jeem'), findsNothing);

    await tester.tap(find.byTooltip('Close search'));
    await tester.pumpAndSettle();

    expect(find.text('Jeem'), findsOneWidget);
  });

  testWidgets('"Urdu Alphabets Only" filter chip narrows to delta letters',
      (WidgetTester tester) async {
    final lesson = ModuleRegistry.modules
        .expand((m) => m.lessons)
        .whereType<CharLesson>()
        .first;

    await tester.pumpWidget(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => ProgressProvider(progressService)),
        ],
        child: MaterialApp(home: LessonScreen(lesson: lesson)),
      ),
    );
    await tester.pumpAndSettle();

    await tester.tap(find.text('Urdu Alphabets Only'));
    await tester.pumpAndSettle();

    expect(find.text('Alif'), findsNothing); // Alif is not a delta letter
    expect(find.text('Pe'), findsOneWidget); // Pe (dotted Be) is a delta letter
  });

  testWidgets('a lesson with fewer than 4 glyphs shows no Quiz button',
      (WidgetTester tester) async {
    final tinyLesson = CharLesson(
      id: 'tiny',
      title: 'Tiny',
      icon: Icons.abc,
      charsBuilder: () => const [
        UrduChar(glyph: 'ا', phonetic: 'Alif', hindi: 'अलिफ़', family: 'alif'),
        UrduChar(glyph: 'ب', phonetic: 'Be', hindi: 'बे', family: 'boat'),
      ],
    );

    await tester.pumpWidget(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => ProgressProvider(progressService)),
        ],
        child: MaterialApp(home: LessonScreen(lesson: tinyLesson)),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('Quiz'), findsNothing);
  });

  testWidgets('a number\'s detail dialog has no Positional Forms section',
      (WidgetTester tester) async {
    final numbersLesson = CharLesson(
      id: 'numbers_test',
      title: 'Numbers',
      icon: Icons.numbers,
      charsBuilder: () => CharRegistry.urduNumbers,
    );

    await tester.pumpWidget(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => ProgressProvider(progressService)),
          Provider(create: (_) => AudioService()),
        ],
        child: MaterialApp(home: LessonScreen(lesson: numbersLesson)),
      ),
    );
    await tester.pumpAndSettle();

    await tester.tap(find.text('Zero'));
    await tester.pumpAndSettle();

    // The grid card behind the dialog also shows "शून्य", so scope to the dialog.
    final dialogHindi =
        find.descendant(of: find.byType(Dialog), matching: find.text('शून्य'));
    expect(dialogHindi, findsOneWidget);
    expect(find.text('How it connects in a word'), findsNothing);
  });

  testWidgets('disposing the app tree stops the audio service cleanly',
      (WidgetTester tester) async {
    await tester.pumpWidget(UrduCoreApp(progressService: progressService));
    await tester.pumpAndSettle();

    // Actually create the lazy AudioService provider (by using the
    // pronounce button) before tearing the tree down, so disposal has
    // something real to stop.
    await tester.tap(find.text('Begin with the Alphabet'));
    await tester.pumpAndSettle();
    await tester.tap(find.byWidgetPredicate((w) => w is CharCard).first);
    await tester.pumpAndSettle();
    await tester.tap(find.byIcon(Icons.volume_up));
    await tester.pumpAndSettle();

    await tester.pumpWidget(const SizedBox());
    await tester.pumpAndSettle();
  });
}
