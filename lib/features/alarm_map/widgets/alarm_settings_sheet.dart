import 'package:flutter/material.dart';
import 'package:location_alarm/features/alarm_map/widgets/radius_slider.dart';

class AlarmSettingsSheet extends StatelessWidget {
  const AlarmSettingsSheet({
    super.key,
    required this.labelController,
    required this.radius,
    required this.onRadiusChanged,
    required this.onSave,
    required this.saving,
  });

  final TextEditingController labelController;
  final double radius;
  final ValueChanged<double> onRadiusChanged;
  final VoidCallback onSave;
  final bool saving;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final bottomPadding = MediaQuery.of(context).viewPadding.bottom;

    return Positioned(
      left: 0,
      right: 0,
      bottom: 0,
      child: Container(
        decoration: BoxDecoration(
          color: colorScheme.surface,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.15),
              blurRadius: 8,
              offset: const Offset(0, -2),
            ),
          ],
        ),
        padding: EdgeInsets.fromLTRB(16, 16, 16, bottomPadding + 16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              decoration: const InputDecoration(
                labelText: 'Label',
                border: OutlineInputBorder(),
              ),
              controller: labelController,
            ),
            const SizedBox(height: 16),
            Material(
              elevation: 0,
              borderRadius: BorderRadius.circular(28),
              color: colorScheme.surfaceContainerHigh,
              child: RadiusSlider(radius: radius, onChanged: onRadiusChanged),
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: FilledButton.icon(
                onPressed: saving ? null : onSave,
                icon: saving
                    ? const SizedBox(
                        width: 18,
                        height: 18,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : const Icon(Icons.check),
                label: const Text('Save'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
