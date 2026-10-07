import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:my_urdu_app/models/lesson.dart';
import 'package:my_urdu_app/models/quiz_question.dart';
import 'package:my_urdu_app/models/urdu_char.dart';
import 'package:my_urdu_app/models/urdu_word.dart';

void main() {
  group('UrduChar', () {
    test('id returns the glyph', () {
      const char = UrduChar(glyph: 'ا', phonetic: 'Alif', hindi: 'अलिफ़', family: 'alif');
      expect(char.id, 'ا');
    });

    test('hasPositionalForms is false when no forms given', () {
      const char = UrduChar(glyph: '۰', phonetic: 'Zero', hindi: 'शून्य', family: 'number');
      expect(char.hasPositionalForms, isFalse);
    });

    test('hasPositionalForms is true when any form is given', () {
      const char = UrduChar(
        glyph: 'ب',
        phonetic: 'Be',
        hindi: 'बे',
        family: 'boat',
        initial: 'بـ',
      );
      expect(char.hasPositionalForms, isTrue);
    });

    test('familyColor covers every known family and falls back for unknown ones', () {
      const expected = {
        'alif': Colors.red,
        'boat': Colors.blue,
        'hook': Colors.green,
        'angle': Colors.orange,
        'slide': Colors.purple,
        'stick': Colors.teal,
        'loop': Colors.yellow,
        'oval': Colors.pink,
        'vertical': Colors.cyan,
        'ccurve': Colors.lime,
        'round': Colors.indigo,
        'hooked_stick': Colors.brown,
        'vessel': Colors.grey,
        'curve': Colors.amber,
        'number': Colors.blueGrey,
        'hamza': Colors.deepOrange,
      };

      for (final entry in expected.entries) {
        final char = UrduChar(
          glyph: 'x',
          phonetic: 'x',
          hindi: 'x',
          family: entry.key,
        );
        expect(char.familyColor, entry.value.shade50, reason: 'family ${entry.key}');
      }

      const unknown = UrduChar(glyph: 'x', phonetic: 'x', hindi: 'x', family: 'nope');
      expect(unknown.familyColor, Colors.grey.shade100);
    });
  });

  group('UrduWord extra', () {
    test('familyColor uses the shared palette', () {
      const word = UrduWord(urdu: 'اب', english: 'now', hindi: 'अब', family: 'alif');
      expect(word.familyColor, Colors.red.shade50);
    });

    test('familyColor falls back when no family is given', () {
      const word = UrduWord(urdu: 'اب', english: 'now', hindi: 'अब');
      expect(word.familyColor, Colors.grey.shade100);
    });
  });

  test('UrduWord.id returns the Urdu spelling', () {
    const word = UrduWord(urdu: 'پانی', english: 'water', hindi: 'पानी');
    expect(word.id, 'پانی');
  });

  group('QuizQuestion', () {
    const alif = UrduChar(glyph: 'ا', phonetic: 'Alif', hindi: 'अलिफ़', family: 'alif');
    const be = UrduChar(glyph: 'ب', phonetic: 'Be', hindi: 'बे', family: 'boat');

    test('isCorrect is true for the matching glyph', () {
      final question = QuizQuestion(answer: alif, options: [alif, be]);
      expect(question.isCorrect(alif), isTrue);
    });

    test('isCorrect is false for a different glyph', () {
      final question = QuizQuestion(answer: alif, options: [alif, be]);
      expect(question.isCorrect(be), isFalse);
    });
  });

  group('Lesson variants', () {
    const alif = UrduChar(glyph: 'ا', phonetic: 'Alif', hindi: 'अलिफ़', family: 'alif');
    const word = UrduWord(urdu: 'اب', english: 'now', hindi: 'अब');

    test('CharLesson.chars invokes the builder', () {
      final lesson = CharLesson(
        id: 'l',
        title: 'L',
        icon: Icons.abc,
        charsBuilder: () => [alif],
      );
      expect(lesson.chars, [alif]);
    });

    test('WordLesson.words invokes the builder', () {
      final lesson = WordLesson(
        id: 'l',
        title: 'L',
        icon: Icons.abc,
        wordsBuilder: () => [word],
      );
      expect(lesson.words, [word]);
    });

    test('WritingLesson.words invokes the builder', () {
      final lesson = WritingLesson(
        id: 'l',
        title: 'L',
        icon: Icons.abc,
        wordsBuilder: () => [word],
      );
      expect(lesson.words, [word]);
    });

    test('Module holds its lessons', () {
      final lesson = CharLesson(id: 'l', title: 'L', icon: Icons.abc, charsBuilder: () => [alif]);
      final module = Module(id: 'm', title: 'M', icon: Icons.book, lessons: [lesson]);
      expect(module.lessons, [lesson]);
    });
  });
}
