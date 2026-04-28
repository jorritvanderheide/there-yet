// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Korean (`ko`).
class AppLocalizationsKo extends AppLocalizations {
  AppLocalizationsKo([String locale = 'ko']) : super(locale);

  @override
  String get appTitle => 'There Yet';

  @override
  String get alarmsTitle => '알람';

  @override
  String get noAlarmsYet => '알람이 없습니다';

  @override
  String get tapToCreateFirst => '+를 눌러 첫 번째 알람을 만드세요';

  @override
  String get failedToLoadAlarms => '알람을 불러오지 못했습니다';

  @override
  String get retry => '다시 시도';

  @override
  String get sortBy => '정렬 기준';

  @override
  String get sortAlarms => '알람 정렬';

  @override
  String get sortDateCreated => '생성일';

  @override
  String get sortName => '이름';

  @override
  String get settings => '설정';

  @override
  String get about => '정보';

  @override
  String nSelected(int count) {
    return '$count개 선택됨';
  }

  @override
  String get deleteSelected => '선택 항목 삭제';

  @override
  String deleteNAlarms(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '알람 $count개를 삭제할까요?',
    );
    return '$_temp0';
  }

  @override
  String deleteNAlarmsBody(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '알람 $count개가 영구적으로 삭제됩니다.',
    );
    return '$_temp0';
  }

  @override
  String get cancel => '취소';

  @override
  String get delete => '삭제';

  @override
  String get ok => '확인';

  @override
  String alarmDeactivated(String name) {
    return '$name 비활성화됨';
  }

  @override
  String alarmActivated(String name, String distance) {
    return '$name 활성화됨, $distance 남음';
  }

  @override
  String get locationPermissionRequired => '위치 권한이 필요합니다';

  @override
  String get notificationsDisabled => '알림이 꺼져 있어 알람 소리를 들을 수 없습니다';

  @override
  String get alreadyInsideAlarmArea => '이미 알람 범위 안에 있습니다';

  @override
  String alreadyInsideAlarmAreaBody(
    String distance,
    String name,
    String radius,
  ) {
    return '현재 \"$name\"에서 $distance 떨어져 있습니다. 알람을 활성화하려면 $radius 범위 밖으로 이동하세요.';
  }

  @override
  String get gpsDisabled => 'GPS가 꺼져 있습니다';

  @override
  String get openSettings => '설정 열기';

  @override
  String get couldNotAcquireLocation => '위치를 확인할 수 없습니다';

  @override
  String nAlarmsDeleted(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '알람 $count개 삭제됨',
    );
    return '$_temp0';
  }

  @override
  String deleteFailed(String message) {
    return '삭제 실패: $message';
  }

  @override
  String get alarmsNotMonitored => '알람이 모니터링되고 있지 않습니다';

  @override
  String get tapToCheckPermissions => '눌러서 권한 확인';

  @override
  String get backgroundLocationRequired => '백그라운드 위치 권한이 필요합니다';

  @override
  String get gettingLocation => '위치 확인 중…';

  @override
  String alarmDefaultName(int id) {
    return '알람 #$id';
  }

  @override
  String get active => '활성';

  @override
  String get inactive => '비활성';

  @override
  String get backgroundLocationNeeded => '백그라운드 위치 정보가 필요합니다';

  @override
  String get backgroundLocationBody =>
      '도착 시 알람을 울리려면 There Yet이 백그라운드에서 위치를 모니터링해야 합니다.\n\n다음 화면에서 \"항상 허용\"을 선택하세요.';

  @override
  String get continueButton => '계속';

  @override
  String get disableBatteryOptimization => '배터리 최적화 해제';

  @override
  String get batteryOptimizationBody =>
      '백그라운드에서 위치를 안정적으로 모니터링하려면 There Yet을 배터리 최적화에서 제외해야 합니다.\n\n이 설정이 없으면 Android가 배터리 절약을 위해 알람 서비스를 중지할 수 있습니다.';

  @override
  String get skip => '건너뛰기';

  @override
  String get disableOptimization => '최적화 해제';

  @override
  String get insideAlarmArea => '알람 범위 안에 있습니다';

  @override
  String get insideAlarmAreaBody =>
      '현재 알람 범위 안에 있습니다. 알람은 비활성 상태로 저장되며, 범위를 벗어나면 활성화됩니다.';

  @override
  String get saveInactive => '비활성으로 저장';

  @override
  String get discardChanges => '변경 사항을 버릴까요?';

  @override
  String get unsavedChangesBody => '저장하지 않은 변경 사항이 사라집니다.';

  @override
  String get keepEditing => '계속 편집';

  @override
  String get discard => '버리기';

  @override
  String get locationUnavailable => '위치를 사용할 수 없습니다';

  @override
  String get failedToLoadAlarm => '알람을 불러오지 못했습니다';

  @override
  String get osmAttribution => '© OpenStreetMap';

  @override
  String get searchLocation => '장소 검색';

  @override
  String get searchLocationOffline => '검색을 사용할 수 없습니다 (오프라인)';

  @override
  String get noResultsFound => '검색 결과가 없습니다';

  @override
  String get label => '라벨';

  @override
  String get save => '저장';

  @override
  String get centerOnMyLocation => '내 위치로 이동';

  @override
  String get resetNorth => '북쪽으로 정렬';

  @override
  String get createAlarm => '알람 만들기';

  @override
  String get dismiss => '닫기';

  @override
  String get locationAlarmDefault => 'There Yet';

  @override
  String alarmBodyWithinRadius(int radius) {
    return '목적지까지 $radius m 이내입니다';
  }

  @override
  String get appearance => '화면';

  @override
  String get theme => '테마';

  @override
  String get themeSystem => '시스템';

  @override
  String get themeLight => '라이트';

  @override
  String get themeDark => '다크';

  @override
  String get materialYou => 'Material You';

  @override
  String get materialYouSubtitle => '배경화면 색상 사용';

  @override
  String get trueBlack => '트루 블랙';

  @override
  String get trueBlackSubtitle => 'AMOLED 디스플레이용 순수 검정 배경';

  @override
  String get aboutTitle => '정보';

  @override
  String get appTagline => '도착하면 알려드립니다';

  @override
  String get version => '버전';

  @override
  String get license => '라이선스';

  @override
  String get licenseValue => 'EUPL 1.2';

  @override
  String get mapData => '지도 데이터';

  @override
  String get mapDataValue => 'OpenStreetMap contributors · OSM France';

  @override
  String get geocoding => '지오코딩';

  @override
  String get geocodingValue => 'Photon by Komoot';

  @override
  String get openSourceLicenses => '오픈소스 라이선스';

  @override
  String alarmSaved(String name) {
    return '$name 저장됨';
  }

  @override
  String alarmSavedNoGps(String name) {
    return '$name 저장됨 (비활성, GPS 신호 없음)';
  }

  @override
  String alarmSavedInside(String name) {
    return '$name 저장됨 (비활성)';
  }

  @override
  String alarmSavedNoPermission(String name) {
    return '$name 저장됨, 모니터링하려면 백그라운드 위치를 활성화하세요';
  }

  @override
  String get support => '지원';

  @override
  String get donate => '후원하기';

  @override
  String get donateSubtitle => 'There Yet 개발 지원';

  @override
  String get rateApp => 'There Yet 평가하기';

  @override
  String get rateAppSubtitle => 'Play 스토어에 리뷰 남기기';

  @override
  String get sendFeedback => '피드백 보내기';

  @override
  String get sendFeedbackSubtitle => '개발자에게 이메일 보내기';

  @override
  String get help => '도움말';

  @override
  String get helpSubtitle => '프로젝트 페이지 보기';
}
