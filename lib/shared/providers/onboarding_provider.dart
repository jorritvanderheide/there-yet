import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:location_alarm/shared/providers/preferences_provider.dart';

const _onboardingKey = 'onboarding_complete';

final onboardingCompleteProvider =
    NotifierProvider<OnboardingCompleteNotifier, bool>(
      OnboardingCompleteNotifier.new,
    );

class OnboardingCompleteNotifier extends Notifier<bool> {
  @override
  bool build() {
    final prefs = ref.read(preferencesProvider);
    return prefs.getBool(_onboardingKey) ?? false;
  }

  void complete() {
    state = true;
    final prefs = ref.read(preferencesProvider);
    prefs.setBool(_onboardingKey, true);
  }
}
