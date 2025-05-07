import 'package:flutter/material.dart';
import 'package:fluttercon_countdown/src/utils/app_constants.dart';

/// A widget to display a time unit (e.g., days, hours) with its value and label.
class TimeUnitDisplay extends StatelessWidget {
  /// The numerical value of the time unit.
  final int value;

  /// The label for the time unit (e.g., "Days", "Hours").
  final String label;

  /// Creates an instance of [TimeUnitDisplay].
  ///
  /// Requires [value] and [label].
  const TimeUnitDisplay({
    super.key,
    required this.value,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          value.toString().padLeft(2, '0'), // Pad with leading zero if needed
          style: textTheme.displayMedium?.copyWith(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: kDefaultPadding / 4),
        Text(
          label,
          style: textTheme.titleMedium,
        ),
      ],
    );
  }
}
