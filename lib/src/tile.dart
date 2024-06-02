import 'package:flutter/material.dart';
import 'controller.dart';
import 'widget.dart';
import 'group.dart';
import 'types.dart';
import 'theme.dart';

/// A ListTile with an expansion arrow icon that expands or collapses
/// the tile to reveal or hide its children.
///
/// This widget inherits properties of a regular `ListTile`,
/// but adds the ability to manage a disclosure state.
class DisclosureTile extends ListTile {
  /// Creates a DisclosureTile.
  ///
  /// * The `closed` property determines the initial state of the disclosure (open or closed).
  /// * The `onToggle` callback is invoked when the disclosure state changes.
  /// * The `onOpen` callback is invoked when the disclosure is opened.
  /// * The `onClose` callback is invoked when the disclosure is closed.
  /// * The `duration` property controls the animation duration for state changes.
  /// * The `curve` property controls the animation curve for state changes.
  /// * The `wrapper` property allows customization of the overall disclosure wrapper.
  /// * The `inset` property specifies padding for the children.
  /// * The `children` property defines the widgets that are displayed when the tile expands.
  const DisclosureTile({
    super.key,
    super.title,
    super.subtitle,
    super.leading,
    super.trailing,
    super.dense,
    super.enabled,
    super.onTap,
    this.closed = true,
    this.onToggle,
    this.onOpen,
    this.onClose,
    this.duration,
    this.curve,
    this.wrapper,
    this.insets,
    this.multiple,
    this.clearable,
    this.children = const [],
  });

  /// Whether the disclosure is initially closed.
  final bool closed;

  /// A callback that is invoked when the disclosure state changes.
  final ValueChanged<bool>? onToggle;

  /// A callback that is invoked when the disclosure is opened.
  final VoidCallback? onOpen;

  /// A callback that is invoked when the disclosure is closed.
  final VoidCallback? onClose;

  /// The duration over which to animate the disclosure state changes.
  final Duration? duration;

  /// The curve to apply when animating the disclosure state changes.
  final Curve? curve;

  /// A widget that wraps the entire disclosure content, allowing customization.
  final DisclosureWrapper? wrapper;

  /// Specifies padding for the children.
  final EdgeInsetsGeometry? insets;

  /// Whether multiple children can be selected simultaneously.
  final bool? multiple;

  /// Whether all children can be cleared.
  final bool? clearable;

  /// The widgets that are displayed when the tile expands.
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    if (children.isEmpty) {
      final theme = DisclosureTheme.of(context);
      final defaultLeading = theme.tileLeadingBuilder(children.isNotEmpty);
      final defaultTrailing = theme.tileTrailingBuilder(children.isNotEmpty);
      return ListTile(
        title: title,
        subtitle: subtitle,
        leading: leading ?? defaultLeading,
        trailing: trailing ?? defaultTrailing,
        onTap: onTap,
        dense: dense,
      );
    }

    bool? effectiveMultiple = multiple;
    bool? effectiveClearable = clearable;
    EdgeInsetsGeometry? effectiveInsets = insets;
    Widget? effectiveLeading = leading;
    Widget? effectiveTrailing = trailing;

    if (effectiveMultiple == null ||
        effectiveClearable == null ||
        effectiveInsets == null ||
        effectiveLeading == null ||
        effectiveTrailing == null) {
      final theme = DisclosureTheme.of(context);
      effectiveMultiple ??= theme.tileMultiple;
      effectiveClearable ??= theme.tileClearable;
      effectiveInsets ??= theme.tileInsets;
      effectiveLeading ??= theme.tileLeadingBuilder(children.isNotEmpty);
      effectiveTrailing ??= theme.tileTrailingBuilder(children.isNotEmpty);
    }

    return Disclosure(
      key: key ?? ValueKey(title.hashCode),
      closed: closed,
      onToggle: onToggle,
      onOpen: onOpen,
      onClose: onClose,
      duration: duration,
      curve: curve,
      wrapper: wrapper,
      header: DisclosureConsumer(
        builder: (state, child) {
          return ListTile(
            title: title,
            subtitle: subtitle,
            leading: effectiveLeading,
            trailing: effectiveTrailing,
            onTap: children.isNotEmpty ? state.toggle : null,
            dense: dense,
          );
        },
      ),
      child: DisclosureGroup(
        multiple: effectiveMultiple,
        clearable: effectiveClearable,
        insets: effectiveInsets,
        children: children,
      ),
    );
  }
}
