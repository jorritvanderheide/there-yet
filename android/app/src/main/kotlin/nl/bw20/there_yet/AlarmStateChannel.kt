package nl.bw20.there_yet

import android.content.Context
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

object AlarmStateChannel {
    private const val CHANNEL = "nl.bw20.there_yet/alarm_state"

    fun registerChannel(context: Context, engine: FlutterEngine) {
        MethodChannel(engine.dartExecutor.binaryMessenger, CHANNEL)
            .setMethodCallHandler { call, result ->
                when (call.method) {
                    "addRinging" -> {
                        val id = call.argument<Int>("id") ?: -1
                        if (id != -1) AlarmStateStore.addRinging(context, id)
                        result.success(null)
                    }
                    "removeRinging" -> {
                        val id = call.argument<Int>("id") ?: -1
                        if (id != -1) AlarmStateStore.removeRinging(context, id)
                        result.success(null)
                    }
                    "getRinging" -> {
                        result.success(AlarmStateStore.getRinging(context))
                    }
                    "consumePendingDismiss" -> {
                        result.success(AlarmStateStore.consumePendingDismiss(context))
                    }
                    else -> result.notImplemented()
                }
            }
    }
}
