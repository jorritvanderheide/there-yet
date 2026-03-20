package nl.bw20.location_alarm

import android.content.BroadcastReceiver
import android.content.Context
import android.content.Intent
import com.pravera.flutter_foreground_task.service.ForegroundService

class AlarmDismissReceiver : BroadcastReceiver() {
    override fun onReceive(context: Context, intent: Intent) {
        val alarmId = intent.getIntExtra("alarm_id", -1)
        if (alarmId == -1) return

        AlarmNotificationHelper.cancel(context)

        // Send dismiss command to the background Dart isolate.
        // Triggers LocationTaskHandler.onReceiveData() which stops audio
        // and deactivates the alarm in the database.
        ForegroundService.sendData("""{"type":"dismiss","id":$alarmId}""")
    }
}
