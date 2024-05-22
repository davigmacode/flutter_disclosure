import 'package:flutter/material.dart';
import 'controller.dart';
import 'theme.dart';

/// Interactive icon indicating disclosure state
class DisclosureIcon extends Icon {
  /// Create an interactive disclosure icon
  const DisclosureIcon({
    super.key,
    IconData? icon,
    super.color,
    super.size,
    this.duration,
    this.curve,
  }) : super(icon);

  /// The duration over which to animate the parameters of this widget.
  final Duration? duration;

  /// The curve to apply when animating the parameters of this widget.
  final Curve? curve;

  @override
  Widget build(BuildContext context) {
    final theme = DisclosureTheme.of(context);
    final effectiveIcon = icon ?? theme.icon;
    final effectiveDuration = duration ?? theme.duration;
    final effectiveCurve = curve ?? theme.curve;
    return DisclosureConsumer(builder: (state, child) {
      return AnimatedRotation(
        turns: state.opened ? .5 : 0,
        duration: effectiveDuration,
        curve: effectiveCurve,
        child: Icon(
          effectiveIcon,
          color: color,
          size: size,
        ),
      );
    });
  }
}
