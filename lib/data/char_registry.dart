import '../models/urdu_char.dart';

class CharRegistry {
  static List<UrduChar> getAllChars() {
    return [
      // 1. Alif (The Vertical Stick)
      UrduChar(
          glyph: "ا",
          phonetic: "Alif",
          family: "alif",
          initial: "ا",
          middle: "ـا",
          finalForm: "ـا"),

      // 2. Alif Madda (The Alif with a Wave)
      UrduChar(
          glyph: "آ",
          phonetic: "Alif Madda",
          isDelta: true,
          family: "alif",
          initial: "آ",
          middle: "ـآ",
          finalForm: "ـآ"),

      // 3. Be (The Boat)
      UrduChar(
          glyph: "ب",
          phonetic: "Be",
          family: "boat",
          initial: "بـ",
          middle: "ـبـ",
          finalForm: "ـب"),

      // 4. Pe (The Boat with a Dot)
      UrduChar(
          glyph: "پ",
          phonetic: "Pe",
          isDelta: true,
          family: "boat",
          initial: "پـ",
          middle: "ـپـ",
          finalForm: "ـپ"),

      // 5. Te (The Boat with a Dot)
      UrduChar(
          glyph: "ت",
          phonetic: "Te",
          family: "boat",
          initial: "تـ",
          middle: "ـتـ",
          finalForm: "ـت"),

      // 6. Tte (The Boat with Two Dots)
      UrduChar(
          glyph: "ٹ",
          phonetic: "Tte",
          isDelta: true,
          family: "boat",
          initial: "ٹـ",
          middle: "ـٹـ",
          finalForm: "ـٹ"),

      // 7. Se (The Boat with a Dot)
      UrduChar(
          glyph: "ث",
          phonetic: "Se",
          family: "boat",
          initial: "ثـ",
          middle: "ـثـ",
          finalForm: "ـث"),

      // 8. Jeem (The Hook)
      UrduChar(
          glyph: "ج",
          phonetic: "Jeem",
          family: "hook",
          initial: "جـ",
          middle: "ـجـ",
          finalForm: "ـج"),

      // 9. Che (The Hook with a Dot)
      UrduChar(
          glyph: "چ",
          phonetic: "Che",
          isDelta: true,
          family: "hook",
          initial: "چـ",
          middle: "ـچـ",
          finalForm: "ـچ"),

      // 10. He (The Hook with a Dot)
      UrduChar(
          glyph: "ح",
          phonetic: "Barri He",
          family: "hook",
          initial: "حـ",
          middle: "ـحـ",
          finalForm: "ـح"),

      // 11. Khe (The Hook with a Dot)
      UrduChar(
          glyph: "خ",
          phonetic: "Khe",
          family: "hook",
          initial: "خـ",
          middle: "ـخـ",
          finalForm: "ـخ"),

      // 12. Dal (The Angle)
      UrduChar(
          glyph: "د",
          phonetic: "Dal",
          family: "angle",
          initial: "د",
          middle: "ـد",
          finalForm: "ـد"),

      // 13. Ddal (The Angle with a Dot)
      UrduChar(
          glyph: "ڈ",
          phonetic: "Ddal",
          isDelta: true,
          family: "angle",
          initial: "ڈ",
          middle: "ـڈ",
          finalForm: "ـڈ"),

      // 14. Zaal (The Angle with a Dot)
      UrduChar(
          glyph: "ذ",
          phonetic: "Zaal",
          family: "angle",
          initial: "ذ",
          middle: "ـذ",
          finalForm: "ـذ"),

      // 15. Re (The Slide)
      UrduChar(
          glyph: "ر",
          phonetic: "Re",
          family: "slide",
          initial: "ر",
          middle: "ـر",
          finalForm: "ـر"),

      // 16. Rre (The Slide with a Dot)
      UrduChar(
          glyph: "ڑ",
          phonetic: "Rre",
          isDelta: true,
          family: "slide",
          initial: "ڑ",
          middle: "ـڑ",
          finalForm: "ـڑ"),

      // 17. Ze (The Slide with a Dot)
      UrduChar(
          glyph: "ز",
          phonetic: "Ze",
          family: "slide",
          initial: "ز",
          middle: "ـز",
          finalForm: "ـز"),

      // 18. Zhe (The Slide with a Dot)
      UrduChar(
          glyph: "ژ",
          phonetic: "Zhe",
          isDelta: true,
          family: "slide",
          initial: "ژ",
          middle: "ـژ",
          finalForm: "ـژ"),

      // 19. Seen (The Loop)
      UrduChar(
          glyph: "س",
          phonetic: "Seen",
          family: "loop",
          initial: "سـ",
          middle: "ـسـ",
          finalForm: "ـس"),

      // 20. Sheen (The Loop with a Dot)
      UrduChar(
          glyph: "ش",
          phonetic: "Sheen",
          family: "loop",
          initial: "شـ",
          middle: "ـشـ",
          finalForm: "ـش"),

      // 21. Suad (The Oval)
      UrduChar(
          glyph: "ص",
          phonetic: "Suad",
          family: "oval",
          initial: "صـ",
          middle: "ـصـ",
          finalForm: "ـص"),

      // 22. Zuad (The Oval with a Dot)
      UrduChar(
          glyph: "ض",
          phonetic: "Zuad",
          family: "oval",
          initial: "ضـ",
          middle: "ـضـ",
          finalForm: "ـض"),

      // 23. Toay (The Vertical)
      UrduChar(
          glyph: "ط",
          phonetic: "Toay",
          family: "vertical",
          initial: "طـ",
          middle: "ـطـ",
          finalForm: "ـط"),

      // 24. Zoay (The Vertical with a Dot)
      UrduChar(
          glyph: "ظ",
          phonetic: "Zoay",
          family: "vertical",
          initial: "ظـ",
          middle: "ـظـ",
          finalForm: "ـظ"),

      // 25. Ain (The C-Curve)
      UrduChar(
          glyph: "ع",
          phonetic: "Ain",
          family: "ccurve",
          initial: "عـ",
          middle: "ـعـ",
          finalForm: "ـع"),

      // 26. Ghain (The C-Curve with a Dot)
      UrduChar(
          glyph: "غ",
          phonetic: "Ghain",
          family: "ccurve",
          initial: "غـ",
          middle: "ـغـ",
          finalForm: "ـغ"),

      // 27. Fe (The Round)
      UrduChar(
          glyph: "ف",
          phonetic: "Fe",
          family: "round",
          initial: "فـ",
          middle: "ـفـ",
          finalForm: "ـف"),

      // 28. Qaaf (The Round with a Dot)
      UrduChar(
          glyph: "ق",
          phonetic: "Qaaf",
          family: "round",
          initial: "قـ",
          middle: "ـقـ",
          finalForm: "ـق"),

      // 29. Kaaf (The Stick)
      UrduChar(
          glyph: "ک",
          phonetic: "Kaaf",
          family: "stick",
          initial: "کـ",
          middle: "ـکـ",
          finalForm: "ـک"),

      // 30. Gaaf (The Stick with a Dot)
      UrduChar(
          glyph: "گ",
          phonetic: "Gaaf",
          isDelta: true,
          family: "stick",
          initial: "گـ",
          middle: "ـگـ",
          finalForm: "ـگ"),

      // 31. Lām (The Stick with a Hook)
      UrduChar(
          glyph: "ل",
          phonetic: "Laam",
          family: "hooked_stick",
          initial: "لـ",
          middle: "ـلـ",
          finalForm: "ـل"),

      // 32. Meem (The Loop)
      UrduChar(
          glyph: "م",
          phonetic: "Meem",
          family: "loop",
          initial: "مـ",
          middle: "ـمـ",
          finalForm: "ـم"),

      // 33. Nūn (The Vessel)
      UrduChar(
          glyph: "ن",
          phonetic: "Noon",
          family: "vessel",
          initial: "نـ",
          middle: "ـنـ",
          finalForm: "ـن"),

      // 34. Nūn Ghunna (Nasalization - No Dot)
      UrduChar(
          glyph: "ں",
          phonetic: "Noon Ghunna",
          isDelta: true,
          family: "vessel",
          initial: "ں",
          middle: "ـں",
          finalForm: "ـں"),

      // 35. Vāo (The Curve)
      UrduChar(
          glyph: "و",
          phonetic: "Wao",
          family: "slide",
          initial: "و",
          middle: "ـو",
          finalForm: "ـو"),

      // 36. Choti Ye (The "ee" sound)
      UrduChar(
          glyph: "ی",
          phonetic: "Choti Ye",
          family: "curve",
          initial: "یـ",
          middle: "ـیـ",
          finalForm: "ـی"),

      // 37. Bari Ye (The "ay" sound)
      UrduChar(
          glyph: "ے",
          phonetic: "Bari Ye",
          isDelta: true,
          family: "curve",
          initial: "ے",
          middle: "ـے",
          finalForm: "ـے"),

      // 38. Choti He (The Round He)
      UrduChar(
          glyph: "ہ",
          phonetic: "Choti He",
          family: "hook",
          initial: "ہـ",
          middle: "ـہـ",
          finalForm: "ـہ"),

      // 39. Do-Chashmi He (The Butterfly/Aspiration)
      UrduChar(
          glyph: "ھ",
          phonetic: "Do-Chashmi He",
          isDelta: true,
          family: "hook",
          initial: "ھـ",
          middle: "ـھـ",
          finalForm: "ـھ"),
    ];
  }

  static List<UrduChar> get masterList => getAllChars();

  static List<UrduChar> get urduNumbers => [
        UrduChar(glyph: "۰", phonetic: "Zero", family: "number"),
        UrduChar(glyph: "۱", phonetic: "One", family: "number"),
        UrduChar(glyph: "۲", phonetic: "Two", family: "number"),
        UrduChar(glyph: "۳", phonetic: "Three", family: "number"),
        UrduChar(glyph: "۴", phonetic: "Four", family: "number"),
        UrduChar(glyph: "۵", phonetic: "Five", family: "number"),
        UrduChar(glyph: "۶", phonetic: "Six", family: "number"),
        UrduChar(glyph: "۷", phonetic: "Seven", family: "number"),
        UrduChar(glyph: "۸", phonetic: "Eight", family: "number"),
        UrduChar(glyph: "۹", phonetic: "Nine", family: "number"),
      ];
}
