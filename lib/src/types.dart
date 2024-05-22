import 'package:flutter/widgets.dart';
import 'controller.dart';

typedef DisclosureLayoutBuilder = AnimatedSwitcherLayoutBuilder;

typedef DisclosureTransitionBuilder = AnimatedSwitcherTransitionBuilder;

typedef DisclosureWrapper = Widget Function(
  DisclosureController state,
  Widget child,
);
