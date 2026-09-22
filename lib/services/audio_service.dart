import 'package:flutter_tts/flutter_tts.dart';

/// Speaks Urdu glyphs aloud via on-device text-to-speech.
///
/// Uses the device's Urdu TTS voice when available. Pronunciation quality
/// depends on the platform's installed voices — this is a lightweight
/// alternative to bundling recorded audio for every glyph, not a substitute
/// for one if higher-fidelity native-speaker audio is added later.
class AudioService {
  final FlutterTts _tts = FlutterTts();
  bool _initialized = false;

  Future<void> _ensureInitialized() async {
    if (_initialized) return;
    await _tts.setLanguage('ur-PK');
    await _tts.setSpeechRate(0.4);
    _initialized = true;
  }

  Future<void> pronounce(String glyph) async {
    await _ensureInitialized();
    await _tts.stop();
    await _tts.speak(glyph);
  }

  Future<void> dispose() => _tts.stop();
}
