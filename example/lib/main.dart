import 'package:flutter/material.dart';
import 'package:pulsetracker_flutter/pulsetracker_flutter.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  // Pass your app key at build time: flutter run --dart-define=PT_APP_KEY=ptk_…
  const key = String.fromEnvironment('PT_APP_KEY', defaultValue: 'ptk_your_app_key');
  PulseTracker.configure(appKey: key, appUserId: 'flutter-example');
  PulseTracker.paywallShown(placement: 'onboarding');
  runApp(const MaterialApp(home: Scaffold(body: Center(child: Text('PulseTracker Flutter')))));
}
