import 'dart:async';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:latlong2/latlong.dart';
import 'package:location_alarm/features/alarm_map/widgets/alarm_map_hint.dart';
import 'package:location_alarm/features/alarm_map/widgets/alarm_settings_sheet.dart';
import 'package:location_alarm/features/map/widgets/alarm_map.dart';
import 'package:location_alarm/features/map/widgets/center_on_location_fab.dart';
import 'package:location_alarm/features/map/widgets/compass_button.dart';
import 'package:location_alarm/features/map/widgets/current_location_marker.dart';
import 'package:location_alarm/shared/data/alarm_thumbnail.dart';
import 'package:location_alarm/shared/data/geo_utils.dart';
import 'package:location_alarm/shared/data/models/alarm.dart';
import 'package:location_alarm/shared/providers/alarm_repository_provider.dart';
import 'package:location_alarm/shared/providers/location_permission_provider.dart';
import 'package:location_alarm/shared/providers/location_provider.dart';

class AlarmMapScreen extends ConsumerStatefulWidget {
  const AlarmMapScreen({super.key, this.alarmId});

  final int? alarmId;

  @override
  ConsumerState<AlarmMapScreen> createState() => _AlarmMapScreenState();
}

class _AlarmMapScreenState extends ConsumerState<AlarmMapScreen>
    with TickerProviderStateMixin {
  final _mapController = MapController();
  final _mapKey = GlobalKey();
  bool _hasCenteredOnLocation = false;

  bool _isNew = true;
  bool _loaded = false;
  bool _saving = false;
  bool _wasActive = true;

  late TextEditingController _labelController;
  LatLng? _selectedLocation;
  double _radius = 500;

  String _initialLabel = '';
  LatLng? _initialLocation;
  double _initialRadius = 500;

  @override
  void initState() {
    super.initState();
    _labelController = TextEditingController();
    _isNew = widget.alarmId == null;
    if (!_isNew) {
      _loadAlarm();
    } else {
      _loaded = true;
    }
    Future.microtask(() {
      ref.read(locationPermissionProvider.notifier).request();
    });
  }

  @override
  void dispose() {
    _labelController.dispose();
    _mapController.dispose();
    super.dispose();
  }

  bool get _hasUnsavedChanges {
    if (!_loaded) return false;
    return _labelController.text != _initialLabel ||
        _selectedLocation != _initialLocation ||
        _radius != _initialRadius;
  }

  // -- Data loading --

  Future<void> _loadAlarm() async {
    try {
      final repo = ref.read(alarmRepositoryProvider);
      final alarms = await repo.watchAll().first;
      final alarm = alarms.where((a) => a.id == widget.alarmId).firstOrNull;
      if (alarm == null) {
        if (mounted) context.pop();
        return;
      }

      if (!mounted) return;

      setState(() {
        _labelController.text = alarm.name;
        _selectedLocation = alarm.location;
        _wasActive = alarm.active;
        _radius = alarm.radius;
        _hasCenteredOnLocation = true;
        _initialLabel = alarm.name;
        _initialLocation = alarm.location;
        _initialRadius = alarm.radius;
        _loaded = true;
      });
    } on Exception {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('Failed to load alarm')));
        context.pop();
      }
    }
  }

  // -- Map helpers --

  CameraFit? _initialCameraFit() {
    if (_selectedLocation == null) return null;
    return _boundsForCircle();
  }

  CameraFit _boundsForCircle({EdgeInsets padding = const EdgeInsets.all(48)}) {
    const dist = Distance();
    final offset = dist.offset(_selectedLocation!, _radius, 0);
    final latDiff = (offset.latitude - _selectedLocation!.latitude).abs() * 1.5;

    return CameraFit.bounds(
      bounds: LatLngBounds(
        LatLng(
          _selectedLocation!.latitude - latDiff,
          _selectedLocation!.longitude - latDiff,
        ),
        LatLng(
          _selectedLocation!.latitude + latDiff,
          _selectedLocation!.longitude + latDiff,
        ),
      ),
      padding: padding,
    );
  }

  void _fitCircle() {
    if (_selectedLocation == null) return;
    _mapController.fitCamera(_boundsForCircle());
  }

  void _centerOnFirstLocation() {
    if (_hasCenteredOnLocation) return;
    final locationAsync = ref.read(locationProvider);
    locationAsync.whenData((position) {
      _hasCenteredOnLocation = true;
      _mapController.move(LatLng(position.latitude, position.longitude), 15);
    });
  }

  /// Animates the camera to [target] over [duration].
  Future<void> _animateCamera(
    CameraFit target, {
    Duration duration = const Duration(milliseconds: 400),
  }) {
    final dest = target.fit(_mapController.camera);
    final startCenter = _mapController.camera.center;
    final startZoom = _mapController.camera.zoom;
    final endCenter = dest.center;
    final endZoom = dest.zoom;

    final controller = AnimationController(vsync: this, duration: duration);
    final completer = Completer<void>();

    controller.addListener(() {
      if (!mounted) return;
      final t = Curves.easeInOut.transform(controller.value);
      final lat =
          startCenter.latitude +
          (endCenter.latitude - startCenter.latitude) * t;
      final lng =
          startCenter.longitude +
          (endCenter.longitude - startCenter.longitude) * t;
      final zoom = startZoom + (endZoom - startZoom) * t;
      _mapController.move(LatLng(lat, lng), zoom);
    });

    controller.addStatusListener((status) {
      if (status == AnimationStatus.completed ||
          status == AnimationStatus.dismissed) {
        controller.dispose();
        if (!completer.isCompleted) completer.complete();
      }
    });

    controller.forward();
    return completer.future;
  }

  Future<Uint8List?> _captureMap() async {
    try {
      final boundary =
          _mapKey.currentContext?.findRenderObject() as RenderRepaintBoundary?;
      if (boundary == null) return null;
      final image = await boundary.toImage(pixelRatio: 1.5);
      final byteData = await image.toByteData(format: ui.ImageByteFormat.png);
      image.dispose();
      return byteData?.buffer.asUint8List();
    } catch (_) {
      return null;
    }
  }

  // -- Save --

  Future<void> _save() async {
    if (_saving || _selectedLocation == null) return;
    setState(() => _saving = true);

    try {
      await _performSave();
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }

  Future<void> _performSave() async {
    final permNotifier = ref.read(locationPermissionProvider.notifier);
    final bgGranted = await permNotifier.requestBackground();
    if (!mounted) return;

    if (!bgGranted) {
      final proceed = await showDialog<bool>(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Background location required'),
          content: const Text(
            'Without background location permission, the alarm will not '
            'trigger. You can grant it later in system settings.',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context, true),
              child: const Text('Save anyway'),
            ),
          ],
        ),
      );
      if (proceed != true || !mounted) return;
    }

    await permNotifier.requestNotification();
    if (!mounted) return;

    // Animate to nicely framed view, then capture thumbnail.
    await _animateCamera(_boundsForCircle());
    await Future<void>.delayed(const Duration(milliseconds: 300));
    final thumbnail = await _captureMap();
    if (!mounted) return;

    final repo = ref.read(alarmRepositoryProvider);

    final position = ref.read(locationProvider).whenData((p) => p).value;
    final hasLocationLock = position != null;
    final isInsideRadius =
        hasLocationLock &&
        distanceInMeters(
              LatLng(position.latitude, position.longitude),
              _selectedLocation!,
            ) <=
            _radius;

    if (isInsideRadius) {
      final proceed = await showDialog<bool>(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Inside alarm area'),
          content: const Text(
            'You are currently inside this alarm area. The alarm will be '
            'saved inactive and activate once you leave.',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context, true),
              child: const Text('Save inactive'),
            ),
          ],
        ),
      );
      if (proceed != true || !mounted) return;
    }

    final active = (!hasLocationLock || isInsideRadius) ? false : _wasActive;
    final alarm = AlarmData(
      id: widget.alarmId,
      name: _labelController.text,
      location: _selectedLocation!,
      active: active,
      radius: _radius,
    );

    if (thumbnail != null && widget.alarmId != null) {
      try {
        await AlarmThumbnail.save(widget.alarmId!, thumbnail);
      } on Exception {
        // non-critical
      }
    }

    final alarmId = await repo.save(alarm);

    if (thumbnail != null && widget.alarmId == null) {
      try {
        await AlarmThumbnail.save(alarmId, thumbnail);
      } on Exception {
        // non-critical
      }
    }

    if (!mounted) return;

    final label = _labelController.text.isEmpty
        ? 'Alarm'
        : _labelController.text;

    final String message;
    if (!bgGranted) {
      message = '$label saved — enable background location to monitor';
    } else if (!hasLocationLock) {
      message = '$label saved (inactive — no GPS lock)';
    } else if (isInsideRadius) {
      message = '$label saved (inactive)';
    } else {
      message = '$label saved';
    }

    _initialLabel = _labelController.text;
    _initialLocation = _selectedLocation;
    _initialRadius = _radius;

    context.pop();

    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }

  // -- Build --

  @override
  Widget build(BuildContext context) {
    ref.listen(locationProvider, (_, next) {
      next.whenData((_) => _centerOnFirstLocation());
    });

    if (!_loaded) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    final colorScheme = Theme.of(context).colorScheme;

    return PopScope(
      canPop: !_hasUnsavedChanges,
      onPopInvokedWithResult: (didPop, _) async {
        if (didPop) return;
        final discard = await showDialog<bool>(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Discard changes?'),
            content: const Text('Your unsaved changes will be lost.'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context, false),
                child: const Text('Keep editing'),
              ),
              TextButton(
                onPressed: () => Navigator.pop(context, true),
                child: const Text('Discard'),
              ),
            ],
          ),
        );
        if (discard != true || !mounted) return;
        if (context.mounted) context.pop();
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          scrolledUnderElevation: 0,
          flexibleSpace: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.black.withValues(alpha: 0.35),
                  Colors.black.withValues(alpha: 0.0),
                ],
              ),
            ),
          ),
          foregroundColor: Colors.white,
          systemOverlayStyle: SystemUiOverlayStyle.light,
        ),
        body: Stack(
          children: [
            RepaintBoundary(
              key: _mapKey,
              child: AlarmMap(
                mapController: _mapController,
                initialCenter: _selectedLocation,
                initialZoom: _selectedLocation != null ? 15 : 7,
                initialCameraFit: _initialCameraFit(),
                onTap: (_, latLng) {
                  setState(() => _selectedLocation = latLng);
                },
                children: [
                  const CurrentLocationMarker(),
                  if (_selectedLocation != null)
                    CircleLayer(
                      circles: [
                        CircleMarker(
                          point: _selectedLocation!,
                          radius: _radius,
                          useRadiusInMeter: true,
                          color: colorScheme.primary.withValues(alpha: 0.25),
                          borderColor: colorScheme.primary,
                          borderStrokeWidth: 2,
                        ),
                      ],
                    ),
                  if (_selectedLocation != null)
                    MarkerLayer(
                      rotate: true,
                      markers: [
                        Marker(
                          point: _selectedLocation!,
                          width: 18,
                          height: 18,
                          alignment: Alignment.center,
                          child: Container(
                            decoration: BoxDecoration(
                              color: colorScheme.primary,
                              shape: BoxShape.circle,
                              border: Border.all(color: Colors.white, width: 2),
                            ),
                          ),
                        ),
                      ],
                    ),
                ],
              ),
            ),

            // Map controls (bottom-right, above sheet)
            Positioned(
              right: 16,
              bottom: 232,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CompassButton(mapController: _mapController),
                  const SizedBox(height: 8),
                  CenterOnLocationButton(mapController: _mapController),
                ],
              ),
            ),

            if (_selectedLocation == null) const AlarmMapHint(),

            AlarmSettingsSheet(
              labelController: _labelController,
              radius: _radius,
              onRadiusChanged: (r) {
                setState(() => _radius = r);
                _fitCircle();
              },
              onSave: _save,
              saving: _saving,
            ),
          ],
        ),
      ),
    );
  }
}
