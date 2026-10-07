import 'package:flutter_test/flutter_test.dart';
import 'package:my_urdu_app/data/char_registry.dart';
import 'package:my_urdu_app/data/module_registry.dart';
import 'package:my_urdu_app/data/word_registry.dart';
import 'package:my_urdu_app/models/lesson.dart';

void main() {
  group('CharRegistry', () {
    test('masterList has 40 letters including Hamza', () {
      final glyphs = CharRegistry.masterList.map((c) => c.glyph).toList();
      expect(CharRegistry.masterList.length, 40);
      expect(glyphs, contains('ء'));
      expect(glyphs.toSet().length, glyphs.length, reason: 'no duplicate glyphs');
    });

    test('urduNumbers has the 10 digits', () {
      expect(CharRegistry.urduNumbers.length, 10);
      expect(CharRegistry.urduNumbers.first.phonetic, 'Zero');
      expect(CharRegistry.urduNumbers.last.phonetic, 'Nine');
    });
  });

  group('WordRegistry', () {
    test('commonWords includes the family vocabulary from the NCERT primer', () {
      final urduWords = WordRegistry.commonWords.map((w) => w.urdu).toList();
      expect(urduWords, containsAll(['اب', 'پانی', 'امی', 'ابو']));
    });
  });

  group('ModuleRegistry', () {
    test('has Module 1 (Alphabet) and Module 2 (Words)', () {
      expect(ModuleRegistry.modules.length, 2);
      expect(ModuleRegistry.modules[0].id, 'module_1');
      expect(ModuleRegistry.modules[1].id, 'module_2');
    });

    test('allLessons flattens every module\'s lessons', () {
      final ids = ModuleRegistry.allLessons.map((l) => l.id).toList();
      expect(ids, containsAll(['alphabet', 'numbers', 'common_words_learn', 'common_words_practice']));
    });

    test('findLesson returns the matching lesson', () {
      final lesson = ModuleRegistry.findLesson('numbers');
      expect(lesson, isNotNull);
      expect(lesson!.title, 'Urdu Numbers');
      expect(lesson, isA<CharLesson>());
    });

    test('findLesson returns null for an unknown id', () {
      expect(ModuleRegistry.findLesson('does_not_exist'), isNull);
    });
  });
}
