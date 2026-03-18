import '../data/char_registry.dart';
import '../models/urdu_char.dart';

class ChapterData {
  static List<UrduChar> getMasterList() {
    return CharRegistry.masterList;
  }

  static List<UrduChar> getBasics() {
    final parents = ["ا", "ب", "ج", "د", "ر", "س", "ص", "ط", "ع", "ف", "ک"];
    return CharRegistry.masterList
        .where((c) => parents.contains(c.glyph))
        .toList();
  }

  static List<UrduChar> getAdvanced() {
    // Logic: Everything except the 11 base shapes
    final parents = ["ا", "ب", "ج", "د", "ر", "س", "ص", "ط", "ع", "ف", "ک"];
    return CharRegistry.masterList
        .where((c) => !parents.contains(c.glyph))
        .toList();
  }

  static List<UrduChar> getUrduSpecials() {
    return CharRegistry.masterList.where((c) => c.isDelta).toList();
  }
}
