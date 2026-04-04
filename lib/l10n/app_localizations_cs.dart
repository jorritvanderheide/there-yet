// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Czech (`cs`).
class AppLocalizationsCs extends AppLocalizations {
  AppLocalizationsCs([String locale = 'cs']) : super(locale);

  @override
  String get appTitle => 'There Yet';

  @override
  String get alarmsTitle => 'Budíky';

  @override
  String get noAlarmsYet => 'Zatím žádné budíky';

  @override
  String get tapToCreateFirst => 'Klepněte na + a vytvořte první budík';

  @override
  String get failedToLoadAlarms => 'Nepodařilo se načíst budíky';

  @override
  String get retry => 'Zkusit znovu';

  @override
  String get sortBy => 'Řadit podle';

  @override
  String get sortAlarms => 'Řadit budíky';

  @override
  String get sortDateCreated => 'Datum vytvoření';

  @override
  String get sortName => 'Název';

  @override
  String get settings => 'Nastavení';

  @override
  String get about => 'O aplikaci';

  @override
  String nSelected(int count) {
    return '$count vybráno';
  }

  @override
  String get deleteSelected => 'Smazat vybrané';

  @override
  String deleteNAlarms(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count budíků',
      many: '$count budíků',
      few: '$count budíky',
      one: '1 budík',
    );
    return 'Smazat $_temp0?';
  }

  @override
  String deleteNAlarmsBody(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count budíků bude',
      many: '$count budíků bude',
      few: '$count budíky budou',
      one: '1 budík bude',
    );
    return '$_temp0 trvale odstraněno.';
  }

  @override
  String get cancel => 'Zrušit';

  @override
  String get delete => 'Smazat';

  @override
  String get ok => 'OK';

  @override
  String alarmDeactivated(String name) {
    return '$name deaktivován';
  }

  @override
  String alarmActivated(String name, String distance) {
    return '$name aktivován — $distance daleko';
  }

  @override
  String get locationPermissionRequired => 'Vyžadováno oprávnění k poloze';

  @override
  String get notificationsDisabled => 'Oznámení vypnuta — budík neuslyšíte';

  @override
  String get alreadyInsideAlarmArea => 'Už jste v oblasti budíku';

  @override
  String alreadyInsideAlarmAreaBody(
    String distance,
    String name,
    String radius,
  ) {
    return 'Nacházíte se $distance od \"$name\". Opusťte okruh $radius, aby se budík aktivoval.';
  }

  @override
  String get gpsDisabled => 'GPS je vypnutý';

  @override
  String get openSettings => 'Otevřít nastavení';

  @override
  String get couldNotAcquireLocation => 'Nepodařilo se zjistit polohu';

  @override
  String nAlarmsDeleted(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count budíků',
      many: '$count budíků',
      few: '$count budíky',
      one: '1 budík',
    );
    return 'Smazáno $_temp0';
  }

  @override
  String deleteFailed(String message) {
    return 'Smazání selhalo: $message';
  }

  @override
  String get alarmsNotMonitored => 'Budíky nejsou monitorovány';

  @override
  String get tapToCheckPermissions => 'Klepněte pro kontrolu oprávnění';

  @override
  String get backgroundLocationRequired => 'Vyžadována poloha na pozadí';

  @override
  String get gettingLocation => 'Zjišťování polohy…';

  @override
  String alarmDefaultName(int id) {
    return 'Budík #$id';
  }

  @override
  String get active => 'aktivní';

  @override
  String get inactive => 'neaktivní';

  @override
  String get backgroundLocationNeeded => 'Potřeba polohy na pozadí';

  @override
  String get backgroundLocationBody =>
      'There Yet potřebuje sledovat vaši polohu na pozadí, aby mohl spustit budík po příjezdu.\n\nNa další obrazovce vyberte \"Povolit vždy\".';

  @override
  String get continueButton => 'Pokračovat';

  @override
  String get disableBatteryOptimization => 'Vypnout optimalizaci baterie';

  @override
  String get batteryOptimizationBody =>
      'Pro spolehlivé sledování polohy na pozadí musí být There Yet vyloučen z optimalizace baterie.\n\nBez toho může Android zastavit službu budíků kvůli úspoře baterie.';

  @override
  String get skip => 'Přeskočit';

  @override
  String get disableOptimization => 'Vypnout optimalizaci';

  @override
  String get insideAlarmArea => 'V oblasti budíku';

  @override
  String get insideAlarmAreaBody =>
      'Právě se nacházíte v oblasti budíku. Budík bude uložen jako neaktivní a aktivuje se, až oblast opustíte.';

  @override
  String get saveInactive => 'Uložit neaktivní';

  @override
  String get discardChanges => 'Zahodit změny?';

  @override
  String get unsavedChangesBody => 'Neuložené změny budou ztraceny.';

  @override
  String get keepEditing => 'Pokračovat v úpravách';

  @override
  String get discard => 'Zahodit';

  @override
  String get locationUnavailable => 'Poloha nedostupná';

  @override
  String get failedToLoadAlarm => 'Nepodařilo se načíst budík';

  @override
  String get osmAttribution => '© OpenStreetMap';

  @override
  String get searchLocation => 'Hledat místo';

  @override
  String get searchLocationOffline => 'Hledání nedostupné (offline)';

  @override
  String get noResultsFound => 'Žádné výsledky';

  @override
  String get label => 'Štítek';

  @override
  String get save => 'Uložit';

  @override
  String get centerOnMyLocation => 'Vycentrovat na mou polohu';

  @override
  String get resetNorth => 'Nasměrovat na sever';

  @override
  String get createAlarm => 'Vytvořit budík';

  @override
  String get dismiss => 'Zavřít';

  @override
  String get locationAlarmDefault => 'There Yet';

  @override
  String alarmBodyWithinRadius(int radius) {
    return 'Nacházíte se do $radius m od cíle';
  }

  @override
  String get appearance => 'Vzhled';

  @override
  String get theme => 'Motiv';

  @override
  String get themeSystem => 'Systémový';

  @override
  String get themeLight => 'Světlý';

  @override
  String get themeDark => 'Tmavý';

  @override
  String get materialYou => 'Material You';

  @override
  String get materialYouSubtitle => 'Použít barvy z tapety';

  @override
  String get trueBlack => 'Čistě černá';

  @override
  String get trueBlackSubtitle => 'Černé pozadí pro AMOLED displeje';

  @override
  String get aboutTitle => 'O aplikaci';

  @override
  String get appTagline => 'Upozornění při příjezdu na místo';

  @override
  String get version => 'Verze';

  @override
  String get license => 'Licence';

  @override
  String get licenseValue => 'EUPL 1.2';

  @override
  String get mapData => 'Mapová data';

  @override
  String get mapDataValue => 'Přispěvatelé OpenStreetMap · OSM France';

  @override
  String get geocoding => 'Geokódování';

  @override
  String get geocodingValue => 'Photon by Komoot';

  @override
  String get openSourceLicenses => 'Open source licence';

  @override
  String alarmSaved(String name) {
    return '$name uložen';
  }

  @override
  String alarmSavedNoGps(String name) {
    return '$name uložen (neaktivní — chybí GPS signál)';
  }

  @override
  String alarmSavedInside(String name) {
    return '$name uložen (neaktivní)';
  }

  @override
  String alarmSavedNoPermission(String name) {
    return '$name uložen — povolte polohu na pozadí pro sledování';
  }

  @override
  String get support => 'Podpora';

  @override
  String get donate => 'Přispět';

  @override
  String get donateSubtitle => 'Podpořte vývoj There Yet';
}
