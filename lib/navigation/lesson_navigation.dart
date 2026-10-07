import 'package:flutter/material.dart';
import '../models/lesson.dart';
import '../screens/lesson_screen.dart';
import '../screens/writing_practice_screen.dart';

/// Maps a [Lesson] to the screen that renders it. The `switch` over the
/// sealed [Lesson] hierarchy is exhaustive — adding a new Lesson variant
/// without a case here is a compile error, not a silent gap.
Widget screenForLesson(Lesson lesson) {
  return switch (lesson) {
    CharLesson() => LessonScreen(lesson: lesson),
    WritingLesson() => WritingPracticeScreen(lesson: lesson),
  };
}

void pushLesson(BuildContext context, Lesson lesson) {
  Navigator.of(context).push(
    MaterialPageRoute(builder: (_) => screenForLesson(lesson)),
  );
}

/// Used by the drawer: closes itself, then replaces the whole stack down to
/// the home screen with the chosen lesson (mirrors switching "tabs").
void openLessonFromDrawer(BuildContext context, Lesson lesson) {
  Navigator.pop(context);
  Navigator.of(context).pushAndRemoveUntil(
    MaterialPageRoute(builder: (_) => screenForLesson(lesson)),
    (route) => route.isFirst,
  );
}
