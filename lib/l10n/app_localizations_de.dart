// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for German (`de`).
class AppLocalizationsDe extends AppLocalizations {
  AppLocalizationsDe([String locale = 'de']) : super(locale);

  @override
  String get appTitle => 'There Yet';

  @override
  String get alarmsTitle => 'Wecker';

  @override
  String get noAlarmsYet => 'Noch keine Wecker';

  @override
  String get tapToCreateFirst =>
      'Tippe auf +, um deinen ersten Wecker zu erstellen';

  @override
  String get failedToLoadAlarms => 'Wecker konnten nicht geladen werden';

  @override
  String get retry => 'Erneut versuchen';

  @override
  String get sortBy => 'Sortieren nach';

  @override
  String get sortAlarms => 'Wecker sortieren';

  @override
  String get sortDateCreated => 'Erstellungsdatum';

  @override
  String get sortName => 'Name';

  @override
  String get settings => 'Einstellungen';

  @override
  String get about => 'Über';

  @override
  String nSelected(int count) {
    return '$count ausgewählt';
  }

  @override
  String get deleteSelected => 'Auswahl löschen';

  @override
  String deleteNAlarms(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count Wecker',
      one: '1 Wecker',
    );
    return '$_temp0 löschen?';
  }

  @override
  String deleteNAlarmsBody(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count Wecker werden',
      one: '1 Wecker wird',
    );
    return '$_temp0 dauerhaft entfernt.';
  }

  @override
  String get cancel => 'Abbrechen';

  @override
  String get delete => 'Löschen';

  @override
  String get ok => 'OK';

  @override
  String alarmDeactivated(String name) {
    return '$name deaktiviert';
  }

  @override
  String alarmActivated(String name, String distance) {
    return '$name aktiviert, $distance entfernt';
  }

  @override
  String get locationPermissionRequired => 'Standortberechtigung erforderlich';

  @override
  String get notificationsDisabled =>
      'Benachrichtigungen deaktiviert, du wirst den Wecker nicht hören';

  @override
  String get alreadyInsideAlarmArea => 'Bereits im Weckerbereich';

  @override
  String alreadyInsideAlarmAreaBody(
    String distance,
    String name,
    String radius,
  ) {
    return 'Du bist $distance von \"$name\" entfernt. Verlasse den $radius-Radius, um den Wecker zu aktivieren.';
  }

  @override
  String get gpsDisabled => 'GPS ist deaktiviert';

  @override
  String get openSettings => 'Einstellungen öffnen';

  @override
  String get couldNotAcquireLocation =>
      'Standort konnte nicht ermittelt werden';

  @override
  String nAlarmsDeleted(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count Wecker',
      one: '1 Wecker',
    );
    return '$_temp0 gelöscht';
  }

  @override
  String deleteFailed(String message) {
    return 'Löschen fehlgeschlagen: $message';
  }

  @override
  String get alarmsNotMonitored => 'Wecker werden nicht überwacht';

  @override
  String get tapToCheckPermissions => 'Tippe, um Berechtigungen zu prüfen';

  @override
  String get backgroundLocationRequired =>
      'Standortzugriff im Hintergrund erforderlich';

  @override
  String get gettingLocation => 'Standort wird ermittelt…';

  @override
  String alarmDefaultName(int id) {
    return 'Wecker #$id';
  }

  @override
  String get active => 'aktiv';

  @override
  String get inactive => 'inaktiv';

  @override
  String get backgroundLocationNeeded => 'Hintergrundstandort benötigt';

  @override
  String get backgroundLocationBody =>
      'There Yet muss deinen Standort im Hintergrund überwachen, um Wecker auszulösen, wenn du ankommst.\n\nWähle auf dem nächsten Bildschirm \"Immer erlauben\".';

  @override
  String get continueButton => 'Weiter';

  @override
  String get disableBatteryOptimization => 'Akkuoptimierung deaktivieren';

  @override
  String get batteryOptimizationBody =>
      'Um deinen Standort zuverlässig im Hintergrund zu überwachen, muss There Yet von der Akkuoptimierung ausgenommen werden.\n\nOhne diese Ausnahme kann Android den Weckerdienst beenden, um Akku zu sparen.';

  @override
  String get skip => 'Überspringen';

  @override
  String get disableOptimization => 'Deaktivieren';

  @override
  String get insideAlarmArea => 'Im Weckerbereich';

  @override
  String get insideAlarmAreaBody =>
      'Du befindest dich momentan im Weckerbereich. Der Wecker wird inaktiv gespeichert und aktiviert sich, sobald du den Bereich verlässt.';

  @override
  String get saveInactive => 'Inaktiv speichern';

  @override
  String get discardChanges => 'Änderungen verwerfen?';

  @override
  String get unsavedChangesBody =>
      'Deine nicht gespeicherten Änderungen gehen verloren.';

  @override
  String get keepEditing => 'Weiter bearbeiten';

  @override
  String get discard => 'Verwerfen';

  @override
  String get locationUnavailable => 'Standort nicht verfügbar';

  @override
  String get failedToLoadAlarm => 'Wecker konnte nicht geladen werden';

  @override
  String get osmAttribution => '© OpenStreetMap';

  @override
  String get searchLocation => 'Ort suchen';

  @override
  String get searchLocationOffline => 'Suche nicht verfügbar (offline)';

  @override
  String get noResultsFound => 'Keine Ergebnisse gefunden';

  @override
  String get label => 'Bezeichnung';

  @override
  String get save => 'Speichern';

  @override
  String get centerOnMyLocation => 'Auf meinen Standort zentrieren';

  @override
  String get resetNorth => 'Norden zurücksetzen';

  @override
  String get createAlarm => 'Wecker erstellen';

  @override
  String get dismiss => 'Schließen';

  @override
  String get locationAlarmDefault => 'There Yet';

  @override
  String alarmBodyWithinRadius(int radius) {
    return 'Du bist weniger als $radius m von deinem Ziel entfernt';
  }

  @override
  String get appearance => 'Darstellung';

  @override
  String get theme => 'Design';

  @override
  String get themeSystem => 'System';

  @override
  String get themeLight => 'Hell';

  @override
  String get themeDark => 'Dunkel';

  @override
  String get materialYou => 'Material You';

  @override
  String get materialYouSubtitle => 'Hintergrundfarben verwenden';

  @override
  String get trueBlack => 'Reines Schwarz';

  @override
  String get trueBlackSubtitle =>
      'Tiefschwarzer Hintergrund für AMOLED-Displays';

  @override
  String get aboutTitle => 'Über';

  @override
  String get appTagline => 'Weckt dich, wenn du ankommst';

  @override
  String get version => 'Version';

  @override
  String get license => 'Lizenz';

  @override
  String get licenseValue => 'EUPL 1.2';

  @override
  String get mapData => 'Kartendaten';

  @override
  String get mapDataValue => 'OpenStreetMap-Mitwirkende · OSM France';

  @override
  String get geocoding => 'Geokodierung';

  @override
  String get geocodingValue => 'Photon by Komoot';

  @override
  String get openSourceLicenses => 'Open-Source-Lizenzen';

  @override
  String alarmSaved(String name) {
    return '$name gespeichert';
  }

  @override
  String alarmSavedNoGps(String name) {
    return '$name gespeichert (inaktiv, kein GPS-Signal)';
  }

  @override
  String alarmSavedInside(String name) {
    return '$name gespeichert (inaktiv)';
  }

  @override
  String alarmSavedNoPermission(String name) {
    return '$name gespeichert, aktiviere den Hintergrundstandort zur Überwachung';
  }

  @override
  String get support => 'Unterstützung';

  @override
  String get donate => 'Spenden';

  @override
  String get donateSubtitle => 'Entwicklung von There Yet unterstützen';

  @override
  String get rateApp => 'There Yet bewerten';

  @override
  String get rateAppSubtitle => 'Hinterlasse eine Bewertung im Play Store';

  @override
  String get sendFeedback => 'Feedback senden';

  @override
  String get sendFeedbackSubtitle => 'Sende eine E-Mail an den Entwickler';

  @override
  String get help => 'Hilfe';

  @override
  String get helpSubtitle => 'Projektseite anzeigen';
}
