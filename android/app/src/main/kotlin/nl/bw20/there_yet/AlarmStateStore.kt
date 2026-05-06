package nl.bw20.there_yet

import android.content.Context

/**
 * Cross-process alarm runtime state, kept in a private SharedPreferences file
 * so both the FGS Dart isolate and native broadcast receivers (which run in
 * the app process when the FGS is dead) can coordinate.
 *
 *  - ringing_alarm_ids: alarms currently sounding. Used to seed the FGS
 *    `_firedIds` set after a process restart so we don't refire.
 *  - pending_dismiss_ids: alarms dismissed via notification while the FGS
 *    was dead. Consumed by the FGS on next start, which writes active=false
 *    to the database.
 */
object AlarmStateStore {
    private const val PREFS = "there_yet_alarm_state"
    private const val KEY_RINGING = "ringing_alarm_ids"
    private const val KEY_PENDING_DISMISS = "pending_dismiss_ids"

    fun addRinging(context: Context, alarmId: Int) =
        addToSet(context, KEY_RINGING, alarmId)

    fun removeRinging(context: Context, alarmId: Int) =
        removeFromSet(context, KEY_RINGING, alarmId)

    fun getRinging(context: Context): List<Int> =
        loadSet(context, KEY_RINGING).mapNotNull { it.toIntOrNull() }

    fun addPendingDismiss(context: Context, alarmId: Int) =
        addToSet(context, KEY_PENDING_DISMISS, alarmId)

    fun consumePendingDismiss(context: Context): List<Int> {
        val ids = loadSet(context, KEY_PENDING_DISMISS).mapNotNull { it.toIntOrNull() }
        if (ids.isNotEmpty()) saveSet(context, KEY_PENDING_DISMISS, emptySet())
        return ids
    }

    private fun addToSet(context: Context, key: String, alarmId: Int) {
        val s = loadSet(context, key).toMutableSet()
        if (s.add(alarmId.toString())) saveSet(context, key, s)
    }

    private fun removeFromSet(context: Context, key: String, alarmId: Int) {
        val s = loadSet(context, key).toMutableSet()
        if (s.remove(alarmId.toString())) saveSet(context, key, s)
    }

    private fun loadSet(context: Context, key: String): Set<String> =
        prefs(context).getStringSet(key, emptySet()) ?: emptySet()

    private fun saveSet(context: Context, key: String, set: Set<String>) {
        prefs(context).edit().putStringSet(key, set).apply()
    }

    private fun prefs(context: Context) =
        context.getSharedPreferences(PREFS, Context.MODE_PRIVATE)
}
