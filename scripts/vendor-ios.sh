#!/usr/bin/env bash
# Copies the official iOS SDK sources for the CocoaPods build path.
set -euo pipefail
cd "$(dirname "$0")/.."
rm -rf ios/vendor && mkdir -p ios/vendor
cp ../ios/Sources/PulseTracker/*.swift ../ios/Sources/PulseTracker/PrivacyInfo.xcprivacy ios/vendor/
echo "vendored: $(ls ios/vendor | tr '\n' ' ')"
