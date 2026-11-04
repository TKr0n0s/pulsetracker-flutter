#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html.
# Run `pod lib lint pulsetracker_flutter.podspec` to validate before publishing.
#
Pod::Spec.new do |s|
  s.name             = 'pulsetracker_flutter'
  s.version          = '0.4.2'
  s.summary          = 'PulseTracker app attribution for Flutter.'
  s.description      = <<-DESC
A new Flutter plugin project.
                       DESC
  s.homepage         = 'https://github.com/TKr0n0s/pulsetracker-flutter'
  s.license          = { :file => '../LICENSE' }
  s.author           = { 'PulseTracker' => 'support@pulsetracker.io' }
  s.source           = { :path => '.' }
  # CocoaPods path: the iOS SDK sources are vendored (scripts/vendor-ios.sh);
  # Swift Package Manager path uses the published pulsetracker-ios package instead.
  s.source_files = 'pulsetracker_flutter/Sources/pulsetracker_flutter/**/*.swift', 'vendor/*.swift'
  s.pod_target_xcconfig = { 'DEFINES_MODULE' => 'YES', 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'i386', 'SWIFT_ACTIVE_COMPILATION_CONDITIONS' => '$(inherited) PT_VENDORED' }
  s.dependency 'Flutter'
  s.platform = :ios, '15.0'

  # Flutter.framework does not contain a i386 slice.
  s.swift_version = '5.9'

  # If your plugin requires a privacy manifest, for example if it uses any
  # required reason APIs, update the PrivacyInfo.xcprivacy file to describe your
  # plugin's privacy impact, and then uncomment this line. For more information,
  # see https://developer.apple.com/documentation/bundleresources/privacy_manifest_files
  s.resource_bundles = {'pulsetracker_privacy' => ['vendor/PrivacyInfo.xcprivacy']}
end
