import 'package:flutter/material.dart';
import 'package:pulsetracker_flutter/pulsetracker_flutter.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  PulseTracker.configure(appKey: 'ptk_65d151203d784da0bbc2509889ad9c85', appUserId: 'flutter-harness');
  PulseTracker.paywallShown(placement: 'onboarding');
  runApp(const MaterialApp(home: Scaffold(body: Center(child: Text('PulseTracker Flutter')))));
}
