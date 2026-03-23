import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Whether the device can reach the geocoding server.
/// Checked on app start and refreshed on app resume.
final connectivityProvider = NotifierProvider<ConnectivityNotifier, bool>(
  ConnectivityNotifier.new,
);

class ConnectivityNotifier extends Notifier<bool> {
  @override
  bool build() {
    check();
    return true;
  }

  Future<void> check() async {
    try {
      final result = await InternetAddress.lookup(
        'photon.komoot.io',
      ).timeout(const Duration(seconds: 2));
      state = result.isNotEmpty && result[0].rawAddress.isNotEmpty;
    } on Exception {
      state = false;
    }
  }
}
