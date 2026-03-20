package nl.bw20.location_alarm

import android.app.Application
import com.pravera.flutter_foreground_task.service.ForegroundService

class LocationAlarmApplication : Application() {
    override fun onCreate() {
        super.onCreate()
        ForegroundService.addTaskLifecycleListener(AlarmNotificationPlugin(this))
    }
}
