import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'theme_data.dart';
import 'types.dart';

/// A Widget that controls how descendant [Disclosure] should look like.
class DisclosureTheme extends InheritedTheme {
  /// The properties for descendant [Disclosure]s
  final DisclosureThemeData data;

  /// Creates a theme that controls
  /// how descendant [Disclosure] should look like.
  const DisclosureTheme({
    super.key,
    required this.data,
    required super.child,
  });

  /// Creates an [DisclosureTheme] that controls the style of
  /// descendant widgets, and merges in the current [DisclosureTheme], if any.
  ///
  /// The [child] arguments must not be null.
  static Widget merge({
    Key? key,
    Duration? duration,
    Curve? curve,
    DisclosureWrapper? wrapper,
    IconData? icon,
    EdgeInsetsGeometry? inset,
    EdgeInsetsGeometry? tileInset,
    DisclosureThemeData? data,
    required Widget child,
  }) {
    return Builder(
      builder: (BuildContext context) {
        final parent = DisclosureTheme.of(context);
        return DisclosureTheme(
          key: key,
          data: parent.merge(data).copyWith(
                duration: duration,
                curve: curve,
                wrapper: wrapper,
                icon: icon,
                insets: inset,
                tileInsets: tileInset,
              ),
          child: child,
        );
      },
    );
  }

  /// The [DisclosureTheme] from the closest instance of
  /// this class that encloses the given context.
  ///
  /// Typical usage is as follows:
  ///
  /// ```dart
  /// DisclosureThemeData theme = DisclosureTheme.of(context);
  /// ```
  static DisclosureThemeData of(BuildContext context) {
    final parentTheme =
        context.dependOnInheritedWidgetOfExactType<DisclosureTheme>();
    if (parentTheme != null) return parentTheme.data;

    final globalTheme = Theme.of(context).extension<DisclosureThemeData>();
    const defaultTheme = DisclosureThemeData.fallback;
    return defaultTheme.merge(globalTheme);
  }

  @override
  Widget wrap(BuildContext context, Widget child) {
    return DisclosureTheme(data: data, child: child);
  }

  @override
  bool updateShouldNotify(DisclosureTheme oldWidget) {
    return oldWidget.data != data;
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<DisclosureThemeData>('data', data));
  }
}
