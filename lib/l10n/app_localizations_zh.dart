// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Chinese (`zh`).
class AppLocalizationsZh extends AppLocalizations {
  AppLocalizationsZh([String locale = 'zh']) : super(locale);

  @override
  String get appTitle => 'There Yet';

  @override
  String get alarmsTitle => '鬧鐘';

  @override
  String get noAlarmsYet => '尚無鬧鐘';

  @override
  String get tapToCreateFirst => '點按 + 建立第一個鬧鐘';

  @override
  String get failedToLoadAlarms => '無法載入鬧鐘';

  @override
  String get retry => '重試';

  @override
  String get sortBy => '排序方式';

  @override
  String get sortAlarms => '鬧鐘排序';

  @override
  String get sortDateCreated => '建立日期';

  @override
  String get sortName => '名稱';

  @override
  String get settings => '設定';

  @override
  String get about => '關於';

  @override
  String nSelected(int count) {
    return '已選取 $count 個';
  }

  @override
  String get deleteSelected => '刪除所選項目';

  @override
  String deleteNAlarms(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count 個鬧鐘',
    );
    return '確定刪除 $_temp0？';
  }

  @override
  String deleteNAlarmsBody(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count 個鬧鐘',
    );
    return '將永久移除 $_temp0。';
  }

  @override
  String get cancel => '取消';

  @override
  String get delete => '刪除';

  @override
  String get ok => '確定';

  @override
  String alarmDeactivated(String name) {
    return '已停用 $name';
  }

  @override
  String alarmActivated(String name, String distance) {
    return '已啟用 $name, 距離 $distance';
  }

  @override
  String get locationPermissionRequired => '需要位置權限';

  @override
  String get notificationsDisabled => '通知已關閉, 你將聽不到鬧鐘';

  @override
  String get alreadyInsideAlarmArea => '已在鬧鐘區域內';

  @override
  String alreadyInsideAlarmAreaBody(
    String distance,
    String name,
    String radius,
  ) {
    return '你目前距離「$name」$distance。請離開 $radius 半徑範圍後再啟用。';
  }

  @override
  String get gpsDisabled => 'GPS 已關閉';

  @override
  String get openSettings => '開啟設定';

  @override
  String get couldNotAcquireLocation => '無法取得位置';

  @override
  String nAlarmsDeleted(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count 個鬧鐘',
    );
    return '已刪除 $_temp0';
  }

  @override
  String deleteFailed(String message) {
    return '刪除失敗：$message';
  }

  @override
  String get alarmsNotMonitored => '鬧鐘未在監控中';

  @override
  String get tapToCheckPermissions => '點按以檢查權限';

  @override
  String get backgroundLocationRequired => '需要背景位置權限';

  @override
  String get gettingLocation => '正在取得位置…';

  @override
  String alarmDefaultName(int id) {
    return '鬧鐘 #$id';
  }

  @override
  String get active => '已啟用';

  @override
  String get inactive => '未啟用';

  @override
  String get backgroundLocationNeeded => '需要背景位置存取';

  @override
  String get backgroundLocationBody =>
      'There Yet 需要在背景存取你的位置，才能在你抵達時觸發鬧鐘。\n\n請在下一個畫面選擇「一律允許」。';

  @override
  String get continueButton => '繼續';

  @override
  String get disableBatteryOptimization => '關閉電池最佳化';

  @override
  String get batteryOptimizationBody =>
      '為了在背景中穩定監控你的位置，There Yet 需要排除在電池最佳化之外。\n\n否則 Android 可能會為了省電而停止鬧鐘服務。';

  @override
  String get skip => '略過';

  @override
  String get disableOptimization => '關閉最佳化';

  @override
  String get insideAlarmArea => '位於鬧鐘區域內';

  @override
  String get insideAlarmAreaBody => '你目前在鬧鐘區域內。鬧鐘將以未啟用狀態儲存，待你離開後自動啟用。';

  @override
  String get saveInactive => '儲存為未啟用';

  @override
  String get discardChanges => '捨棄變更？';

  @override
  String get unsavedChangesBody => '未儲存的變更將會遺失。';

  @override
  String get keepEditing => '繼續編輯';

  @override
  String get discard => '捨棄';

  @override
  String get locationUnavailable => '無法取得位置';

  @override
  String get failedToLoadAlarm => '無法載入鬧鐘';

  @override
  String get osmAttribution => '© OpenStreetMap';

  @override
  String get searchLocation => '搜尋地點';

  @override
  String get searchLocationOffline => '搜尋無法使用（離線中）';

  @override
  String get noResultsFound => '找不到結果';

  @override
  String get label => '標籤';

  @override
  String get save => '儲存';

  @override
  String get centerOnMyLocation => '移至我的位置';

  @override
  String get resetNorth => '朝北對齊';

  @override
  String get createAlarm => '建立鬧鐘';

  @override
  String get dismiss => '關閉';

  @override
  String get locationAlarmDefault => 'There Yet';

  @override
  String alarmBodyWithinRadius(int radius) {
    return '你已在目的地 $radius 公尺範圍內';
  }

  @override
  String get appearance => '外觀';

  @override
  String get theme => '主題';

  @override
  String get themeSystem => '跟隨系統';

  @override
  String get themeLight => '淺色';

  @override
  String get themeDark => '深色';

  @override
  String get materialYou => 'Material You';

  @override
  String get materialYouSubtitle => '使用桌布配色';

  @override
  String get trueBlack => '純黑';

  @override
  String get trueBlackSubtitle => '適用於 AMOLED 螢幕的純黑背景';

  @override
  String get aboutTitle => '關於';

  @override
  String get appTagline => '抵達時提醒你';

  @override
  String get version => '版本';

  @override
  String get license => '授權條款';

  @override
  String get licenseValue => 'EUPL 1.2';

  @override
  String get mapData => '地圖資料';

  @override
  String get mapDataValue => 'OpenStreetMap 貢獻者 · OSM France';

  @override
  String get geocoding => '地理編碼';

  @override
  String get geocodingValue => 'Photon by Komoot';

  @override
  String get openSourceLicenses => '開放原始碼授權';

  @override
  String alarmSaved(String name) {
    return '已儲存 $name';
  }

  @override
  String alarmSavedNoGps(String name) {
    return '已儲存 $name（未啟用, 無 GPS 訊號）';
  }

  @override
  String alarmSavedInside(String name) {
    return '已儲存 $name（未啟用）';
  }

  @override
  String alarmSavedNoPermission(String name) {
    return '已儲存 $name, 請啟用背景位置權限以進行監控';
  }

  @override
  String get support => '支持';

  @override
  String get donate => '贊助';

  @override
  String get donateSubtitle => '支持 There Yet 的開發';

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
