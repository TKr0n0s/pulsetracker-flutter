import Flutter
import UIKit
#if !PT_VENDORED
import PulseTracker
#endif

/// Flutter bridge over the official iOS SDK.
public class PulsetrackerFlutterPlugin: NSObject, FlutterPlugin {
    public static func register(with registrar: FlutterPluginRegistrar) {
        let channel = FlutterMethodChannel(name: "pulsetracker", binaryMessenger: registrar.messenger())
        registrar.addMethodCallDelegate(PulsetrackerFlutterPlugin(), channel: channel)
    }

    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        let a = call.arguments as? [String: Any] ?? [:]
        let str = { (k: String) in a[k] as? String }
        switch call.method {
        case "configure":
            guard let key = str("appKey"), !key.isEmpty else {
                return result(FlutterError(code: "bad_args", message: "appKey is required", details: nil))
            }
            let env = str("environment").flatMap(PulseEnvironment.init(rawValue:))
            if let base = str("apiBase").flatMap(URL.init(string:)) {
                PulseTracker.configure(appKey: key, appUserID: str("appUserId"), environment: env, apiBase: base)
            } else {
                PulseTracker.configure(appKey: key, appUserID: str("appUserId"), environment: env)
            }
            result(nil)
        case "identify":
            guard let id = str("appUserId"), !id.isEmpty else {
                return result(FlutterError(code: "bad_args", message: "appUserId is required", details: nil))
            }
            PulseTracker.identify(id, email: str("email"), phone: str("phone"))
            result(nil)
        case "paywallEvent":
            let source = str("source").flatMap(PaywallSource.init(rawValue:)) ?? .sdk
            if str("name") == "paywall_close" { PulseTracker.paywallClosed(placement: str("placement"), source: source) }
            else { PulseTracker.paywallShown(placement: str("placement"), source: source) }
            result(nil)
        default:
            result(FlutterMethodNotImplemented)
        }
    }
}
