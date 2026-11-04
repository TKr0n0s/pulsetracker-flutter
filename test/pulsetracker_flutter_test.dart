import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pulsetracker_flutter/pulsetracker_flutter.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  final calls = <MethodCall>[];
  setUp(() {
    calls.clear();
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger.setMockMethodCallHandler(
      const MethodChannel('pulsetracker'),
      (call) async { calls.add(call); return null; },
    );
  });

  test('maps every call to the native channel with the agreed argument names', () async {
    await PulseTracker.configure(appKey: 'pk_1', appUserId: 'u1');
    await PulseTracker.identify('u1', email: 'a@b.co');
    await PulseTracker.paywallShown(placement: 'onboarding');
    await PulseTracker.paywallClosed(source: PaywallSource.superwall);
    expect(calls.map((c) => c.method), ['configure', 'identify', 'paywallEvent', 'paywallEvent']);
    expect(calls[0].arguments, {'appKey': 'pk_1', 'appUserId': 'u1', 'environment': null, 'apiBase': null});
    expect(calls[1].arguments, {'appUserId': 'u1', 'email': 'a@b.co', 'phone': null});
    expect(calls[2].arguments, {'name': 'paywall_view', 'placement': 'onboarding', 'source': 'sdk'});
    expect(calls[3].arguments, {'name': 'paywall_close', 'placement': null, 'source': 'superwall'});
  });

  test('missing app key / user id fail before reaching native code', () {
    expect(() => PulseTracker.configure(appKey: ''), throwsArgumentError);
    expect(() => PulseTracker.identify(''), throwsArgumentError);
  });
}
