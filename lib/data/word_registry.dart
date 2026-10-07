import '../models/urdu_word.dart';

class WordRegistry {
  /// Common, real two-letter Urdu words (exactly two Urdu alphabet
  /// characters each) with their English and Hindi meanings.
  static const List<UrduWord> twoLetterWords = [
    UrduWord(urdu: "اب", english: "now", hindi: "अब"),
    UrduWord(urdu: "تب", english: "then", hindi: "तब"),
    UrduWord(urdu: "جب", english: "when", hindi: "जब"),
    UrduWord(urdu: "سب", english: "all / everyone", hindi: "सब"),
    UrduWord(urdu: "کب", english: "when? (question)", hindi: "कब"),
    UrduWord(urdu: "کل", english: "yesterday / tomorrow", hindi: "कल"),
    UrduWord(urdu: "دل", english: "heart", hindi: "दिल"),
    UrduWord(urdu: "پل", english: "moment", hindi: "पल"),
    UrduWord(urdu: "سر", english: "head", hindi: "सिर"),
    UrduWord(urdu: "کم", english: "less", hindi: "कम"),
    UrduWord(urdu: "یہ", english: "this", hindi: "यह"),
    UrduWord(urdu: "وہ", english: "that", hindi: "वह"),
    UrduWord(urdu: "تو", english: "then / so", hindi: "तो"),
    UrduWord(urdu: "جو", english: "which / that", hindi: "जो"),
    UrduWord(urdu: "ہم", english: "we", hindi: "हम"),
    UrduWord(urdu: "تم", english: "you (informal)", hindi: "तुम"),
    UrduWord(urdu: "تک", english: "until", hindi: "तक"),
  ];
}
