package io.pulsetracker.pulsetracker_flutter

import android.content.Context
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.pulsetracker.sdk.PaywallSource
import io.pulsetracker.sdk.PulseEnvironment
import io.pulsetracker.sdk.PulseTracker

/** Flutter bridge over the official Android SDK (JitPack). */
class PulsetrackerFlutterPlugin : FlutterPlugin, MethodChannel.MethodCallHandler {
  private lateinit var channel: MethodChannel
  private lateinit var context: Context

  override fun onAttachedToEngine(binding: FlutterPlugin.FlutterPluginBinding) {
    context = binding.applicationContext
    channel = MethodChannel(binding.binaryMessenger, "pulsetracker")
    channel.setMethodCallHandler(this)
  }

  override fun onMethodCall(call: MethodCall, result: MethodChannel.Result) {
    fun str(k: String): String? = call.argument<String>(k)
    when (call.method) {
      "configure" -> {
        val key = str("appKey")
        if (key.isNullOrEmpty()) return result.error("bad_args", "appKey is required", null)
        val env = PulseEnvironment.values().firstOrNull { it.wire == str("environment") }
        val base = str("apiBase")
        if (base != null) PulseTracker.configure(context, key, str("appUserId"), env, base)
        else PulseTracker.configure(context, key, str("appUserId"), env)
        result.success(null)
      }
      "identify" -> {
        val id = str("appUserId")
        if (id.isNullOrEmpty()) return result.error("bad_args", "appUserId is required", null)
        PulseTracker.identify(id, str("email"), str("phone"))
        result.success(null)
      }
      "paywallEvent" -> {
        val src = PaywallSource.values().firstOrNull { it.wire == str("source") } ?: PaywallSource.SDK
        if (str("name") == "paywall_close") PulseTracker.paywallClosed(str("placement"), src)
        else PulseTracker.paywallShown(str("placement"), src)
        result.success(null)
      }
      else -> result.notImplemented()
    }
  }

  override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
    channel.setMethodCallHandler(null)
  }
}
