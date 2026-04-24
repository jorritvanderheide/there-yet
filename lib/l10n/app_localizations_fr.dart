// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for French (`fr`).
class AppLocalizationsFr extends AppLocalizations {
  AppLocalizationsFr([String locale = 'fr']) : super(locale);

  @override
  String get appTitle => 'There Yet';

  @override
  String get alarmsTitle => 'Alarmes';

  @override
  String get noAlarmsYet => 'Aucune alarme';

  @override
  String get tapToCreateFirst =>
      'Appuyez sur + pour créer votre première alarme';

  @override
  String get failedToLoadAlarms => 'Impossible de charger les alarmes';

  @override
  String get retry => 'Réessayer';

  @override
  String get sortBy => 'Trier par';

  @override
  String get sortAlarms => 'Trier les alarmes';

  @override
  String get sortDateCreated => 'Date de création';

  @override
  String get sortName => 'Nom';

  @override
  String get settings => 'Paramètres';

  @override
  String get about => 'À propos';

  @override
  String nSelected(int count) {
    return '$count sélectionné(s)';
  }

  @override
  String get deleteSelected => 'Supprimer la sélection';

  @override
  String deleteNAlarms(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count alarmes',
      one: '1 alarme',
    );
    return 'Supprimer $_temp0 ?';
  }

  @override
  String deleteNAlarmsBody(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count alarmes seront supprimées',
      one: '1 alarme sera supprimée',
    );
    return '$_temp0 définitivement.';
  }

  @override
  String get cancel => 'Annuler';

  @override
  String get delete => 'Supprimer';

  @override
  String get ok => 'OK';

  @override
  String alarmDeactivated(String name) {
    return '$name désactivée';
  }

  @override
  String alarmActivated(String name, String distance) {
    return '$name activée, à $distance';
  }

  @override
  String get locationPermissionRequired =>
      'Autorisation de localisation requise';

  @override
  String get notificationsDisabled =>
      'Notifications désactivées, vous n\'entendrez pas l\'alarme';

  @override
  String get alreadyInsideAlarmArea => 'Déjà dans la zone d\'alarme';

  @override
  String alreadyInsideAlarmAreaBody(
    String distance,
    String name,
    String radius,
  ) {
    return 'Vous êtes à $distance de « $name ». Sortez du rayon de $radius pour activer l\'alarme.';
  }

  @override
  String get gpsDisabled => 'Le GPS est désactivé';

  @override
  String get openSettings => 'Ouvrir les paramètres';

  @override
  String get couldNotAcquireLocation => 'Impossible d\'obtenir la position';

  @override
  String nAlarmsDeleted(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count alarmes supprimées',
      one: '1 alarme supprimée',
    );
    return '$_temp0';
  }

  @override
  String deleteFailed(String message) {
    return 'Échec de la suppression : $message';
  }

  @override
  String get alarmsNotMonitored => 'Les alarmes ne sont pas surveillées';

  @override
  String get tapToCheckPermissions => 'Appuyez pour vérifier les autorisations';

  @override
  String get backgroundLocationRequired =>
      'Localisation en arrière-plan requise';

  @override
  String get gettingLocation => 'Localisation en cours…';

  @override
  String alarmDefaultName(int id) {
    return 'Alarme nº $id';
  }

  @override
  String get active => 'active';

  @override
  String get inactive => 'inactive';

  @override
  String get backgroundLocationNeeded =>
      'Localisation en arrière-plan nécessaire';

  @override
  String get backgroundLocationBody =>
      'There Yet doit accéder à votre position en arrière-plan pour déclencher les alarmes à votre arrivée.\n\nSur l\'écran suivant, sélectionnez « Autoriser en permanence ».';

  @override
  String get continueButton => 'Continuer';

  @override
  String get disableBatteryOptimization =>
      'Désactiver l\'optimisation de la batterie';

  @override
  String get batteryOptimizationBody =>
      'Pour surveiller votre position de manière fiable en arrière-plan, There Yet doit être exclu de l\'optimisation de la batterie.\n\nSans cela, Android peut arrêter le service d\'alarme pour économiser la batterie.';

  @override
  String get skip => 'Ignorer';

  @override
  String get disableOptimization => 'Désactiver l\'optimisation';

  @override
  String get insideAlarmArea => 'Dans la zone d\'alarme';

  @override
  String get insideAlarmAreaBody =>
      'Vous êtes actuellement dans la zone d\'alarme. L\'alarme sera enregistrée en tant qu\'inactive et s\'activera lorsque vous quitterez la zone.';

  @override
  String get saveInactive => 'Enregistrer inactive';

  @override
  String get discardChanges => 'Abandonner les modifications ?';

  @override
  String get unsavedChangesBody =>
      'Vos modifications non enregistrées seront perdues.';

  @override
  String get keepEditing => 'Continuer la modification';

  @override
  String get discard => 'Abandonner';

  @override
  String get locationUnavailable => 'Position indisponible';

  @override
  String get failedToLoadAlarm => 'Impossible de charger l\'alarme';

  @override
  String get osmAttribution => '© OpenStreetMap';

  @override
  String get searchLocation => 'Rechercher un lieu';

  @override
  String get searchLocationOffline => 'Recherche indisponible (hors ligne)';

  @override
  String get noResultsFound => 'Aucun résultat';

  @override
  String get label => 'Libellé';

  @override
  String get save => 'Enregistrer';

  @override
  String get centerOnMyLocation => 'Centrer sur ma position';

  @override
  String get resetNorth => 'Orienter vers le nord';

  @override
  String get createAlarm => 'Créer une alarme';

  @override
  String get dismiss => 'Arrêter';

  @override
  String get locationAlarmDefault => 'There Yet';

  @override
  String alarmBodyWithinRadius(int radius) {
    return 'Vous êtes à moins de $radius m de votre destination';
  }

  @override
  String get appearance => 'Apparence';

  @override
  String get theme => 'Thème';

  @override
  String get themeSystem => 'Système';

  @override
  String get themeLight => 'Clair';

  @override
  String get themeDark => 'Sombre';

  @override
  String get materialYou => 'Material You';

  @override
  String get materialYouSubtitle =>
      'Utiliser les couleurs de votre fond d\'écran';

  @override
  String get trueBlack => 'Noir profond';

  @override
  String get trueBlackSubtitle => 'Fond noir pur pour écrans AMOLED';

  @override
  String get aboutTitle => 'À propos';

  @override
  String get appTagline => 'Soyez alerté à votre arrivée';

  @override
  String get version => 'Version';

  @override
  String get license => 'Licence';

  @override
  String get licenseValue => 'EUPL 1.2';

  @override
  String get mapData => 'Données cartographiques';

  @override
  String get mapDataValue => 'Contributeurs OpenStreetMap · OSM France';

  @override
  String get geocoding => 'Géocodage';

  @override
  String get geocodingValue => 'Photon by Komoot';

  @override
  String get openSourceLicenses => 'Licences open source';

  @override
  String alarmSaved(String name) {
    return '$name enregistrée';
  }

  @override
  String alarmSavedNoGps(String name) {
    return '$name enregistrée (inactive, pas de signal GPS)';
  }

  @override
  String alarmSavedInside(String name) {
    return '$name enregistrée (inactive)';
  }

  @override
  String alarmSavedNoPermission(String name) {
    return '$name enregistrée, activez la localisation en arrière-plan';
  }

  @override
  String get support => 'Soutien';

  @override
  String get donate => 'Faire un don';

  @override
  String get donateSubtitle => 'Soutenir le développement de There Yet';

  @override
  String get rateApp => 'Évaluer There Yet';

  @override
  String get rateAppSubtitle => 'Laisser un avis sur le Play Store';

  @override
  String get sendFeedback => 'Envoyer des commentaires';

  @override
  String get sendFeedbackSubtitle => 'Envoyer un e-mail au développeur';

  @override
  String get help => 'Aide';

  @override
  String get helpSubtitle => 'Voir la page du projet';

  @override
  String get privacyTagline =>
      'Pas de suivi, pas de compte, fonctionne hors ligne';
}
