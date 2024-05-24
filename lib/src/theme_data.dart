import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'controller.dart';
import 'types.dart';

/// Defines the visual properties of [Disclosure].
///
/// Descendant widgets obtain the current [DisclosureThemeData] object using
/// `DisclosureTheme.of(context)`. Instances of [DisclosureThemeData]
/// can be customized with [DisclosureThemeData.copyWith] or [DisclosureThemeData.merge].
@immutable
class DisclosureThemeData extends ThemeExtension<DisclosureThemeData>
    with Diagnosticable {
  /// The duration over which to animate the parameters of this widget.
  final Duration duration;

  /// The curve to apply when animating the parameters of this widget.
  final Curve curve;

  /// A widget that wraps the entire disclosure content, allowing customization.
  final DisclosureWrapper wrapper;

  /// Specifies the icon to be used within the disclosure icon.
  final IconData icon;

  /// Specifies padding for the child, and secondary (if exists).
  final EdgeInsetsGeometry inset;

  /// Specifies padding for tile children.
  final EdgeInsetsGeometry tileInset;

  /// Creates a theme data that can be used for [DisclosureTheme].
  const DisclosureThemeData({
    required this.duration,
    required this.curve,
    required this.wrapper,
    required this.icon,
    required this.inset,
    required this.tileInset,
  });

  /// An [DisclosureThemeData] with some reasonable default values.
  static const fallback = DisclosureThemeData(
    duration: Duration(milliseconds: 200),
    curve: Curves.linear,
    wrapper: defaultWrapper,
    icon: Icons.keyboard_arrow_down,
    inset: EdgeInsets.zero,
    tileInset: EdgeInsets.fromLTRB(25, 0, 0, 0),
  );

  static const defaultWrapper = _defaultWrapper;
  static Widget _defaultWrapper(DisclosureController state, Widget child) {
    return child;
  }

  /// Creates a [DisclosureThemeData] from another one that probably null.
  DisclosureThemeData.from([DisclosureThemeData? other])
      : duration = other?.duration ?? fallback.duration,
        curve = other?.curve ?? fallback.curve,
        wrapper = other?.wrapper ?? fallback.wrapper,
        icon = other?.icon ?? fallback.icon,
        inset = other?.tileInset ?? fallback.inset,
        tileInset = other?.tileInset ?? fallback.tileInset;

  /// Creates a copy of this [DisclosureThemeData] but with
  /// the given fields replaced with the new values.
  @override
  DisclosureThemeData copyWith({
    Duration? duration,
    Curve? curve,
    DisclosureWrapper? wrapper,
    IconData? icon,
    EdgeInsetsGeometry? inset,
    EdgeInsetsGeometry? tileInset,
  }) {
    return DisclosureThemeData(
      duration: duration ?? this.duration,
      curve: curve ?? this.curve,
      wrapper: wrapper ?? this.wrapper,
      icon: icon ?? this.icon,
      inset: inset ?? this.inset,
      tileInset: tileInset ?? this.tileInset,
    );
  }

  /// Creates a copy of this [DisclosureThemeData] but with
  /// the given fields replaced with the new values.
  DisclosureThemeData merge(DisclosureThemeData? other) {
    // if null return current object
    if (other == null) return this;

    return copyWith(
      duration: other.duration,
      curve: other.curve,
      wrapper: other.wrapper,
      icon: other.icon,
      inset: other.inset,
      tileInset: other.tileInset,
    );
  }

  @override
  DisclosureThemeData lerp(DisclosureThemeData? other, double t) {
    if (other == null) return this;
    return DisclosureThemeData(
      duration: lerpDuration(duration, other.duration, t),
      curve: t < 0.5 ? curve : other.curve,
      wrapper: t < 0.5 ? wrapper : other.wrapper,
      icon: t < 0.5 ? icon : other.icon,
      inset: EdgeInsetsGeometry.lerp(inset, other.inset, t)!,
      tileInset: EdgeInsetsGeometry.lerp(tileInset, other.tileInset, t)!,
    );
  }

  Map<String, dynamic> toMap() => {
        'duration': duration,
        'curve': curve,
        'wrapper': wrapper,
        'icon': icon,
        'inset': inset,
        'tileInset': tileInset,
      };

  @override
  bool operator ==(Object other) {
    if (other.runtimeType != runtimeType) return false;
    return other is DisclosureThemeData && mapEquals(other.toMap(), toMap());
  }

  @override
  int get hashCode => Object.hashAll(toMap().values);

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    toMap().entries.forEach((el) {
      properties.add(DiagnosticsProperty(el.key, el.value, defaultValue: null));
    });
  }
}
