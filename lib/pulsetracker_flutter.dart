import 'package:flutter/services.dart';

/// Where an open is recorded. Leave null to detect it.
enum PulseEnvironment { production, sandbox, test }

/// Who reported a paywall event.
enum PaywallSource { sdk, superwall, revenuecat }

/// PulseTracker app attribution.
///
/// ```dart
/// await Purchases.configure(...);
/// await PulseTracker.configure(appKey: 'ptk_…', appUserId: await Purchases.appUserID);
/// ```
class PulseTracker {
  PulseTracker._();

  static const MethodChannel _channel = MethodChannel('pulsetracker');

  /// Call once at launch, after RevenueCat is configured.
  static Future<void> configure({required String appKey, String? appUserId, PulseEnvironment? environment, String? apiBase}) {
    if (appKey.isEmpty) throw ArgumentError('appKey is required');
    return _channel.invokeMethod('configure', {
      'appKey': appKey,
      'appUserId': appUserId,
      'environment': environment?.name,
      'apiBase': apiBase,
    });
  }

  /// After your user logs in (RevenueCat logIn). Optional email/phone link the
  /// customer to your web funnel (hashed by PulseTracker, never stored as typed).
  static Future<void> identify(String appUserId, {String? email, String? phone}) {
    if (appUserId.isEmpty) throw ArgumentError('appUserId is required');
    return _channel.invokeMethod('identify', {'appUserId': appUserId, 'email': email, 'phone': phone});
  }

  /// When a paywall becomes visible.
  static Future<void> paywallShown({String? placement, PaywallSource source = PaywallSource.sdk}) =>
      _channel.invokeMethod('paywallEvent', {'name': 'paywall_view', 'placement': placement, 'source': source.name});

  /// When a paywall is dismissed without a purchase.
  static Future<void> paywallClosed({String? placement, PaywallSource source = PaywallSource.sdk}) =>
      _channel.invokeMethod('paywallEvent', {'name': 'paywall_close', 'placement': placement, 'source': source.name});
}
