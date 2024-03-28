import 'package:flutter/material.dart';
import 'controller.dart';

class DisclosureIcon extends Icon {
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

  final Duration duration;
  final Curve curve;

  @override
  Widget build(BuildContext context) {
    return DisclosureConsumer(builder: (context, state, child) {
      return AnimatedRotation(
        turns: state.opened ? .5 : 0,
        duration: duration,
        curve: curve,
        child: super.build(context),
      );
    });
  }
}
