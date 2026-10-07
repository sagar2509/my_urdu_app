import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:my_urdu_app/app.dart';
import 'package:my_urdu_app/services/progress_service.dart';

import '../test_helpers.dart';

Future<void> main() async {
  late ProgressService progressService;

  setUp(() async {
    mockFlutterTtsChannel();
    SharedPreferences.setMockInitialValues({});
    progressService = await ProgressService.create();
  });

  Future<void> openDrawer(WidgetTester tester) async {
    await tester.pumpWidget(UrduCoreApp(progressService: progressService));
    await tester.pumpAndSettle();
    await tester.tap(find.byIcon(Icons.menu));
    await tester.pumpAndSettle();
  }

  testWidgets('navigates to the Alphabet lesson (CharLesson)', (tester) async {
    await openDrawer(tester);
    await tester.tap(find.widgetWithText(ListTile, 'Alphabet'));
    await tester.pumpAndSettle();

    expect(find.text('Alphabet'), findsWidgets);
    expect(find.text('Urdu Alphabets Only'), findsOneWidget);
  });

  testWidgets('navigates to Urdu Numbers (CharLesson, LTR)', (tester) async {
    await openDrawer(tester);
    await tester.tap(find.widgetWithText(ListTile, 'Urdu Numbers'));
    await tester.pumpAndSettle();

    expect(find.text('Zero'), findsOneWidget);
  });

  testWidgets('navigates to Learn: Common Words (WordLesson)', (tester) async {
    await openDrawer(tester);
    await tester.tap(find.widgetWithText(ListTile, 'Learn: Common Words'));
    await tester.pumpAndSettle();

    expect(find.text('now'), findsOneWidget);
  });

  testWidgets('navigates to Practice: Write Common Words (WritingLesson)',
      (tester) async {
    await openDrawer(tester);
    await tester.tap(find.widgetWithText(ListTile, 'Practice: Write Common Words'));
    await tester.pumpAndSettle();

    expect(find.textContaining('Question 1 of'), findsOneWidget);
  });

  testWidgets('Home tile returns to the home screen', (tester) async {
    await openDrawer(tester);
    await tester.tap(find.widgetWithText(ListTile, 'Alphabet'));
    await tester.pumpAndSettle();

    await tester.tap(find.byIcon(Icons.menu));
    await tester.pumpAndSettle();
    await tester.tap(find.widgetWithText(ListTile, 'Home'));
    await tester.pumpAndSettle();

    expect(find.text('Begin with the Alphabet'), findsOneWidget);
  });
}
