import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:my_urdu_app/app.dart';
import 'package:my_urdu_app/models/lesson.dart';
import 'package:my_urdu_app/services/audio_service.dart';
import 'package:my_urdu_app/services/progress_service.dart';
import 'package:my_urdu_app/state/progress_provider.dart';
import 'package:my_urdu_app/screens/lesson_screen.dart';
import 'package:my_urdu_app/screens/writing_practice_screen.dart';
import 'package:my_urdu_app/data/module_registry.dart';

void main() {
  late ProgressService progressService;

  setUp(() async {
    SharedPreferences.setMockInitialValues({});
    progressService = await ProgressService.create();
  });

  testWidgets('Home screen shows app title and entry point button',
      (WidgetTester tester) async {
    await tester.pumpWidget(UrduCoreApp(progressService: progressService));
    await tester.pumpAndSettle();

    expect(find.text('Urdu Core'), findsWidgets);
    expect(find.text('Begin with Basics'), findsOneWidget);
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
        ],
        child: MaterialApp(home: LessonScreen(lesson: lesson)),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('0 / ${lesson.chars.length} explored'), findsOneWidget);

    await tester.tap(find.text(lesson.chars.first.glyph).first);
    await tester.pumpAndSettle();
    await tester.tapAt(const Offset(10, 10)); // dismiss dialog
    await tester.pumpAndSettle();

    expect(find.text('1 / ${lesson.chars.length} explored'), findsOneWidget);
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
}
