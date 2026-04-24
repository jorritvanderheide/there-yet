// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Polish (`pl`).
class AppLocalizationsPl extends AppLocalizations {
  AppLocalizationsPl([String locale = 'pl']) : super(locale);

  @override
  String get appTitle => 'There Yet';

  @override
  String get alarmsTitle => 'Alarmy';

  @override
  String get noAlarmsYet => 'Brak alarmów';

  @override
  String get tapToCreateFirst => 'Dotknij +, aby utworzyć pierwszy alarm';

  @override
  String get failedToLoadAlarms => 'Nie udało się załadować alarmów';

  @override
  String get retry => 'Ponów';

  @override
  String get sortBy => 'Sortuj według';

  @override
  String get sortAlarms => 'Sortuj alarmy';

  @override
  String get sortDateCreated => 'Data utworzenia';

  @override
  String get sortName => 'Nazwa';

  @override
  String get settings => 'Ustawienia';

  @override
  String get about => 'O aplikacji';

  @override
  String nSelected(int count) {
    return '$count zaznaczono';
  }

  @override
  String get deleteSelected => 'Usuń zaznaczone';

  @override
  String deleteNAlarms(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count alarmów',
      many: '$count alarmów',
      few: '$count alarmy',
      one: '1 alarm',
    );
    return 'Usunąć $_temp0?';
  }

  @override
  String deleteNAlarmsBody(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count alarmów zostanie',
      many: '$count alarmów zostanie',
      few: '$count alarmy zostaną',
      one: '1 alarm zostanie',
    );
    return '$_temp0 trwale usunięte.';
  }

  @override
  String get cancel => 'Anuluj';

  @override
  String get delete => 'Usuń';

  @override
  String get ok => 'OK';

  @override
  String alarmDeactivated(String name) {
    return '$name wyłączony';
  }

  @override
  String alarmActivated(String name, String distance) {
    return '$name włączony, $distance stąd';
  }

  @override
  String get locationPermissionRequired =>
      'Wymagane uprawnienie do lokalizacji';

  @override
  String get notificationsDisabled =>
      'Powiadomienia wyłączone, nie usłyszysz alarmu';

  @override
  String get alreadyInsideAlarmArea => 'Już w obszarze alarmu';

  @override
  String alreadyInsideAlarmAreaBody(
    String distance,
    String name,
    String radius,
  ) {
    return 'Jesteś $distance od \"$name\". Oddal się poza promień $radius, aby aktywować.';
  }

  @override
  String get gpsDisabled => 'GPS jest wyłączony';

  @override
  String get openSettings => 'Otwórz ustawienia';

  @override
  String get couldNotAcquireLocation => 'Nie udało się ustalić lokalizacji';

  @override
  String nAlarmsDeleted(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count alarmów',
      many: '$count alarmów',
      few: '$count alarmy',
      one: '1 alarm',
    );
    return 'Usunięto $_temp0';
  }

  @override
  String deleteFailed(String message) {
    return 'Usuwanie nie powiodło się: $message';
  }

  @override
  String get alarmsNotMonitored => 'Alarmy nie są monitorowane';

  @override
  String get tapToCheckPermissions => 'Dotknij, aby sprawdzić uprawnienia';

  @override
  String get backgroundLocationRequired => 'Wymagana lokalizacja w tle';

  @override
  String get gettingLocation => 'Ustalanie lokalizacji…';

  @override
  String alarmDefaultName(int id) {
    return 'Alarm #$id';
  }

  @override
  String get active => 'aktywny';

  @override
  String get inactive => 'nieaktywny';

  @override
  String get backgroundLocationNeeded => 'Potrzebna lokalizacja w tle';

  @override
  String get backgroundLocationBody =>
      'There Yet musi monitorować Twoją lokalizację w tle, aby uruchomić alarm po dotarciu na miejsce.\n\nNa następnym ekranie wybierz \"Zezwalaj cały czas\".';

  @override
  String get continueButton => 'Dalej';

  @override
  String get disableBatteryOptimization => 'Wyłącz optymalizację baterii';

  @override
  String get batteryOptimizationBody =>
      'Aby niezawodnie monitorować lokalizację w tle, There Yet musi być wyłączony z optymalizacji baterii.\n\nBez tego Android może zatrzymać usługę alarmową w celu oszczędzania baterii.';

  @override
  String get skip => 'Pomiń';

  @override
  String get disableOptimization => 'Wyłącz optymalizację';

  @override
  String get insideAlarmArea => 'W obszarze alarmu';

  @override
  String get insideAlarmAreaBody =>
      'Aktualnie znajdujesz się w obszarze alarmu. Alarm zostanie zapisany jako nieaktywny i włączy się po opuszczeniu obszaru.';

  @override
  String get saveInactive => 'Zapisz jako nieaktywny';

  @override
  String get discardChanges => 'Odrzucić zmiany?';

  @override
  String get unsavedChangesBody => 'Niezapisane zmiany zostaną utracone.';

  @override
  String get keepEditing => 'Kontynuuj edycję';

  @override
  String get discard => 'Odrzuć';

  @override
  String get locationUnavailable => 'Lokalizacja niedostępna';

  @override
  String get failedToLoadAlarm => 'Nie udało się załadować alarmu';

  @override
  String get osmAttribution => '© OpenStreetMap';

  @override
  String get searchLocation => 'Szukaj lokalizacji';

  @override
  String get searchLocationOffline => 'Wyszukiwanie niedostępne (brak sieci)';

  @override
  String get noResultsFound => 'Brak wyników';

  @override
  String get label => 'Etykieta';

  @override
  String get save => 'Zapisz';

  @override
  String get centerOnMyLocation => 'Wyśrodkuj na mojej lokalizacji';

  @override
  String get resetNorth => 'Ustaw północ';

  @override
  String get createAlarm => 'Utwórz alarm';

  @override
  String get dismiss => 'Odrzuć';

  @override
  String get locationAlarmDefault => 'There Yet';

  @override
  String alarmBodyWithinRadius(int radius) {
    return 'Jesteś w promieniu $radius m od celu';
  }

  @override
  String get appearance => 'Wygląd';

  @override
  String get theme => 'Motyw';

  @override
  String get themeSystem => 'Systemowy';

  @override
  String get themeLight => 'Jasny';

  @override
  String get themeDark => 'Ciemny';

  @override
  String get materialYou => 'Material You';

  @override
  String get materialYouSubtitle => 'Użyj kolorów z tapety';

  @override
  String get trueBlack => 'Głęboka czerń';

  @override
  String get trueBlackSubtitle => 'Czysto czarne tło dla ekranów AMOLED';

  @override
  String get aboutTitle => 'O aplikacji';

  @override
  String get appTagline => 'Obudź się, gdy dotrzesz na miejsce';

  @override
  String get version => 'Wersja';

  @override
  String get license => 'Licencja';

  @override
  String get licenseValue => 'EUPL 1.2';

  @override
  String get mapData => 'Dane mapy';

  @override
  String get mapDataValue => 'Współtwórcy OpenStreetMap · OSM France';

  @override
  String get geocoding => 'Geokodowanie';

  @override
  String get geocodingValue => 'Photon by Komoot';

  @override
  String get openSourceLicenses => 'Licencje open source';

  @override
  String alarmSaved(String name) {
    return '$name zapisano';
  }

  @override
  String alarmSavedNoGps(String name) {
    return '$name zapisano (nieaktywny, brak sygnału GPS)';
  }

  @override
  String alarmSavedInside(String name) {
    return '$name zapisano (nieaktywny)';
  }

  @override
  String alarmSavedNoPermission(String name) {
    return '$name zapisano, włącz lokalizację w tle, aby monitorować';
  }

  @override
  String get support => 'Wsparcie';

  @override
  String get donate => 'Wspomóż';

  @override
  String get donateSubtitle => 'Wesprzyj rozwój There Yet';

  @override
  String get rateApp => 'Oceń There Yet';

  @override
  String get rateAppSubtitle => 'Zostaw opinię w Sklepie Play';

  @override
  String get sendFeedback => 'Wyślij opinię';

  @override
  String get sendFeedbackSubtitle => 'Napisz e-mail do dewelopera';

  @override
  String get help => 'Pomoc';

  @override
  String get helpSubtitle => 'Zobacz stronę projektu';

  @override
  String get privacyTagline => 'Bez śledzenia, bez kont, działa offline';
}
