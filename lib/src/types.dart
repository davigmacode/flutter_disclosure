import 'package:flutter/widgets.dart';
import 'controller.dart';

typedef DisclosureTileExtrasBuilder = Widget? Function(bool hasChildren);

typedef DisclosureWrapper = Widget Function(
  DisclosureController state,
  Widget child,
);
