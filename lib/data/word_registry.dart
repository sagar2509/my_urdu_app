import '../models/urdu_word.dart';

class WordRegistry {
  /// Easy, real everyday words built from the first letters a beginner
  /// learns, sourced from NCERT's Urdu Class 1 primer (Shehnai, Chapter 1:
  /// "Baarish aur Paraathay"), which teaches joining 2-4 letters into words
  /// such as اب = ا + ب and پانی = پ + ا + ن + ی.
  ///
  /// Each word gets a distinct `family` purely for a varied card color —
  /// same palette the alphabet grid uses.
  static const List<UrduWord> commonWords = [
    UrduWord(urdu: "اب", english: "now", hindi: "अब", family: "alif"),
    UrduWord(urdu: "تب", english: "then", hindi: "तब", family: "boat"),
    UrduWord(urdu: "ٹب", english: "tub", hindi: "टब", family: "hook"),
    UrduWord(urdu: "بات", english: "talk / thing", hindi: "बात", family: "angle"),
    UrduWord(urdu: "پانی", english: "water", hindi: "पानी", family: "slide"),
    UrduWord(urdu: "بابا", english: "grandpa", hindi: "बाबा", family: "stick"),
    UrduWord(urdu: "پاپا", english: "dad", hindi: "पापा", family: "loop"),
    UrduWord(
        urdu: "نانا",
        english: "grandfather (mother's side)",
        hindi: "नाना",
        family: "oval"),
    UrduWord(
        urdu: "نانی",
        english: "grandmother (mother's side)",
        hindi: "नानी",
        family: "vertical"),
    UrduWord(
        urdu: "تایا",
        english: "uncle (father's elder brother)",
        hindi: "ताया",
        family: "ccurve"),
    UrduWord(urdu: "امی", english: "mom", hindi: "अम्मी", family: "round"),
    UrduWord(urdu: "ابو", english: "dad", hindi: "अब्बू", family: "hooked_stick"),
  ];
}
