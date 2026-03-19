import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:location_alarm/features/alarm_list/widgets/alarm_card.dart';
import 'package:location_alarm/shared/providers/alarm_repository_provider.dart';
import 'package:location_alarm/shared/providers/alarms_provider.dart';

class AlarmListScreen extends ConsumerWidget {
  const AlarmListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final alarmsAsync = ref.watch(alarmsProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Location Alarm')),
      body: alarmsAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (_, _) => const Center(child: Text('Failed to load alarms')),
        data: (alarms) {
          if (alarms.isEmpty) {
            return Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.notifications_none,
                    size: 64,
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'No alarms yet',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Tap + to create your first alarm',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            );
          }

          // Active alarms first, then inactive
          final sorted = [...alarms]
            ..sort((a, b) {
              if (a.active != b.active) return a.active ? -1 : 1;
              return 0;
            });

          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              for (final alarm in sorted)
                Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: AlarmCard(
                    alarm: alarm,
                    onTap: () => context.go('/edit/${alarm.id}'),
                    onToggle: (active) {
                      ref
                          .read(alarmRepositoryProvider)
                          .toggleActive(alarm.id!, active: active);
                    },
                  ),
                ),
            ],
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        heroTag: 'create_alarm',
        onPressed: () => context.go('/create'),
        child: const Icon(Icons.add),
      ),
    );
  }
}
