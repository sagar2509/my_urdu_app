import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:my_urdu_app/app.dart';
import 'package:my_urdu_app/services/progress_service.dart';
import 'package:my_urdu_app/state/progress_provider.dart';
import 'package:my_urdu_app/screens/lesson_screen.dart';
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
    final lesson = ModuleRegistry.modules.first.lessons.first;

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
}
