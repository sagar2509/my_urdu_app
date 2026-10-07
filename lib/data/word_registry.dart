import '../models/urdu_word.dart';

class WordRegistry {
  /// Easy, real everyday words built from the first letters a beginner
  /// learns, sourced from NCERT's Urdu Class 1 primer (Shehnai, Chapter 1:
  /// "Baarish aur Paraathay"), which teaches joining 2-4 letters into words
  /// such as اب = ا + ب and پانی = پ + ا + ن + ی.
  static const List<UrduWord> commonWords = [
    UrduWord(urdu: "اب", english: "now", hindi: "अब"),
    UrduWord(urdu: "تب", english: "then", hindi: "तब"),
    UrduWord(urdu: "ٹب", english: "tub", hindi: "टब"),
    UrduWord(urdu: "بات", english: "talk / thing", hindi: "बात"),
    UrduWord(urdu: "پانی", english: "water", hindi: "पानी"),
    UrduWord(urdu: "بابا", english: "grandpa", hindi: "बाबा"),
    UrduWord(urdu: "پاپا", english: "dad", hindi: "पापा"),
    UrduWord(urdu: "نانا", english: "grandfather (mother's side)", hindi: "नाना"),
    UrduWord(urdu: "نانی", english: "grandmother (mother's side)", hindi: "नानी"),
    UrduWord(urdu: "تایا", english: "uncle (father's elder brother)", hindi: "ताया"),
  ];
}
