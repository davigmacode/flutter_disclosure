import 'package:flutter/material.dart';
import 'controller.dart';

/// Interactive icon indicating disclosure state
class DisclosureIcon extends Icon {
  /// Create an interactive disclosure icon
  const DisclosureIcon({
    super.key,
    IconData? icon,
    super.color,
    super.size,
    this.duration = defaultDuration,
    this.curve = defaultCurve,
  }) : super(icon ?? defaultIcon);

  static const defaultIcon = IconData(0xe246, fontFamily: 'MaterialIcons');
  static const defaultDuration = Duration(milliseconds: 200);
  static const defaultCurve = Curves.linear;

  /// The duration over which to animate the parameters of this widget.
  final Duration duration;

  /// The curve to apply when animating the parameters of this widget.
  final Curve curve;

  @override
  Widget build(BuildContext context) {
    return DisclosureConsumer(builder: (state, child) {
      return AnimatedRotation(
        turns: state.opened ? .5 : 0,
        duration: duration,
        curve: curve,
        child: super.build(context),
      );
    });
  }
}
