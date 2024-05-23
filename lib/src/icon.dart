import 'package:flutter/material.dart';
import 'controller.dart';
import 'theme.dart';

/// An interactive icon that visually indicates the disclosure state
/// (open or closed) and allows toggling the state.
class DisclosureIcon extends Icon {
  /// Creates an interactive disclosure icon.
  ///
  /// The `icon` property specifies the icon to be used.
  /// The `duration` property controls the animation duration for state changes.
  /// The `curve` property controls the animation curve for state changes.
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
