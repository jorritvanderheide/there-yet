import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:location_alarm/features/alarm_edit/screens/alarm_edit_screen.dart';
import 'package:location_alarm/features/alarm_list/screens/alarm_list_screen.dart';
import 'package:location_alarm/features/map_picker/screens/map_picker_screen.dart';

final navigatorKey = GlobalKey<NavigatorState>();

final router = GoRouter(
  navigatorKey: navigatorKey,
  initialLocation: '/',
  routes: [
    GoRoute(path: '/', builder: (context, state) => const AlarmListScreen()),
    GoRoute(
      path: '/create',
      builder: (context, state) => const AlarmEditScreen(),
    ),
    GoRoute(
      path: '/edit/:id',
      builder: (context, state) {
        final id = int.parse(state.pathParameters['id']!);
        return AlarmEditScreen(alarmId: id);
      },
    ),
    GoRoute(
      path: '/pick-location',
      builder: (context, state) => const MapPickerScreen(),
    ),
  ],
);

class LocationAlarmApp extends StatelessWidget {
  const LocationAlarmApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Location Alarm',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      routerConfig: router,
    );
  }
}
