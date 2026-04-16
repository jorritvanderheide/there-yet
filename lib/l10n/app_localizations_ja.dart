// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Japanese (`ja`).
class AppLocalizationsJa extends AppLocalizations {
  AppLocalizationsJa([String locale = 'ja']) : super(locale);

  @override
  String get appTitle => 'There Yet';

  @override
  String get alarmsTitle => 'アラーム';

  @override
  String get noAlarmsYet => 'アラームはまだありません';

  @override
  String get tapToCreateFirst => '＋をタップして最初のアラームを作成';

  @override
  String get failedToLoadAlarms => 'アラームの読み込みに失敗しました';

  @override
  String get retry => '再試行';

  @override
  String get sortBy => '並べ替え';

  @override
  String get sortAlarms => 'アラームを並べ替え';

  @override
  String get sortDateCreated => '作成日';

  @override
  String get sortName => '名前';

  @override
  String get settings => '設定';

  @override
  String get about => 'このアプリについて';

  @override
  String nSelected(int count) {
    return '$count件選択中';
  }

  @override
  String get deleteSelected => '選択したアラームを削除';

  @override
  String deleteNAlarms(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count件のアラームを削除しますか？',
    );
    return '$_temp0';
  }

  @override
  String deleteNAlarmsBody(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count件のアラームが完全に削除されます。',
    );
    return '$_temp0';
  }

  @override
  String get cancel => 'キャンセル';

  @override
  String get delete => '削除';

  @override
  String get ok => 'OK';

  @override
  String alarmDeactivated(String name) {
    return '$nameを無効にしました';
  }

  @override
  String alarmActivated(String name, String distance) {
    return '$nameを有効にしました, 目的地まで$distance';
  }

  @override
  String get locationPermissionRequired => '位置情報の許可が必要です';

  @override
  String get notificationsDisabled => '通知が無効です, アラーム音が鳴りません';

  @override
  String get alreadyInsideAlarmArea => 'すでにアラーム範囲内にいます';

  @override
  String alreadyInsideAlarmAreaBody(
    String distance,
    String name,
    String radius,
  ) {
    return '「$name」から$distanceの位置にいます。アラームを有効にするには、$radiusの範囲外に移動してください。';
  }

  @override
  String get gpsDisabled => 'GPSが無効です';

  @override
  String get openSettings => '設定を開く';

  @override
  String get couldNotAcquireLocation => '位置情報を取得できませんでした';

  @override
  String nAlarmsDeleted(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count件のアラームを削除しました',
    );
    return '$_temp0';
  }

  @override
  String deleteFailed(String message) {
    return '削除に失敗しました: $message';
  }

  @override
  String get alarmsNotMonitored => 'アラームは監視されていません';

  @override
  String get tapToCheckPermissions => 'タップして権限を確認';

  @override
  String get backgroundLocationRequired => 'バックグラウンド位置情報の許可が必要です';

  @override
  String get gettingLocation => '位置情報を取得中…';

  @override
  String alarmDefaultName(int id) {
    return 'アラーム #$id';
  }

  @override
  String get active => '有効';

  @override
  String get inactive => '無効';

  @override
  String get backgroundLocationNeeded => 'バックグラウンド位置情報が必要です';

  @override
  String get backgroundLocationBody =>
      '到着時にアラームを鳴らすために、There Yetはバックグラウンドで位置情報を監視する必要があります。\n\n次の画面で「常に許可」を選択してください。';

  @override
  String get continueButton => '続行';

  @override
  String get disableBatteryOptimization => 'バッテリー最適化を無効にする';

  @override
  String get batteryOptimizationBody =>
      'バックグラウンドで位置情報を確実に監視するために、There Yetをバッテリー最適化の対象から除外する必要があります。\n\nこの設定がないと、Androidがバッテリー節約のためにアラームサービスを停止する場合があります。';

  @override
  String get skip => 'スキップ';

  @override
  String get disableOptimization => '無効にする';

  @override
  String get insideAlarmArea => 'アラーム範囲内にいます';

  @override
  String get insideAlarmAreaBody =>
      '現在アラーム範囲内にいます。アラームは無効の状態で保存され、範囲外に出ると有効になります。';

  @override
  String get saveInactive => '無効のまま保存';

  @override
  String get discardChanges => '変更を破棄しますか？';

  @override
  String get unsavedChangesBody => '保存されていない変更は失われます。';

  @override
  String get keepEditing => '編集を続ける';

  @override
  String get discard => '破棄';

  @override
  String get locationUnavailable => '位置情報を利用できません';

  @override
  String get failedToLoadAlarm => 'アラームの読み込みに失敗しました';

  @override
  String get osmAttribution => '© OpenStreetMap';

  @override
  String get searchLocation => '場所を検索';

  @override
  String get searchLocationOffline => '検索を利用できません（オフライン）';

  @override
  String get noResultsFound => '見つかりませんでした';

  @override
  String get label => 'ラベル';

  @override
  String get save => '保存';

  @override
  String get centerOnMyLocation => '現在地を中心に表示';

  @override
  String get resetNorth => '北を上に戻す';

  @override
  String get createAlarm => 'アラームを作成';

  @override
  String get dismiss => '閉じる';

  @override
  String get locationAlarmDefault => 'There Yet';

  @override
  String alarmBodyWithinRadius(int radius) {
    return '目的地まで$radius m以内です';
  }

  @override
  String get appearance => '外観';

  @override
  String get theme => 'テーマ';

  @override
  String get themeSystem => 'システム';

  @override
  String get themeLight => 'ライト';

  @override
  String get themeDark => 'ダーク';

  @override
  String get materialYou => 'Material You';

  @override
  String get materialYouSubtitle => '壁紙の色を使用';

  @override
  String get trueBlack => 'トゥルーブラック';

  @override
  String get trueBlackSubtitle => 'AMOLED向けの純粋な黒背景';

  @override
  String get aboutTitle => 'このアプリについて';

  @override
  String get appTagline => '到着したらお知らせ';

  @override
  String get version => 'バージョン';

  @override
  String get license => 'ライセンス';

  @override
  String get licenseValue => 'EUPL 1.2';

  @override
  String get mapData => '地図データ';

  @override
  String get mapDataValue => 'OpenStreetMap contributors · OSM France';

  @override
  String get geocoding => 'ジオコーディング';

  @override
  String get geocodingValue => 'Photon by Komoot';

  @override
  String get openSourceLicenses => 'オープンソースライセンス';

  @override
  String alarmSaved(String name) {
    return '$nameを保存しました';
  }

  @override
  String alarmSavedNoGps(String name) {
    return '$nameを保存しました（無効, GPS信号なし）';
  }

  @override
  String alarmSavedInside(String name) {
    return '$nameを保存しました（無効）';
  }

  @override
  String alarmSavedNoPermission(String name) {
    return '$nameを保存しました, 監視するにはバックグラウンド位置情報を有効にしてください';
  }

  @override
  String get support => 'サポート';

  @override
  String get donate => '寄付する';

  @override
  String get donateSubtitle => 'There Yetの開発を支援';
}
