package nl.bw20.there_yet

import android.content.BroadcastReceiver
import android.content.Context
import android.content.Intent
import com.pravera.flutter_foreground_task.service.ForegroundService

class AlarmDismissReceiver : BroadcastReceiver() {
    override fun onReceive(context: Context, intent: Intent) {
        val alarmId = intent.getIntExtra("alarm_id", -1)
        if (alarmId == -1) return

        AlarmNotificationHelper.cancel(context, alarmId)
        // Stop audio directly; covers the case where the FGS is dead
        // and the Dart-side stop call won't reach.
        AlarmNotificationPlugin.stopAlarmSound()
        AlarmStateStore.removeRinging(context, alarmId)

        // Send dismiss command to the background Dart isolate, which
        // deactivates the alarm in the database.
        try {
            ForegroundService.sendData("""{"type":"dismiss","id":$alarmId}""")
        } catch (_: Exception) {
            // FGS is dead. Persist the dismiss intent so the FGS writes
            // active=false on its next start, preventing immediate re-fire
            // when the user is still inside the radius.
            AlarmStateStore.addPendingDismiss(context, alarmId)
        }
    }
}
