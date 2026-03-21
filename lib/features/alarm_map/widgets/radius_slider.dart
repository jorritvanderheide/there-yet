import 'dart:math';
import 'package:flutter/material.dart';

// Logarithmic radius slider: finer steps at low end, coarser at high end.
// t=0 → 100m, t=1 → 5000m
double sliderToRadius(double t) => 100 * pow(50, t).toDouble();
double radiusToSlider(double r) => log(r / 100) / log(50);

class RadiusSlider extends StatelessWidget {
  const RadiusSlider({
    super.key,
    required this.radius,
    required this.onChanged,
  });

  final double radius;
  final ValueChanged<double> onChanged;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const SizedBox(width: 16),
        Text(
          '${radius.round()} m',
          style: Theme.of(context).textTheme.titleSmall,
        ),
        Expanded(
          child: Slider(
            value: radiusToSlider(radius),
            min: 0,
            max: 1,
            divisions: 100,
            semanticFormatterCallback: (_) => '${radius.round()} metres radius',
            onChanged: (t) => onChanged(sliderToRadius(t)),
          ),
        ),
      ],
    );
  }
}
