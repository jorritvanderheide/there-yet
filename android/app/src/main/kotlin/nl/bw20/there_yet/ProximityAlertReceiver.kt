package nl.bw20.there_yet

import android.content.BroadcastReceiver
import android.content.Context
import android.content.Intent
import android.location.Location
import android.location.LocationManager
import android.util.Log
import com.pravera.flutter_foreground_task.service.ForegroundService

class ProximityAlertReceiver : BroadcastReceiver() {
    companion object {
        private const val TAG = "ProximityAlert"
        // Slack on top of the alarm radius when checking last-known location.
        // Last-known fixes are often the staler NETWORK provider with ~50-100m
        // accuracy, so we err on the side of firing.
        private const val LAST_KNOWN_SLACK_METERS = 100f
        // Older than this and we don't trust the fix; fire to be safe rather
        // than miss a real arrival.
        private const val LAST_KNOWN_MAX_AGE_MS = 5L * 60_000L
    }

    override fun onReceive(context: Context, intent: Intent) {
        val entering = intent.getBooleanExtra(
            LocationManager.KEY_PROXIMITY_ENTERING, false
        )
        val alarmId = intent.getIntExtra("alarm_id", -1)
        if (alarmId == -1) return

        Log.d(TAG, "Proximity event for alarm $alarmId (entering: $entering)")

        if (!entering) return

        // Try to wake the Dart foreground service for a precision GPS check.
        // If the service is alive, this feeds into the AlarmChecker pipeline.
        try {
            ForegroundService.sendData(
                """{"type":"proximity_wake","id":$alarmId}"""
            )
            return
        } catch (e: Exception) {
            Log.w(TAG, "FGS unavailable, falling back to native: $e")
        }

        // FGS dead. Precision-check via last-known location before firing,
        // because the proximity buffer is up to 200m larger than the alarm's
        // actual radius and we don't want to alert at the wrong distance.
        val lat = intent.getDoubleExtra("alarm_lat", Double.NaN)
        val lng = intent.getDoubleExtra("alarm_lng", Double.NaN)
        val radius = intent.getFloatExtra("alarm_radius", 0f)

        if (!shouldFireNative(context, lat, lng, radius)) {
            Log.d(TAG, "Last-known location outside alarm radius, suppressing native fire")
            return
        }

        AlarmStateStore.addRinging(context, alarmId)
        AlarmNotificationPlugin.playAlarmSound(context)
        AlarmNotificationHelper.show(
            context, alarmId, "There Yet", "You are near your destination"
        )
    }

    private fun shouldFireNative(
        context: Context,
        lat: Double,
        lng: Double,
        radius: Float,
    ): Boolean {
        // Missing extras (e.g. legacy intents from before this field was added).
        // Fire to preserve old behavior.
        if (lat.isNaN() || lng.isNaN() || radius <= 0f) return true

        val best = bestLastKnownLocation(context) ?: return true
        val ageMs = System.currentTimeMillis() - best.time
        if (ageMs > LAST_KNOWN_MAX_AGE_MS) return true

        val results = FloatArray(1)
        Location.distanceBetween(best.latitude, best.longitude, lat, lng, results)
        return results[0] <= radius + LAST_KNOWN_SLACK_METERS
    }

    private fun bestLastKnownLocation(context: Context): Location? {
        val lm = context.getSystemService(Context.LOCATION_SERVICE) as LocationManager
        val providers = listOf(
            LocationManager.GPS_PROVIDER,
            LocationManager.NETWORK_PROVIDER,
            LocationManager.PASSIVE_PROVIDER,
        )
        var best: Location? = null
        for (p in providers) {
            try {
                @Suppress("MissingPermission")
                val loc = lm.getLastKnownLocation(p) ?: continue
                if (best == null || loc.time > best.time) best = loc
            } catch (e: SecurityException) {
                // Permission missing; nothing we can do from here.
            } catch (e: IllegalArgumentException) {
                // Provider unavailable on this device.
            }
        }
        return best
    }
}
