// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Hindi (`hi`).
class AppLocalizationsHi extends AppLocalizations {
  AppLocalizationsHi([String locale = 'hi']) : super(locale);

  @override
  String get appTitle => 'There Yet';

  @override
  String get alarmsTitle => 'अलार्म';

  @override
  String get noAlarmsYet => 'अभी कोई अलार्म नहीं';

  @override
  String get tapToCreateFirst => 'पहला अलार्म बनाने के लिए + दबाएँ';

  @override
  String get failedToLoadAlarms => 'अलार्म लोड नहीं हो सके';

  @override
  String get retry => 'फिर कोशिश करें';

  @override
  String get sortBy => 'क्रम';

  @override
  String get sortAlarms => 'अलार्म क्रमित करें';

  @override
  String get sortDateCreated => 'बनाने की तारीख़';

  @override
  String get sortName => 'नाम';

  @override
  String get settings => 'सेटिंग्स';

  @override
  String get about => 'जानकारी';

  @override
  String nSelected(int count) {
    return '$count चयनित';
  }

  @override
  String get deleteSelected => 'चयनित हटाएँ';

  @override
  String deleteNAlarms(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count अलार्म',
      one: '1 अलार्म',
    );
    return '$_temp0 हटाएँ?';
  }

  @override
  String deleteNAlarmsBody(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count अलार्म',
      one: '1 अलार्म',
    );
    return '$_temp0 स्थायी रूप से हटा दिए जाएँगे।';
  }

  @override
  String get cancel => 'रद्द करें';

  @override
  String get delete => 'हटाएँ';

  @override
  String get ok => 'ठीक है';

  @override
  String alarmDeactivated(String name) {
    return '$name निष्क्रिय';
  }

  @override
  String alarmActivated(String name, String distance) {
    return '$name सक्रिय — $distance दूर';
  }

  @override
  String get locationPermissionRequired => 'स्थान की अनुमति ज़रूरी है';

  @override
  String get notificationsDisabled =>
      'सूचनाएँ बंद हैं — अलार्म सुनाई नहीं देगा';

  @override
  String get alreadyInsideAlarmArea => 'आप पहले से अलार्म क्षेत्र में हैं';

  @override
  String alreadyInsideAlarmAreaBody(
    String distance,
    String name,
    String radius,
  ) {
    return 'आप \"$name\" से $distance दूर हैं। सक्रिय करने के लिए $radius दायरे से बाहर जाएँ।';
  }

  @override
  String get gpsDisabled => 'GPS बंद है';

  @override
  String get openSettings => 'सेटिंग्स खोलें';

  @override
  String get couldNotAcquireLocation => 'स्थान प्राप्त नहीं हो सका';

  @override
  String nAlarmsDeleted(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count अलार्म',
      one: '1 अलार्म',
    );
    return '$_temp0 हटाए गए';
  }

  @override
  String deleteFailed(String message) {
    return 'हटाना विफल: $message';
  }

  @override
  String get alarmsNotMonitored => 'अलार्म की निगरानी नहीं हो रही';

  @override
  String get tapToCheckPermissions => 'अनुमतियाँ जाँचने के लिए दबाएँ';

  @override
  String get backgroundLocationRequired => 'बैकग्राउंड स्थान अनुमति ज़रूरी है';

  @override
  String get gettingLocation => 'स्थान ढूँढ रहे हैं…';

  @override
  String alarmDefaultName(int id) {
    return 'अलार्म #$id';
  }

  @override
  String get active => 'सक्रिय';

  @override
  String get inactive => 'निष्क्रिय';

  @override
  String get backgroundLocationNeeded => 'बैकग्राउंड स्थान ज़रूरी है';

  @override
  String get backgroundLocationBody =>
      'There Yet को आपके पहुँचने पर अलार्म बजाने के लिए बैकग्राउंड में आपकी स्थिति की निगरानी करनी होगी।\n\nअगली स्क्रीन पर \"हमेशा अनुमति दें\" चुनें।';

  @override
  String get continueButton => 'जारी रखें';

  @override
  String get disableBatteryOptimization => 'बैटरी ऑप्टिमाइज़ेशन बंद करें';

  @override
  String get batteryOptimizationBody =>
      'बैकग्राउंड में स्थान की विश्वसनीय निगरानी के लिए There Yet को बैटरी ऑप्टिमाइज़ेशन से बाहर रखना होगा।\n\nइसके बिना Android बैटरी बचाने के लिए अलार्म सेवा बंद कर सकता है।';

  @override
  String get skip => 'छोड़ें';

  @override
  String get disableOptimization => 'ऑप्टिमाइज़ेशन बंद करें';

  @override
  String get insideAlarmArea => 'अलार्म क्षेत्र में';

  @override
  String get insideAlarmAreaBody =>
      'आप अभी अलार्म क्षेत्र में हैं। अलार्म निष्क्रिय सहेजा जाएगा और क्षेत्र छोड़ने पर सक्रिय हो जाएगा।';

  @override
  String get saveInactive => 'निष्क्रिय सहेजें';

  @override
  String get discardChanges => 'बदलाव छोड़ें?';

  @override
  String get unsavedChangesBody => 'सहेजे न गए बदलाव खो जाएँगे।';

  @override
  String get keepEditing => 'संपादन जारी रखें';

  @override
  String get discard => 'छोड़ें';

  @override
  String get locationUnavailable => 'स्थान उपलब्ध नहीं';

  @override
  String get failedToLoadAlarm => 'अलार्म लोड नहीं हो सका';

  @override
  String get osmAttribution => '© OpenStreetMap';

  @override
  String get searchLocation => 'स्थान खोजें';

  @override
  String get searchLocationOffline => 'खोज उपलब्ध नहीं (ऑफ़लाइन)';

  @override
  String get noResultsFound => 'कोई परिणाम नहीं मिला';

  @override
  String get label => 'लेबल';

  @override
  String get save => 'सहेजें';

  @override
  String get centerOnMyLocation => 'मेरे स्थान पर केंद्रित करें';

  @override
  String get resetNorth => 'उत्तर दिशा सेट करें';

  @override
  String get createAlarm => 'अलार्म बनाएँ';

  @override
  String get dismiss => 'बंद करें';

  @override
  String get locationAlarmDefault => 'There Yet';

  @override
  String alarmBodyWithinRadius(int radius) {
    return 'आप अपने गंतव्य से $radius मी. के दायरे में हैं';
  }

  @override
  String get appearance => 'रंगरूप';

  @override
  String get theme => 'थीम';

  @override
  String get themeSystem => 'सिस्टम';

  @override
  String get themeLight => 'लाइट';

  @override
  String get themeDark => 'डार्क';

  @override
  String get materialYou => 'Material You';

  @override
  String get materialYouSubtitle => 'वॉलपेपर के रंग इस्तेमाल करें';

  @override
  String get trueBlack => 'गहरा काला';

  @override
  String get trueBlackSubtitle => 'AMOLED स्क्रीन के लिए शुद्ध काला बैकग्राउंड';

  @override
  String get aboutTitle => 'जानकारी';

  @override
  String get appTagline => 'पहुँचने पर सूचना पाएँ';

  @override
  String get version => 'संस्करण';

  @override
  String get license => 'लाइसेंस';

  @override
  String get licenseValue => 'EUPL 1.2';

  @override
  String get mapData => 'मानचित्र डेटा';

  @override
  String get mapDataValue => 'OpenStreetMap योगदानकर्ता · OSM France';

  @override
  String get geocoding => 'जियोकोडिंग';

  @override
  String get geocodingValue => 'Photon by Komoot';

  @override
  String get openSourceLicenses => 'ओपन सोर्स लाइसेंस';

  @override
  String alarmSaved(String name) {
    return '$name सहेजा गया';
  }

  @override
  String alarmSavedNoGps(String name) {
    return '$name सहेजा गया (निष्क्रिय — GPS सिग्नल नहीं)';
  }

  @override
  String alarmSavedInside(String name) {
    return '$name सहेजा गया (निष्क्रिय)';
  }

  @override
  String alarmSavedNoPermission(String name) {
    return '$name सहेजा गया — निगरानी के लिए बैकग्राउंड स्थान चालू करें';
  }

  @override
  String get support => 'सहायता';

  @override
  String get donate => 'दान करें';

  @override
  String get donateSubtitle => 'Liberapay के माध्यम से विकास का समर्थन करें';
}
