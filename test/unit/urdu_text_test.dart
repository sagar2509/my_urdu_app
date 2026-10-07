import 'package:flutter_test/flutter_test.dart';
import 'package:my_urdu_app/core/urdu_text.dart';

void main() {
  group('normalizeUrdu', () {
    test('maps Arabic Yeh to Urdu Yeh', () {
      expect(normalizeUrdu('علي'), normalizeUrdu('علی'));
    });

    test('maps Alef Maksura to Urdu Yeh', () {
      expect(normalizeUrdu('على'), normalizeUrdu('علی'));
    });

    test('maps Arabic Kaf to Urdu Keheh', () {
      expect(normalizeUrdu('كتاب'), normalizeUrdu('کتاب'));
    });

    test('strips harakat diacritics', () {
      expect(normalizeUrdu('اَبّ'), 'اب');
    });

    test('strips tatweel and zero-width joiners', () {
      expect(normalizeUrdu('اـب‌‍'), 'اب');
    });

    test('collapses internal whitespace and trims', () {
      expect(normalizeUrdu('  اب   سب  '), 'اب سب');
    });
  });

  group('urduTextMatches', () {
    test('matches equivalent spellings after normalization', () {
      expect(urduTextMatches(' كتاب ', 'کتاب'), isTrue);
    });

    test('does not match different words', () {
      expect(urduTextMatches('اب', 'تب'), isFalse);
    });
  });

  group('splitIntoLetters', () {
    test('splits a word into its base letters, diacritics stripped', () {
      expect(splitIntoLetters('پانی'), ['پ', 'ا', 'ن', 'ی']);
    });

    test('splits a two-letter word', () {
      expect(splitIntoLetters('اب'), ['ا', 'ب']);
    });
  });
}
