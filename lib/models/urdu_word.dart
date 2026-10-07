/// A short Urdu word used in a [WritingLesson] assignment, with its
/// meaning in English and Hindi so a prompt can be shown in either.
class UrduWord {
  final String urdu;
  final String english;
  final String hindi;

  const UrduWord({
    required this.urdu,
    required this.english,
    required this.hindi,
  });

  /// A stable identity for progress tracking.
  String get id => urdu;
}
