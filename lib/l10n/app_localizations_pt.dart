// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Portuguese (`pt`).
class AppLocalizationsPt extends AppLocalizations {
  AppLocalizationsPt([String locale = 'pt']) : super(locale);

  @override
  String get appTitle => 'There Yet';

  @override
  String get alarmsTitle => 'Alarmes';

  @override
  String get noAlarmsYet => 'Ainda não há alarmes';

  @override
  String get tapToCreateFirst => 'Toque em + para criar o primeiro alarme';

  @override
  String get failedToLoadAlarms => 'Falha ao carregar os alarmes';

  @override
  String get retry => 'Tentar novamente';

  @override
  String get sortBy => 'Ordenar por';

  @override
  String get sortAlarms => 'Ordenar alarmes';

  @override
  String get sortDateCreated => 'Data de criação';

  @override
  String get sortName => 'Nome';

  @override
  String get settings => 'Definições';

  @override
  String get about => 'Acerca';

  @override
  String nSelected(int count) {
    return '$count selecionado(s)';
  }

  @override
  String get deleteSelected => 'Eliminar selecionados';

  @override
  String deleteNAlarms(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count alarmes',
      one: '1 alarme',
    );
    return 'Eliminar $_temp0?';
  }

  @override
  String deleteNAlarmsBody(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count alarmes serão removidos',
      one: '1 alarme será removido',
    );
    return '$_temp0 permanentemente.';
  }

  @override
  String get cancel => 'Cancelar';

  @override
  String get delete => 'Eliminar';

  @override
  String get ok => 'OK';

  @override
  String alarmDeactivated(String name) {
    return '$name desativado';
  }

  @override
  String alarmActivated(String name, String distance) {
    return '$name ativado, a $distance de distância';
  }

  @override
  String get locationPermissionRequired =>
      'Permissão de localização necessária';

  @override
  String get notificationsDisabled =>
      'Notificações desativadas, não vais ouvir o alarme';

  @override
  String get alreadyInsideAlarmArea => 'Já estás na área do alarme';

  @override
  String alreadyInsideAlarmAreaBody(
    String distance,
    String name,
    String radius,
  ) {
    return 'Estás a $distance de \"$name\". Sai do raio de $radius para ativar.';
  }

  @override
  String get gpsDisabled => 'GPS desativado';

  @override
  String get openSettings => 'Abrir definições';

  @override
  String get couldNotAcquireLocation => 'Não foi possível obter a localização';

  @override
  String nAlarmsDeleted(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count alarmes eliminados',
      one: '1 alarme eliminado',
    );
    return '$_temp0';
  }

  @override
  String deleteFailed(String message) {
    return 'Falha ao eliminar: $message';
  }

  @override
  String get alarmsNotMonitored => 'Os alarmes não estão a ser monitorizados';

  @override
  String get tapToCheckPermissions => 'Toque para verificar as permissões';

  @override
  String get backgroundLocationRequired =>
      'Localização em segundo plano necessária';

  @override
  String get gettingLocation => 'A obter localização…';

  @override
  String alarmDefaultName(int id) {
    return 'Alarme #$id';
  }

  @override
  String get active => 'ativo';

  @override
  String get inactive => 'inativo';

  @override
  String get backgroundLocationNeeded =>
      'Localização em segundo plano necessária';

  @override
  String get backgroundLocationBody =>
      'O There Yet precisa de monitorizar a tua localização em segundo plano para acionar os alarmes quando chegares.\n\nNo próximo ecrã, seleciona \"Permitir sempre\".';

  @override
  String get continueButton => 'Continuar';

  @override
  String get disableBatteryOptimization => 'Desativar otimização da bateria';

  @override
  String get batteryOptimizationBody =>
      'Para monitorizar a tua localização de forma fiável em segundo plano, o There Yet precisa de estar excluído da otimização da bateria.\n\nSem isto, o Android pode encerrar o serviço de alarme para poupar bateria.';

  @override
  String get skip => 'Ignorar';

  @override
  String get disableOptimization => 'Desativar otimização';

  @override
  String get insideAlarmArea => 'Dentro da área do alarme';

  @override
  String get insideAlarmAreaBody =>
      'Estás dentro da área do alarme. O alarme será guardado como inativo e ativará quando saíres.';

  @override
  String get saveInactive => 'Guardar inativo';

  @override
  String get discardChanges => 'Descartar alterações?';

  @override
  String get unsavedChangesBody =>
      'As alterações não guardadas serão perdidas.';

  @override
  String get keepEditing => 'Continuar a editar';

  @override
  String get discard => 'Descartar';

  @override
  String get locationUnavailable => 'Localização indisponível';

  @override
  String get failedToLoadAlarm => 'Falha ao carregar o alarme';

  @override
  String get osmAttribution => '© OpenStreetMap';

  @override
  String get searchLocation => 'Pesquisar local';

  @override
  String get searchLocationOffline => 'Pesquisa indisponível (sem ligação)';

  @override
  String get noResultsFound => 'Nenhum resultado encontrado';

  @override
  String get label => 'Etiqueta';

  @override
  String get save => 'Guardar';

  @override
  String get centerOnMyLocation => 'Centrar na minha localização';

  @override
  String get resetNorth => 'Apontar para o norte';

  @override
  String get createAlarm => 'Criar alarme';

  @override
  String get dismiss => 'Dispensar';

  @override
  String get locationAlarmDefault => 'There Yet';

  @override
  String alarmBodyWithinRadius(int radius) {
    return 'Estás a menos de $radius m do teu destino';
  }

  @override
  String get appearance => 'Aparência';

  @override
  String get theme => 'Tema';

  @override
  String get themeSystem => 'Sistema';

  @override
  String get themeLight => 'Claro';

  @override
  String get themeDark => 'Escuro';

  @override
  String get materialYou => 'Material You';

  @override
  String get materialYouSubtitle => 'Usar as cores da tua imagem de fundo';

  @override
  String get trueBlack => 'Preto absoluto';

  @override
  String get trueBlackSubtitle => 'Fundo preto puro para ecrãs AMOLED';

  @override
  String get aboutTitle => 'Acerca';

  @override
  String get appTagline => 'Recebe um alerta ao chegar';

  @override
  String get version => 'Versão';

  @override
  String get license => 'Licença';

  @override
  String get licenseValue => 'EUPL 1.2';

  @override
  String get mapData => 'Dados do mapa';

  @override
  String get mapDataValue => 'Contribuidores do OpenStreetMap · OSM France';

  @override
  String get geocoding => 'Geocodificação';

  @override
  String get geocodingValue => 'Photon by Komoot';

  @override
  String get openSourceLicenses => 'Licenças de código aberto';

  @override
  String alarmSaved(String name) {
    return '$name guardado';
  }

  @override
  String alarmSavedNoGps(String name) {
    return '$name guardado (inativo, sem sinal GPS)';
  }

  @override
  String alarmSavedInside(String name) {
    return '$name guardado (inativo)';
  }

  @override
  String alarmSavedNoPermission(String name) {
    return '$name guardado, ativa a localização em segundo plano para monitorizar';
  }

  @override
  String get support => 'Apoio';

  @override
  String get donate => 'Doar';

  @override
  String get donateSubtitle => 'Apoia o desenvolvimento do There Yet';

  @override
  String get rateApp => 'Rate There Yet';

  @override
  String get rateAppSubtitle => 'Leave a review on the Play Store';

  @override
  String get sendFeedback => 'Send feedback';

  @override
  String get sendFeedbackSubtitle => 'Email the developer';

  @override
  String get help => 'Help';

  @override
  String get helpSubtitle => 'View the project page';

  @override
  String get privacyTagline => 'No tracking, no accounts, works offline';
}
