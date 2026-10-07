/// Normalizes Urdu text typed on a real device keyboard before comparing it
/// against a canonical answer. Different keyboards/locales (Arabic vs. Urdu)
/// produce visually-identical but code-point-different letters for the same
/// sound (e.g. Arabic Yeh vs. Urdu Yeh), and some insert invisible joiners or
/// diacritics a beginner never typed — none of that should fail a correct answer.
String normalizeUrdu(String input) {
  var result = input.trim();

  const letterVariants = {
    'ي': 'ی', // Arabic Yeh ي -> Urdu Yeh ی
    'ى': 'ی', // Alef Maksura ى -> Urdu Yeh ی
    'ك': 'ک', // Arabic Kaf ك -> Urdu Keheh ک
  };
  letterVariants.forEach((from, to) {
    result = result.replaceAll(from, to);
  });

  // Strip harakat/tanween diacritics and tatweel/zero-width joiners that
  // some keyboards insert automatically.
  final toStrip = RegExp(
    '[ً-ْـ​-‍]',
  );
  result = result.replaceAll(toStrip, '');

  return result.replaceAll(RegExp(r'\s+'), ' ').trim();
}

bool urduTextMatches(String input, String answer) {
  return normalizeUrdu(input) == normalizeUrdu(answer);
}
