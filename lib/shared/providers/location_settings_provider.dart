import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:location_alarm/shared/providers/preferences_provider.dart';

const usePlayServicesKey = 'use_play_services';

final usePlayServicesProvider = NotifierProvider<UsePlayServicesNotifier, bool>(
  UsePlayServicesNotifier.new,
);

class UsePlayServicesNotifier extends Notifier<bool> {
  @override
  bool build() {
    final prefs = ref.read(preferencesProvider);
    return prefs.getBool(usePlayServicesKey) ?? false;
  }

  void set(bool enabled) {
    state = enabled;
    final prefs = ref.read(preferencesProvider);
    prefs.setBool(usePlayServicesKey, enabled);
  }
}
