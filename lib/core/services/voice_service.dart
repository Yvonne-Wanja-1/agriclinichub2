import 'package:flutter_tts/flutter_tts.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

class VoiceService {
  static final _tts = FlutterTts();
  static final _speechToText = stt.SpeechToText();

  // Initialize text-to-speech
  static Future<void> initializeTTS() async {
    await _tts.setLanguage("en-US");
    await _tts.setSpeechRate(0.5);
    await _tts.setPitch(1.0);
  }

  // Initialize speech-to-text
  static Future<void> initializeSpeechToText() async {
    final available = await _speechToText.initialize();
    if (!available) {
      throw Exception('Speech to text not available');
    }
  }

  // Speak text (for disease info, guidance, etc.)
  static Future<void> speak(String text) async {
    try {
      await _tts.speak(text);
    } catch (e) {
      rethrow;
    }
  }

  // Stop speaking
  static Future<void> stop() async {
    try {
      await _tts.stop();
    } catch (e) {
      rethrow;
    }
  }

  // Start listening for voice input
  static Future<String?> startListening() async {
    try {
      if (!_speechToText.isListening) {
        final available = await _speechToText.initialize();
        if (!available) return null;

        await _speechToText.listen();
        return null;
      }
      return null;
    } catch (e) {
      rethrow;
    }
  }

  // Stop listening and get result
  static Future<String> stopListening() async {
    try {
      await _speechToText.stop();
      return _speechToText.lastRecognizedWords;
    } catch (e) {
      rethrow;
    }
  }

  // Get recognized text stream
  static String getRecognizedWords() {
    return _speechToText.lastRecognizedWords;
  }

  // Check if currently listening
  static bool isListening() {
    return _speechToText.isListening;
  }

  // Set language for speech recognition
  static Future<void> setLanguage(String languageCode) async {
    try {
      // Set language for text-to-speech
      await _tts.setLanguage(languageCode);
      // Note: speech_to_text language is set during initialization,
      // cannot be changed dynamically via setLanguage method
    } catch (e) {
      rethrow;
    }
  }
}
