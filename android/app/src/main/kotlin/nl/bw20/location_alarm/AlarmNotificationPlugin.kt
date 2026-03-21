package nl.bw20.location_alarm

import android.content.Context
import android.media.RingtoneManager
import com.pravera.flutter_foreground_task.FlutterForegroundTaskLifecycleListener
import com.pravera.flutter_foreground_task.FlutterForegroundTaskStarter
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class AlarmNotificationPlugin(private val context: Context) :
    FlutterForegroundTaskLifecycleListener {

    companion object {
        const val CHANNEL = "nl.bw20.location_alarm/alarm_notification"
        const val RINGTONE_CHANNEL = "nl.bw20.location_alarm/ringtone"

        fun registerChannel(context: Context, engine: FlutterEngine) {
            MethodChannel(engine.dartExecutor.binaryMessenger, CHANNEL)
                .setMethodCallHandler { call, result ->
                    when (call.method) {
                        "showAlarm" -> {
                            val alarmId = call.argument<Int>("alarmId") ?: -1
                            val title = call.argument<String>("title") ?: ""
                            val body = call.argument<String>("body") ?: ""
                            AlarmNotificationHelper.show(context, alarmId, title, body)
                            result.success(null)
                        }
                        "dismissAlarm" -> {
                            AlarmNotificationHelper.cancel(context)
                            result.success(null)
                        }
                        else -> result.notImplemented()
                    }
                }

            MethodChannel(engine.dartExecutor.binaryMessenger, RINGTONE_CHANNEL)
                .setMethodCallHandler { call, result ->
                    when (call.method) {
                        "getAlarmUri" -> {
                            val uri = RingtoneManager.getDefaultUri(RingtoneManager.TYPE_ALARM)
                                ?: RingtoneManager.getDefaultUri(RingtoneManager.TYPE_NOTIFICATION)
                            result.success(uri?.toString() ?: "")
                        }
                        else -> result.notImplemented()
                    }
                }
        }
    }

    override fun onEngineCreate(flutterEngine: FlutterEngine?) {
        flutterEngine?.let { registerChannel(context, it) }
    }

    override fun onTaskStart(starter: FlutterForegroundTaskStarter) {}
    override fun onTaskRepeatEvent() {}
    override fun onTaskDestroy() {}
    override fun onEngineWillDestroy() {}
}
