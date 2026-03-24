// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class AppLocalizationsEs extends AppLocalizations {
  AppLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String get appTitle => 'There Yet';

  @override
  String get alarmsTitle => 'Alarmas';

  @override
  String get noAlarmsYet => 'No hay alarmas';

  @override
  String get tapToCreateFirst => 'Toca + para crear tu primera alarma';

  @override
  String get failedToLoadAlarms => 'No se pudieron cargar las alarmas';

  @override
  String get retry => 'Reintentar';

  @override
  String get sortBy => 'Ordenar por';

  @override
  String get sortAlarms => 'Ordenar alarmas';

  @override
  String get sortDateCreated => 'Fecha de creación';

  @override
  String get sortName => 'Nombre';

  @override
  String get settings => 'Ajustes';

  @override
  String get about => 'Acerca de';

  @override
  String nSelected(int count) {
    return '$count seleccionados';
  }

  @override
  String get deleteSelected => 'Eliminar selección';

  @override
  String deleteNAlarms(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count alarmas',
      one: '1 alarma',
    );
    return '¿Eliminar $_temp0?';
  }

  @override
  String deleteNAlarmsBody(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'eliminarán $count alarmas',
      one: 'eliminará 1 alarma',
    );
    return 'Se $_temp0 de forma permanente.';
  }

  @override
  String get cancel => 'Cancelar';

  @override
  String get delete => 'Eliminar';

  @override
  String get ok => 'OK';

  @override
  String alarmDeactivated(String name) {
    return '$name desactivada';
  }

  @override
  String alarmActivated(String name, String distance) {
    return '$name activada — a $distance';
  }

  @override
  String get locationPermissionRequired => 'Se requiere permiso de ubicación';

  @override
  String get notificationsDisabled =>
      'Notificaciones desactivadas — no oirás la alarma';

  @override
  String get alreadyInsideAlarmArea => 'Ya estás dentro de la zona de alarma';

  @override
  String alreadyInsideAlarmAreaBody(
    String distance,
    String name,
    String radius,
  ) {
    return 'Estás a $distance de «$name». Sal del radio de $radius para activar la alarma.';
  }

  @override
  String get gpsDisabled => 'El GPS está desactivado';

  @override
  String get openSettings => 'Abrir ajustes';

  @override
  String get couldNotAcquireLocation => 'No se pudo obtener la ubicación';

  @override
  String nAlarmsDeleted(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count alarmas eliminadas',
      one: '1 alarma eliminada',
    );
    return '$_temp0';
  }

  @override
  String deleteFailed(String message) {
    return 'Error al eliminar: $message';
  }

  @override
  String get alarmsNotMonitored => 'Las alarmas no están siendo supervisadas';

  @override
  String get tapToCheckPermissions => 'Toca para comprobar los permisos';

  @override
  String get backgroundLocationRequired =>
      'Se requiere ubicación en segundo plano';

  @override
  String get gettingLocation => 'Obteniendo ubicación…';

  @override
  String alarmDefaultName(int id) {
    return 'Alarma n.º $id';
  }

  @override
  String get active => 'activa';

  @override
  String get inactive => 'inactiva';

  @override
  String get backgroundLocationNeeded =>
      'Se necesita ubicación en segundo plano';

  @override
  String get backgroundLocationBody =>
      'There Yet necesita acceder a tu ubicación en segundo plano para activar las alarmas cuando llegues.\n\nEn la siguiente pantalla, selecciona «Permitir siempre».';

  @override
  String get continueButton => 'Continuar';

  @override
  String get disableBatteryOptimization =>
      'Desactivar la optimización de batería';

  @override
  String get batteryOptimizationBody =>
      'Para supervisar tu ubicación de forma fiable en segundo plano, There Yet debe estar excluida de la optimización de batería.\n\nSin esto, Android puede detener el servicio de alarma para ahorrar batería.';

  @override
  String get skip => 'Omitir';

  @override
  String get disableOptimization => 'Desactivar optimización';

  @override
  String get insideAlarmArea => 'Dentro de la zona de alarma';

  @override
  String get insideAlarmAreaBody =>
      'Actualmente estás dentro de la zona de alarma. La alarma se guardará inactiva y se activará cuando salgas de la zona.';

  @override
  String get saveInactive => 'Guardar inactiva';

  @override
  String get discardChanges => '¿Descartar cambios?';

  @override
  String get unsavedChangesBody => 'Los cambios no guardados se perderán.';

  @override
  String get keepEditing => 'Seguir editando';

  @override
  String get discard => 'Descartar';

  @override
  String get locationUnavailable => 'Ubicación no disponible';

  @override
  String get failedToLoadAlarm => 'No se pudo cargar la alarma';

  @override
  String get osmAttribution => '© OpenStreetMap';

  @override
  String get searchLocation => 'Buscar ubicación';

  @override
  String get searchLocationOffline => 'Búsqueda no disponible (sin conexión)';

  @override
  String get noResultsFound => 'No se encontraron resultados';

  @override
  String get label => 'Etiqueta';

  @override
  String get save => 'Guardar';

  @override
  String get centerOnMyLocation => 'Centrar en mi ubicación';

  @override
  String get resetNorth => 'Orientar al norte';

  @override
  String get createAlarm => 'Crear alarma';

  @override
  String get dismiss => 'Descartar';

  @override
  String get locationAlarmDefault => 'There Yet';

  @override
  String alarmBodyWithinRadius(int radius) {
    return 'Estás a menos de $radius m de tu destino';
  }

  @override
  String get appearance => 'Apariencia';

  @override
  String get theme => 'Tema';

  @override
  String get themeSystem => 'Sistema';

  @override
  String get themeLight => 'Claro';

  @override
  String get themeDark => 'Oscuro';

  @override
  String get materialYou => 'Material You';

  @override
  String get materialYouSubtitle => 'Usar los colores de tu fondo de pantalla';

  @override
  String get trueBlack => 'Negro puro';

  @override
  String get trueBlackSubtitle => 'Fondo negro puro para pantallas AMOLED';

  @override
  String get aboutTitle => 'Acerca de';

  @override
  String get appTagline => 'Te avisa cuando llegues';

  @override
  String get version => 'Versión';

  @override
  String get license => 'Licencia';

  @override
  String get licenseValue => 'EUPL 1.2';

  @override
  String get mapData => 'Datos del mapa';

  @override
  String get mapDataValue => 'Colaboradores de OpenStreetMap · OSM France';

  @override
  String get geocoding => 'Geocodificación';

  @override
  String get geocodingValue => 'Photon by Komoot';

  @override
  String get openSourceLicenses => 'Licencias de código abierto';

  @override
  String alarmSaved(String name) {
    return '$name guardada';
  }

  @override
  String alarmSavedNoGps(String name) {
    return '$name guardada (inactiva — sin señal GPS)';
  }

  @override
  String alarmSavedInside(String name) {
    return '$name guardada (inactiva)';
  }

  @override
  String alarmSavedNoPermission(String name) {
    return '$name guardada — activa la ubicación en segundo plano';
  }

  @override
  String get support => 'Apoyo';

  @override
  String get donate => 'Donar';

  @override
  String get donateSubtitle => 'Apoya el desarrollo a través de Liberapay';
}
