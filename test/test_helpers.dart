import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';

/// Stubs the flutter_tts platform channel so [AudioService] calls succeed
/// in the test environment instead of throwing MissingPluginException.
void mockFlutterTtsChannel() {
  const channel = MethodChannel('flutter_tts');
  TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
      .setMockMethodCallHandler(channel, (MethodCall call) async => 1);
}
