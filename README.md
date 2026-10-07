# Urdu Core

A Flutter app for absolute beginners learning to read and write Urdu, built
around short, focused modules rather than one long lesson.

## What's in the app

**Module 1: Alphabet**
- **Alphabet** — all 40 Urdu letters (including Hamza) in a searchable,
  filterable grid. Tap a letter to see its Hindi transliteration, hear it
  pronounced, and see how it joins with neighboring letters (initial/middle/
  final forms) — plus a multiple-choice quiz.
- **Urdu Numbers** — the ten Urdu-Indic digits, same browse-then-quiz pattern.

**Module 2: Words**
- **Learn: Common Words** — real, easy words sourced from NCERT's Urdu Class 1
  primer (e.g. اب, پانی, بابا, امی), each broken down letter-by-letter.
- **Practice: Write Common Words** — the word's meaning is shown in English or
  Hindi, and you type the Urdu spelling yourself using your device's own Urdu
  keyboard. Answers are checked leniently (Arabic/Urdu keyboard variants and
  diacritics are normalized before comparing).

Progress (letters/words viewed, best quiz/practice scores) is saved on-device
with `shared_preferences`.

## Architecture

```
lib/
  models/      Data classes: UrduChar, UrduWord, Lesson (sealed: CharLesson /
               WordLesson / WritingLesson), QuizQuestion
  data/        CharRegistry, WordRegistry, ModuleRegistry — the single source
               of truth for content; adding a module/lesson only touches here
  services/    ProgressService (persistence), AudioService (TTS pronunciation)
  state/       ProgressProvider — app-wide progress, exposed via provider
  navigation/  Maps a Lesson to its screen (exhaustive switch over the sealed
               Lesson hierarchy)
  screens/     HomeScreen, LessonScreen, WordLessonScreen, QuizScreen,
               WritingPracticeScreen
  widgets/     Reusable UI: AppDrawer, CharCard, WordCard, detail dialogs
  core/        Theme, app-wide constants, Urdu text normalization helpers
```

## Running it

```bash
flutter pub get
flutter run -d chrome   # or an attached device/simulator
```

## Testing

```bash
flutter test                 # full suite
flutter test --coverage      # writes coverage/lcov.info
```

Tests are split into `test/unit/` (models, data registries, services, state)
and `test/widget/` (screen-level interaction), plus the top-level
`test/widget_test.dart` for app-wide smoke tests.
