# PulseTracker for Flutter

Tells PulseTracker which link brought each install, so RevenueCat trials and
purchases are credited to the right link, ad and social network.

## Install

```yaml
dependencies:
  pulsetracker_flutter:
    git: { url: https://github.com/TKr0n0s/pulsetracker-flutter, ref: 0.4.3 }
```

iOS works with both Swift Package Manager and CocoaPods. Android pulls the SDK
from JitPack automatically.

## Use

```dart
import 'package:pulsetracker_flutter/pulsetracker_flutter.dart';

// at launch, after Purchases.configure(...)
await PulseTracker.configure(appKey: 'ptk_…', appUserId: await Purchases.appUserID);

await PulseTracker.identify(userId);                 // after Purchases.logIn(userId)
await PulseTracker.identify(userId, email: email);   // optional: link to your web funnel
await PulseTracker.paywallShown(placement: 'onboarding');
```

Wraps the official SDKs (github.com/TKr0n0s/pulsetracker-ios and
`com.github.TKr0n0s:pulsetracker-android`). Source of truth:
`sdks/pulsetracker_flutter` in the PulseTracker monorepo.
