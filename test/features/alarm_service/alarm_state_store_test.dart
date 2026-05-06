import 'dart:async';

import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:there_yet/features/alarm_service/alarm_state_store.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  const channel = MethodChannel('nl.bw20.there_yet/alarm_state');
  final messenger =
      TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger;

  Future<MethodCall> setHandlerCapturingCall(
    Future<Object?> Function(MethodCall) respond,
  ) async {
    final completer = Completer<MethodCall>();
    messenger.setMockMethodCallHandler(channel, (call) async {
      if (!completer.isCompleted) completer.complete(call);
      return await respond(call);
    });
    return completer.future;
  }

  tearDown(() {
    messenger.setMockMethodCallHandler(channel, null);
  });

  group('AlarmStateStore', () {
    test('markRinging invokes addRinging with the alarm id', () async {
      final captured = setHandlerCapturingCall((_) async => null);
      await AlarmStateStore.markRinging(42);
      final call = await captured;
      expect(call.method, 'addRinging');
      expect(call.arguments, {'id': 42});
    });

    test('unmarkRinging invokes removeRinging with the alarm id', () async {
      final captured = setHandlerCapturingCall((_) async => null);
      await AlarmStateStore.unmarkRinging(7);
      final call = await captured;
      expect(call.method, 'removeRinging');
      expect(call.arguments, {'id': 7});
    });

    test('getRinging returns ids decoded from the platform list', () async {
      messenger.setMockMethodCallHandler(channel, (call) async {
        if (call.method == 'getRinging') return <Object?>[1, 2, 3];
        return null;
      });
      expect(await AlarmStateStore.getRinging(), [1, 2, 3]);
    });

    test('getRinging returns empty when channel returns null', () async {
      messenger.setMockMethodCallHandler(channel, (_) async => null);
      expect(await AlarmStateStore.getRinging(), isEmpty);
    });

    test('consumePendingDismisses returns ids and is invoked once', () async {
      var calls = 0;
      messenger.setMockMethodCallHandler(channel, (call) async {
        if (call.method == 'consumePendingDismiss') {
          calls++;
          return <Object?>[5, 9];
        }
        return null;
      });
      expect(await AlarmStateStore.consumePendingDismisses(), [5, 9]);
      expect(calls, 1);
    });

    test(
      'consumePendingDismisses returns empty when channel returns null',
      () async {
        messenger.setMockMethodCallHandler(channel, (_) async => null);
        expect(await AlarmStateStore.consumePendingDismisses(), isEmpty);
      },
    );

    test(
      'all methods swallow MissingPluginException when no handler',
      () async {
        // No handler installed: every call throws MissingPluginException.
        // Wrapper must absorb so the FGS doesn't crash on test/desktop.
        await AlarmStateStore.markRinging(1);
        await AlarmStateStore.unmarkRinging(1);
        expect(await AlarmStateStore.getRinging(), isEmpty);
        expect(await AlarmStateStore.consumePendingDismisses(), isEmpty);
      },
    );

    test('all methods swallow PlatformException from native side', () async {
      messenger.setMockMethodCallHandler(channel, (_) async {
        throw PlatformException(code: 'NATIVE_FAIL');
      });
      await AlarmStateStore.markRinging(1);
      await AlarmStateStore.unmarkRinging(1);
      expect(await AlarmStateStore.getRinging(), isEmpty);
      expect(await AlarmStateStore.consumePendingDismisses(), isEmpty);
    });
  });
}
