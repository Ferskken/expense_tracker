import 'package:flutter/material.dart';

/// A custom widget representing a bar in a chart.
class ChartBar extends StatelessWidget {
  /// Constructs a [ChartBar] widget.
  /// The [fill] parameter specifies the fill level of the bar as a double value
  /// between 0.0 and 1.0.
  const ChartBar({
    super.key,
    required this.fill,
  });

  /// The fill level of the bar, represented as a double value between 0.0 and 1.0.
  final double fill;

  @override
  Widget build(BuildContext context) {
    // Determine the brightness of the platform (light or dark mode)
    final isDarkMode =
        MediaQuery.of(context).platformBrightness == Brightness.dark;
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4),
        child: FractionallySizedBox(
          heightFactor:
              fill, // Set the height of the bar based on the fill value
          child: DecoratedBox(
            decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              borderRadius:
                  // Determine the color of the bar based on the theme and brightness
                  const BorderRadius.vertical(top: Radius.circular(8)),
              color: isDarkMode
                  ? Theme.of(context).colorScheme.secondary
                  : Theme.of(context).colorScheme.primary.withOpacity(0.65),
            ),
          ),
        ),
      ),
    );
  }
}
