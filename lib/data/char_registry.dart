import '../models/urdu_char.dart';

class CharRegistry {
  static List<UrduChar> getAllChars() {
    return [
      // 1. Alif (The Vertical Stick)
      UrduChar(
          glyph: "ا",
          phonetic: "Alif",
          hindi: "अलिफ़",
          family: "alif",
          initial: "ا",
          middle: "ـا",
          finalForm: "ـا"),

      // 2. Alif Madda (The Alif with a Wave)
      UrduChar(
          glyph: "آ",
          phonetic: "Alif Madda",
          hindi: "अलिफ़ मद्दा",
          isDelta: true,
          family: "alif",
          initial: "آ",
          middle: "ـآ",
          finalForm: "ـآ"),

      // 3. Be (The Boat)
      UrduChar(
          glyph: "ب",
          phonetic: "Be",
          hindi: "बे",
          family: "boat",
          initial: "بـ",
          middle: "ـبـ",
          finalForm: "ـب"),

      // 4. Pe (The Boat with a Dot)
      UrduChar(
          glyph: "پ",
          phonetic: "Pe",
          hindi: "पे",
          isDelta: true,
          family: "boat",
          initial: "پـ",
          middle: "ـپـ",
          finalForm: "ـپ"),

      // 5. Te (The Boat with a Dot)
      UrduChar(
          glyph: "ت",
          phonetic: "Te",
          hindi: "ते",
          family: "boat",
          initial: "تـ",
          middle: "ـتـ",
          finalForm: "ـت"),

      // 6. Tte (The Boat with Two Dots)
      UrduChar(
          glyph: "ٹ",
          phonetic: "Tte",
          hindi: "टे",
          isDelta: true,
          family: "boat",
          initial: "ٹـ",
          middle: "ـٹـ",
          finalForm: "ـٹ"),

      // 7. Se (The Boat with a Dot)
      UrduChar(
          glyph: "ث",
          phonetic: "Se",
          hindi: "से",
          family: "boat",
          initial: "ثـ",
          middle: "ـثـ",
          finalForm: "ـث"),

      // 8. Jeem (The Hook)
      UrduChar(
          glyph: "ج",
          phonetic: "Jeem",
          hindi: "जीम",
          family: "hook",
          initial: "جـ",
          middle: "ـجـ",
          finalForm: "ـج"),

      // 9. Che (The Hook with a Dot)
      UrduChar(
          glyph: "چ",
          phonetic: "Che",
          hindi: "चे",
          isDelta: true,
          family: "hook",
          initial: "چـ",
          middle: "ـچـ",
          finalForm: "ـچ"),

      // 10. He (The Hook with a Dot)
      UrduChar(
          glyph: "ح",
          phonetic: "Barri He",
          hindi: "बड़ी हे",
          family: "hook",
          initial: "حـ",
          middle: "ـحـ",
          finalForm: "ـح"),

      // 11. Khe (The Hook with a Dot)
      UrduChar(
          glyph: "خ",
          phonetic: "Khe",
          hindi: "खे",
          family: "hook",
          initial: "خـ",
          middle: "ـخـ",
          finalForm: "ـخ"),

      // 12. Dal (The Angle)
      UrduChar(
          glyph: "د",
          phonetic: "Dal",
          hindi: "दाल",
          family: "angle",
          initial: "د",
          middle: "ـد",
          finalForm: "ـد"),

      // 13. Ddal (The Angle with a Dot)
      UrduChar(
          glyph: "ڈ",
          phonetic: "Ddal",
          hindi: "डाल",
          isDelta: true,
          family: "angle",
          initial: "ڈ",
          middle: "ـڈ",
          finalForm: "ـڈ"),

      // 14. Zaal (The Angle with a Dot)
      UrduChar(
          glyph: "ذ",
          phonetic: "Zaal",
          hindi: "ज़ाल",
          family: "angle",
          initial: "ذ",
          middle: "ـذ",
          finalForm: "ـذ"),

      // 15. Re (The Slide)
      UrduChar(
          glyph: "ر",
          phonetic: "Re",
          hindi: "रे",
          family: "slide",
          initial: "ر",
          middle: "ـر",
          finalForm: "ـر"),

      // 16. Rre (The Slide with a Dot)
      UrduChar(
          glyph: "ڑ",
          phonetic: "Rre",
          hindi: "ड़े",
          isDelta: true,
          family: "slide",
          initial: "ڑ",
          middle: "ـڑ",
          finalForm: "ـڑ"),

      // 17. Ze (The Slide with a Dot)
      UrduChar(
          glyph: "ز",
          phonetic: "Ze",
          hindi: "ज़े",
          family: "slide",
          initial: "ز",
          middle: "ـز",
          finalForm: "ـز"),

      // 18. Zhe (The Slide with a Dot)
      UrduChar(
          glyph: "ژ",
          phonetic: "Zhe",
          hindi: "झ़े",
          isDelta: true,
          family: "slide",
          initial: "ژ",
          middle: "ـژ",
          finalForm: "ـژ"),

      // 19. Seen (The Loop)
      UrduChar(
          glyph: "س",
          phonetic: "Seen",
          hindi: "सीन",
          family: "loop",
          initial: "سـ",
          middle: "ـسـ",
          finalForm: "ـس"),

      // 20. Sheen (The Loop with a Dot)
      UrduChar(
          glyph: "ش",
          phonetic: "Sheen",
          hindi: "शीन",
          family: "loop",
          initial: "شـ",
          middle: "ـشـ",
          finalForm: "ـش"),

      // 21. Suad (The Oval)
      UrduChar(
          glyph: "ص",
          phonetic: "Suad",
          hindi: "स्वाद",
          family: "oval",
          initial: "صـ",
          middle: "ـصـ",
          finalForm: "ـص"),

      // 22. Zuad (The Oval with a Dot)
      UrduChar(
          glyph: "ض",
          phonetic: "Zuad",
          hindi: "ज़्वाद",
          family: "oval",
          initial: "ضـ",
          middle: "ـضـ",
          finalForm: "ـض"),

      // 23. Toay (The Vertical)
      UrduChar(
          glyph: "ط",
          phonetic: "Toay",
          hindi: "तोए",
          family: "vertical",
          initial: "طـ",
          middle: "ـطـ",
          finalForm: "ـط"),

      // 24. Zoay (The Vertical with a Dot)
      UrduChar(
          glyph: "ظ",
          phonetic: "Zoay",
          hindi: "ज़ोए",
          family: "vertical",
          initial: "ظـ",
          middle: "ـظـ",
          finalForm: "ـظ"),

      // 25. Ain (The C-Curve)
      UrduChar(
          glyph: "ع",
          phonetic: "Ain",
          hindi: "ऐन",
          family: "ccurve",
          initial: "عـ",
          middle: "ـعـ",
          finalForm: "ـع"),

      // 26. Ghain (The C-Curve with a Dot)
      UrduChar(
          glyph: "غ",
          phonetic: "Ghain",
          hindi: "ग़ैन",
          family: "ccurve",
          initial: "غـ",
          middle: "ـغـ",
          finalForm: "ـغ"),

      // 27. Fe (The Round)
      UrduChar(
          glyph: "ف",
          phonetic: "Fe",
          hindi: "फ़े",
          family: "round",
          initial: "فـ",
          middle: "ـفـ",
          finalForm: "ـف"),

      // 28. Qaaf (The Round with a Dot)
      UrduChar(
          glyph: "ق",
          phonetic: "Qaaf",
          hindi: "क़ाफ़",
          family: "round",
          initial: "قـ",
          middle: "ـقـ",
          finalForm: "ـق"),

      // 29. Kaaf (The Stick)
      UrduChar(
          glyph: "ک",
          phonetic: "Kaaf",
          hindi: "काफ़",
          family: "stick",
          initial: "کـ",
          middle: "ـکـ",
          finalForm: "ـک"),

      // 30. Gaaf (The Stick with a Dot)
      UrduChar(
          glyph: "گ",
          phonetic: "Gaaf",
          hindi: "गाफ़",
          isDelta: true,
          family: "stick",
          initial: "گـ",
          middle: "ـگـ",
          finalForm: "ـگ"),

      // 31. Lām (The Stick with a Hook)
      UrduChar(
          glyph: "ل",
          phonetic: "Laam",
          hindi: "लाम",
          family: "hooked_stick",
          initial: "لـ",
          middle: "ـلـ",
          finalForm: "ـل"),

      // 32. Meem (The Loop)
      UrduChar(
          glyph: "م",
          phonetic: "Meem",
          hindi: "मीम",
          family: "loop",
          initial: "مـ",
          middle: "ـمـ",
          finalForm: "ـم"),

      // 33. Nūn (The Vessel)
      UrduChar(
          glyph: "ن",
          phonetic: "Noon",
          hindi: "नून",
          family: "vessel",
          initial: "نـ",
          middle: "ـنـ",
          finalForm: "ـن"),

      // 34. Nūn Ghunna (Nasalization - No Dot)
      UrduChar(
          glyph: "ں",
          phonetic: "Noon Ghunna",
          hindi: "नून ग़ुन्ना",
          isDelta: true,
          family: "vessel",
          initial: "ں",
          middle: "ـں",
          finalForm: "ـں"),

      // 35. Vāo (The Curve)
      UrduChar(
          glyph: "و",
          phonetic: "Wao",
          hindi: "वाओ",
          family: "slide",
          initial: "و",
          middle: "ـو",
          finalForm: "ـو"),

      // 36. Choti Ye (The "ee" sound)
      UrduChar(
          glyph: "ی",
          phonetic: "Choti Ye",
          hindi: "छोटी ये",
          family: "curve",
          initial: "یـ",
          middle: "ـیـ",
          finalForm: "ـی"),

      // 37. Bari Ye (The "ay" sound)
      UrduChar(
          glyph: "ے",
          phonetic: "Bari Ye",
          hindi: "बड़ी ये",
          isDelta: true,
          family: "curve",
          initial: "ے",
          middle: "ـے",
          finalForm: "ـے"),

      // 38. Hamza (A glottal stop mark, usually standalone or seated on a letter)
      UrduChar(
          glyph: "ء",
          phonetic: "Hamza",
          hindi: "हम्ज़ा",
          family: "hamza"),

      // 39. Choti He (The Round He)
      UrduChar(
          glyph: "ہ",
          phonetic: "Choti He",
          hindi: "छोटी हे",
          family: "hook",
          initial: "ہـ",
          middle: "ـہـ",
          finalForm: "ـہ"),

      // 39. Do-Chashmi He (The Butterfly/Aspiration)
      UrduChar(
          glyph: "ھ",
          phonetic: "Do-Chashmi He",
          hindi: "दो चश्मी हे",
          isDelta: true,
          family: "hook",
          initial: "ھـ",
          middle: "ـھـ",
          finalForm: "ـھ"),
    ];
  }

  static List<UrduChar> get masterList => getAllChars();

  // Each digit gets a distinct family purely for a varied card color — same
  // palette the alphabet grid uses, so Numbers doesn't look flat by comparison.
  static List<UrduChar> get urduNumbers => [
        UrduChar(glyph: "۰", phonetic: "Zero", hindi: "शून्य", family: "alif"),
        UrduChar(glyph: "۱", phonetic: "One", hindi: "एक", family: "boat"),
        UrduChar(glyph: "۲", phonetic: "Two", hindi: "दो", family: "hook"),
        UrduChar(glyph: "۳", phonetic: "Three", hindi: "तीन", family: "angle"),
        UrduChar(glyph: "۴", phonetic: "Four", hindi: "चार", family: "slide"),
        UrduChar(glyph: "۵", phonetic: "Five", hindi: "पांच", family: "stick"),
        UrduChar(glyph: "۶", phonetic: "Six", hindi: "छह", family: "loop"),
        UrduChar(glyph: "۷", phonetic: "Seven", hindi: "सात", family: "oval"),
        UrduChar(glyph: "۸", phonetic: "Eight", hindi: "आठ", family: "vertical"),
        UrduChar(glyph: "۹", phonetic: "Nine", hindi: "नौ", family: "ccurve"),
      ];
}
