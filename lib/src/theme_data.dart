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
  final EdgeInsetsGeometry insets;

  /// Specifies padding for group children.
  final EdgeInsetsGeometry groupInsets;

  /// Whether multiple group children can be selected simultaneously.
  final bool groupMultiple;

  /// Whether all group children can be cleared.
  final bool groupClearable;

  /// Creates a theme data that can be used for [DisclosureTheme].
  const DisclosureThemeData({
    required this.duration,
    required this.curve,
    required this.wrapper,
    required this.icon,
    required this.insets,
    required this.groupInsets,
    required this.groupMultiple,
    required this.groupClearable,
  });

  /// An [DisclosureThemeData] with some reasonable default values.
  static const fallback = DisclosureThemeData(
    duration: Duration(milliseconds: 200),
    curve: Curves.linear,
    wrapper: defaultWrapper,
    icon: Icons.keyboard_arrow_down,
    insets: EdgeInsets.zero,
    groupInsets: EdgeInsets.zero,
    groupMultiple: false,
    groupClearable: false,
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
        insets = other?.insets ?? fallback.insets,
        groupInsets = other?.groupInsets ?? fallback.groupInsets,
        groupMultiple = other?.groupMultiple ?? fallback.groupMultiple,
        groupClearable = other?.groupClearable ?? fallback.groupClearable;

  /// Creates a copy of this [DisclosureThemeData] but with
  /// the given fields replaced with the new values.
  @override
  DisclosureThemeData copyWith({
    Duration? duration,
    Curve? curve,
    DisclosureWrapper? wrapper,
    IconData? icon,
    EdgeInsetsGeometry? insets,
    EdgeInsetsGeometry? groupInsets,
    bool? groupMultiple,
    bool? groupClearable,
  }) {
    return DisclosureThemeData(
      duration: duration ?? this.duration,
      curve: curve ?? this.curve,
      wrapper: wrapper ?? this.wrapper,
      icon: icon ?? this.icon,
      insets: insets ?? this.insets,
      groupInsets: groupInsets ?? this.groupInsets,
      groupMultiple: groupMultiple ?? this.groupMultiple,
      groupClearable: groupClearable ?? this.groupClearable,
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
      insets: other.insets,
      groupInsets: other.groupInsets,
      groupMultiple: other.groupMultiple,
      groupClearable: other.groupClearable,
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
      insets: EdgeInsetsGeometry.lerp(insets, other.insets, t)!,
      groupInsets: EdgeInsetsGeometry.lerp(groupInsets, other.groupInsets, t)!,
      groupMultiple: t < 0.5 ? groupMultiple : other.groupMultiple,
      groupClearable: t < 0.5 ? groupClearable : other.groupClearable,
    );
  }

  Map<String, dynamic> toMap() => {
        'duration': duration,
        'curve': curve,
        'wrapper': wrapper,
        'icon': icon,
        'insets': insets,
        'groupInsets': groupInsets,
        'groupMultiple': groupMultiple,
        'groupClearable': groupClearable,
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
