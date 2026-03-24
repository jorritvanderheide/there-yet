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
  String get noAlarmsYet => 'Nenhum alarme ainda';

  @override
  String get tapToCreateFirst => 'Toque em + para criar seu primeiro alarme';

  @override
  String get failedToLoadAlarms => 'Falha ao carregar alarmes';

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
  String get settings => 'Configurações';

  @override
  String get about => 'Sobre';

  @override
  String nSelected(int count) {
    return '$count selecionado(s)';
  }

  @override
  String get deleteSelected => 'Excluir selecionados';

  @override
  String deleteNAlarms(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count alarmes',
      one: '1 alarme',
    );
    return 'Excluir $_temp0?';
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
  String get delete => 'Excluir';

  @override
  String get ok => 'OK';

  @override
  String alarmDeactivated(String name) {
    return '$name desativado';
  }

  @override
  String alarmActivated(String name, String distance) {
    return '$name ativado — a $distance de distância';
  }

  @override
  String get locationPermissionRequired =>
      'Permissão de localização necessária';

  @override
  String get notificationsDisabled =>
      'Notificações desativadas — você não ouvirá o alarme';

  @override
  String get alreadyInsideAlarmArea => 'Você já está na área do alarme';

  @override
  String alreadyInsideAlarmAreaBody(
    String distance,
    String name,
    String radius,
  ) {
    return 'Você está a $distance de \"$name\". Saia do raio de $radius para ativar.';
  }

  @override
  String get gpsDisabled => 'GPS desativado';

  @override
  String get openSettings => 'Abrir configurações';

  @override
  String get couldNotAcquireLocation => 'Não foi possível obter a localização';

  @override
  String nAlarmsDeleted(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count alarmes excluídos',
      one: '1 alarme excluído',
    );
    return '$_temp0';
  }

  @override
  String deleteFailed(String message) {
    return 'Falha ao excluir: $message';
  }

  @override
  String get alarmsNotMonitored => 'Os alarmes não estão sendo monitorados';

  @override
  String get tapToCheckPermissions => 'Toque para verificar as permissões';

  @override
  String get backgroundLocationRequired =>
      'Localização em segundo plano necessária';

  @override
  String get gettingLocation => 'Obtendo localização…';

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
      'O There Yet precisa monitorar sua localização em segundo plano para acionar os alarmes quando você chegar.\n\nNa próxima tela, selecione \"Permitir o tempo todo\".';

  @override
  String get continueButton => 'Continuar';

  @override
  String get disableBatteryOptimization => 'Desativar otimização de bateria';

  @override
  String get batteryOptimizationBody =>
      'Para monitorar sua localização de forma confiável em segundo plano, o There Yet precisa estar excluído da otimização de bateria.\n\nSem isso, o Android pode encerrar o serviço de alarme para economizar bateria.';

  @override
  String get skip => 'Pular';

  @override
  String get disableOptimization => 'Desativar otimização';

  @override
  String get insideAlarmArea => 'Dentro da área do alarme';

  @override
  String get insideAlarmAreaBody =>
      'Você está dentro da área do alarme. O alarme será salvo como inativo e ativará quando você sair.';

  @override
  String get saveInactive => 'Salvar inativo';

  @override
  String get discardChanges => 'Descartar alterações?';

  @override
  String get unsavedChangesBody => 'As alterações não salvas serão perdidas.';

  @override
  String get keepEditing => 'Continuar editando';

  @override
  String get discard => 'Descartar';

  @override
  String get locationUnavailable => 'Localização indisponível';

  @override
  String get failedToLoadAlarm => 'Falha ao carregar alarme';

  @override
  String get osmAttribution => '© OpenStreetMap';

  @override
  String get searchLocation => 'Pesquisar local';

  @override
  String get searchLocationOffline => 'Pesquisa indisponível (offline)';

  @override
  String get noResultsFound => 'Nenhum resultado encontrado';

  @override
  String get label => 'Rótulo';

  @override
  String get save => 'Salvar';

  @override
  String get centerOnMyLocation => 'Centralizar na minha localização';

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
    return 'Você está a menos de $radius m do seu destino';
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
  String get materialYouSubtitle => 'Usar as cores do seu papel de parede';

  @override
  String get trueBlack => 'Preto absoluto';

  @override
  String get trueBlackSubtitle => 'Fundo preto puro para telas AMOLED';

  @override
  String get aboutTitle => 'Sobre';

  @override
  String get appTagline => 'Seja alertado ao chegar';

  @override
  String get version => 'Versão';

  @override
  String get license => 'Licença';

  @override
  String get licenseValue => 'EUPL 1.2';

  @override
  String get mapData => 'Dados do mapa';

  @override
  String get mapDataValue => 'Colaboradores do OpenStreetMap · OSM France';

  @override
  String get geocoding => 'Geocodificação';

  @override
  String get geocodingValue => 'Photon by Komoot';

  @override
  String get openSourceLicenses => 'Licenças de código aberto';

  @override
  String alarmSaved(String name) {
    return '$name salvo';
  }

  @override
  String alarmSavedNoGps(String name) {
    return '$name salvo (inativo — sem sinal GPS)';
  }

  @override
  String alarmSavedInside(String name) {
    return '$name salvo (inativo)';
  }

  @override
  String alarmSavedNoPermission(String name) {
    return '$name salvo — ative a localização em segundo plano para monitorar';
  }

  @override
  String get support => 'Apoio';

  @override
  String get donate => 'Doar';

  @override
  String get donateSubtitle => 'Apoie o desenvolvimento via Liberapay';
}
