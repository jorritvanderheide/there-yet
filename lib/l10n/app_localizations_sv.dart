// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Swedish (`sv`).
class AppLocalizationsSv extends AppLocalizations {
  AppLocalizationsSv([String locale = 'sv']) : super(locale);

  @override
  String get appTitle => 'There Yet';

  @override
  String get alarmsTitle => 'Larm';

  @override
  String get noAlarmsYet => 'Inga larm ännu';

  @override
  String get tapToCreateFirst => 'Tryck på + för att skapa ditt första larm';

  @override
  String get failedToLoadAlarms => 'Kunde inte läsa in larmen';

  @override
  String get retry => 'Försök igen';

  @override
  String get sortBy => 'Sortera efter';

  @override
  String get sortAlarms => 'Sortera larm';

  @override
  String get sortDateCreated => 'Skapad';

  @override
  String get sortName => 'Namn';

  @override
  String get settings => 'Inställningar';

  @override
  String get about => 'Om';

  @override
  String nSelected(int count) {
    return '$count markerade';
  }

  @override
  String get deleteSelected => 'Ta bort markerade';

  @override
  String deleteNAlarms(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count larm',
      one: '1 larm',
    );
    return 'Ta bort $_temp0?';
  }

  @override
  String deleteNAlarmsBody(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count larm',
      one: '1 larm',
    );
    return '$_temp0 tas bort permanent.';
  }

  @override
  String get cancel => 'Avbryt';

  @override
  String get delete => 'Ta bort';

  @override
  String get ok => 'OK';

  @override
  String alarmDeactivated(String name) {
    return '$name inaktiverat';
  }

  @override
  String alarmActivated(String name, String distance) {
    return '$name aktiverat, $distance bort';
  }

  @override
  String get locationPermissionRequired => 'Platsbehörighet krävs';

  @override
  String get notificationsDisabled =>
      'Aviseringar avstängda, du kommer inte höra larmet';

  @override
  String get alreadyInsideAlarmArea => 'Redan inom larmområdet';

  @override
  String alreadyInsideAlarmAreaBody(
    String distance,
    String name,
    String radius,
  ) {
    return 'Du är $distance från \"$name\". Förflytta dig utanför $radius-radien för att aktivera.';
  }

  @override
  String get gpsDisabled => 'GPS är avstängt';

  @override
  String get openSettings => 'Öppna inställningar';

  @override
  String get couldNotAcquireLocation => 'Kunde inte fastställa platsen';

  @override
  String nAlarmsDeleted(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count larm',
      one: '1 larm',
    );
    return '$_temp0 borttaget';
  }

  @override
  String deleteFailed(String message) {
    return 'Borttagning misslyckades: $message';
  }

  @override
  String get alarmsNotMonitored => 'Larmen övervakas inte';

  @override
  String get tapToCheckPermissions => 'Tryck för att kontrollera behörigheter';

  @override
  String get backgroundLocationRequired => 'Platsåtkomst i bakgrunden krävs';

  @override
  String get gettingLocation => 'Hämtar plats…';

  @override
  String alarmDefaultName(int id) {
    return 'Larm #$id';
  }

  @override
  String get active => 'aktivt';

  @override
  String get inactive => 'inaktivt';

  @override
  String get backgroundLocationNeeded => 'Platsåtkomst i bakgrunden behövs';

  @override
  String get backgroundLocationBody =>
      'There Yet behöver komma åt din plats i bakgrunden för att utlösa larm när du anländer.\n\nVälj \"Tillåt alltid\" på nästa skärm.';

  @override
  String get continueButton => 'Fortsätt';

  @override
  String get disableBatteryOptimization => 'Stäng av batterioptimering';

  @override
  String get batteryOptimizationBody =>
      'För att övervaka din plats tillförlitligt i bakgrunden behöver There Yet undantas från batterioptimering.\n\nUtan detta kan Android stoppa larmtjänsten för att spara batteri.';

  @override
  String get skip => 'Hoppa över';

  @override
  String get disableOptimization => 'Stäng av optimering';

  @override
  String get insideAlarmArea => 'Inom larmområdet';

  @override
  String get insideAlarmAreaBody =>
      'Du befinner dig inom larmområdet. Larmet sparas som inaktivt och aktiveras när du lämnar området.';

  @override
  String get saveInactive => 'Spara som inaktivt';

  @override
  String get discardChanges => 'Kasta ändringar?';

  @override
  String get unsavedChangesBody =>
      'Dina osparade ändringar kommer att gå förlorade.';

  @override
  String get keepEditing => 'Fortsätt redigera';

  @override
  String get discard => 'Kasta';

  @override
  String get locationUnavailable => 'Plats inte tillgänglig';

  @override
  String get failedToLoadAlarm => 'Kunde inte läsa in larmet';

  @override
  String get osmAttribution => '© OpenStreetMap';

  @override
  String get searchLocation => 'Sök plats';

  @override
  String get searchLocationOffline => 'Sökning otillgänglig (offline)';

  @override
  String get noResultsFound => 'Inga resultat hittades';

  @override
  String get label => 'Etikett';

  @override
  String get save => 'Spara';

  @override
  String get centerOnMyLocation => 'Centrera på min plats';

  @override
  String get resetNorth => 'Återställ norr';

  @override
  String get createAlarm => 'Skapa larm';

  @override
  String get dismiss => 'Avfärda';

  @override
  String get locationAlarmDefault => 'There Yet';

  @override
  String alarmBodyWithinRadius(int radius) {
    return 'Du är inom $radius m från din destination';
  }

  @override
  String get appearance => 'Utseende';

  @override
  String get theme => 'Tema';

  @override
  String get themeSystem => 'System';

  @override
  String get themeLight => 'Ljust';

  @override
  String get themeDark => 'Mörkt';

  @override
  String get materialYou => 'Material You';

  @override
  String get materialYouSubtitle => 'Använd dina bakgrundsfärger';

  @override
  String get trueBlack => 'Helsvart';

  @override
  String get trueBlackSubtitle => 'Helt svart bakgrund för AMOLED-skärmar';

  @override
  String get aboutTitle => 'Om';

  @override
  String get appTagline => 'Få en påminnelse när du anländer';

  @override
  String get version => 'Version';

  @override
  String get license => 'Licens';

  @override
  String get licenseValue => 'EUPL 1.2';

  @override
  String get mapData => 'Kartdata';

  @override
  String get mapDataValue => 'OpenStreetMap-bidragsgivare · OSM France';

  @override
  String get geocoding => 'Geokodning';

  @override
  String get geocodingValue => 'Photon by Komoot';

  @override
  String get openSourceLicenses => 'Öppen källkod-licenser';

  @override
  String alarmSaved(String name) {
    return '$name sparat';
  }

  @override
  String alarmSavedNoGps(String name) {
    return '$name sparat (inaktivt, ingen GPS-signal)';
  }

  @override
  String alarmSavedInside(String name) {
    return '$name sparat (inaktivt)';
  }

  @override
  String alarmSavedNoPermission(String name) {
    return '$name sparat, aktivera platsåtkomst i bakgrunden';
  }

  @override
  String get support => 'Stöd';

  @override
  String get donate => 'Donera';

  @override
  String get donateSubtitle => 'Stöd utvecklingen av There Yet';

  @override
  String get rateApp => 'Betygsätt There Yet';

  @override
  String get rateAppSubtitle => 'Lämna ett omdöme på Play Store';

  @override
  String get sendFeedback => 'Skicka feedback';

  @override
  String get sendFeedbackSubtitle => 'Mejla utvecklaren';

  @override
  String get help => 'Hjälp';

  @override
  String get helpSubtitle => 'Visa projektsidan';
}
