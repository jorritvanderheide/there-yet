// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Finnish (`fi`).
class AppLocalizationsFi extends AppLocalizations {
  AppLocalizationsFi([String locale = 'fi']) : super(locale);

  @override
  String get appTitle => 'There Yet';

  @override
  String get alarmsTitle => 'Herätykset';

  @override
  String get noAlarmsYet => 'Ei herätyksiä';

  @override
  String get tapToCreateFirst => 'Luo ensimmäinen herätys painamalla +';

  @override
  String get failedToLoadAlarms => 'Herätysten lataaminen epäonnistui';

  @override
  String get retry => 'Yritä uudelleen';

  @override
  String get sortBy => 'Järjestä';

  @override
  String get sortAlarms => 'Järjestä herätykset';

  @override
  String get sortDateCreated => 'Luontipäivä';

  @override
  String get sortName => 'Nimi';

  @override
  String get settings => 'Asetukset';

  @override
  String get about => 'Tietoja';

  @override
  String nSelected(int count) {
    return '$count valittu';
  }

  @override
  String get deleteSelected => 'Poista valitut';

  @override
  String deleteNAlarms(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count herätystä',
      one: '1 herätys',
    );
    return 'Poistetaanko $_temp0?';
  }

  @override
  String deleteNAlarmsBody(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count herätystä',
      one: '1 herätys',
    );
    return '$_temp0 poistetaan pysyvästi.';
  }

  @override
  String get cancel => 'Peruuta';

  @override
  String get delete => 'Poista';

  @override
  String get ok => 'OK';

  @override
  String alarmDeactivated(String name) {
    return '$name poistettu käytöstä';
  }

  @override
  String alarmActivated(String name, String distance) {
    return '$name käytössä, $distance päässä';
  }

  @override
  String get locationPermissionRequired => 'Sijaintilupa vaaditaan';

  @override
  String get notificationsDisabled =>
      'Ilmoitukset pois käytöstä, et kuule herätystä';

  @override
  String get alreadyInsideAlarmArea => 'Olet jo herätysalueella';

  @override
  String alreadyInsideAlarmAreaBody(
    String distance,
    String name,
    String radius,
  ) {
    return 'Olet $distance päässä kohteesta \"$name\". Poistu $radius säteeltä aktivoidaksesi herätyksen.';
  }

  @override
  String get gpsDisabled => 'GPS ei ole käytössä';

  @override
  String get openSettings => 'Avaa asetukset';

  @override
  String get couldNotAcquireLocation => 'Sijaintia ei saatu selville';

  @override
  String nAlarmsDeleted(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count herätystä',
      one: '1 herätys',
    );
    return '$_temp0 poistettu';
  }

  @override
  String deleteFailed(String message) {
    return 'Poistaminen epäonnistui: $message';
  }

  @override
  String get alarmsNotMonitored => 'Herätyksiä ei seurata';

  @override
  String get tapToCheckPermissions => 'Tarkista luvat napauttamalla';

  @override
  String get backgroundLocationRequired => 'Taustasijainti vaaditaan';

  @override
  String get gettingLocation => 'Haetaan sijaintia…';

  @override
  String alarmDefaultName(int id) {
    return 'Herätys #$id';
  }

  @override
  String get active => 'käytössä';

  @override
  String get inactive => 'pois käytöstä';

  @override
  String get backgroundLocationNeeded => 'Taustasijainti tarvitaan';

  @override
  String get backgroundLocationBody =>
      'There Yet tarvitsee taustasijaintia herättääkseen sinut perille saapuessasi.\n\nValitse seuraavalla näytöllä \"Salli aina\".';

  @override
  String get continueButton => 'Jatka';

  @override
  String get disableBatteryOptimization => 'Poista akun optimointi käytöstä';

  @override
  String get batteryOptimizationBody =>
      'Luotettavan taustaseurannan varmistamiseksi There Yet on vapautettava akun optimoinnista.\n\nMuuten Android saattaa pysäyttää herätyspalvelun säästääkseen akkua.';

  @override
  String get skip => 'Ohita';

  @override
  String get disableOptimization => 'Poista optimointi';

  @override
  String get insideAlarmArea => 'Herätysalueella';

  @override
  String get insideAlarmAreaBody =>
      'Olet tällä hetkellä herätysalueella. Herätys tallennetaan pois käytöstä ja aktivoituu, kun poistut alueelta.';

  @override
  String get saveInactive => 'Tallenna pois käytöstä';

  @override
  String get discardChanges => 'Hylätäänkö muutokset?';

  @override
  String get unsavedChangesBody => 'Tallentamattomat muutokset menetetään.';

  @override
  String get keepEditing => 'Jatka muokkaamista';

  @override
  String get discard => 'Hylkää';

  @override
  String get locationUnavailable => 'Sijainti ei saatavilla';

  @override
  String get failedToLoadAlarm => 'Herätyksen lataaminen epäonnistui';

  @override
  String get osmAttribution => '© OpenStreetMap';

  @override
  String get searchLocation => 'Hae sijaintia';

  @override
  String get searchLocationOffline =>
      'Haku ei käytettävissä (ei verkkoyhteyttä)';

  @override
  String get noResultsFound => 'Ei tuloksia';

  @override
  String get label => 'Nimi';

  @override
  String get save => 'Tallenna';

  @override
  String get centerOnMyLocation => 'Keskitä sijaintiini';

  @override
  String get resetNorth => 'Osoita pohjoiseen';

  @override
  String get createAlarm => 'Luo herätys';

  @override
  String get dismiss => 'Hiljennä';

  @override
  String get locationAlarmDefault => 'There Yet';

  @override
  String alarmBodyWithinRadius(int radius) {
    return 'Olet alle $radius m päässä määränpäästäsi';
  }

  @override
  String get appearance => 'Ulkoasu';

  @override
  String get theme => 'Teema';

  @override
  String get themeSystem => 'Järjestelmä';

  @override
  String get themeLight => 'Vaalea';

  @override
  String get themeDark => 'Tumma';

  @override
  String get materialYou => 'Material You';

  @override
  String get materialYouSubtitle => 'Käytä taustakuvan värejä';

  @override
  String get trueBlack => 'Täysmusta';

  @override
  String get trueBlackSubtitle => 'Puhdas musta tausta AMOLED-näytöille';

  @override
  String get aboutTitle => 'Tietoja';

  @override
  String get appTagline => 'Herätys perille saapuessa';

  @override
  String get version => 'Versio';

  @override
  String get license => 'Lisenssi';

  @override
  String get licenseValue => 'EUPL 1.2';

  @override
  String get mapData => 'Karttatiedot';

  @override
  String get mapDataValue => 'OpenStreetMap-tekijät · OSM France';

  @override
  String get geocoding => 'Geokoodaus';

  @override
  String get geocodingValue => 'Photon by Komoot';

  @override
  String get openSourceLicenses => 'Avoimen lähdekoodin lisenssit';

  @override
  String alarmSaved(String name) {
    return '$name tallennettu';
  }

  @override
  String alarmSavedNoGps(String name) {
    return '$name tallennettu (pois käytöstä, ei GPS-signaalia)';
  }

  @override
  String alarmSavedInside(String name) {
    return '$name tallennettu (pois käytöstä)';
  }

  @override
  String alarmSavedNoPermission(String name) {
    return '$name tallennettu, ota taustasijainti käyttöön seurantaa varten';
  }

  @override
  String get support => 'Tuki';

  @override
  String get donate => 'Lahjoita';

  @override
  String get donateSubtitle => 'Tue There Yetin kehitystä';

  @override
  String get rateApp => 'Arvioi There Yet';

  @override
  String get rateAppSubtitle => 'Jätä arvostelu Play Storeen';

  @override
  String get sendFeedback => 'Lähetä palautetta';

  @override
  String get sendFeedbackSubtitle => 'Lähetä kehittäjälle sähköpostia';

  @override
  String get help => 'Ohje';

  @override
  String get helpSubtitle => 'Näytä projektin sivu';
}
