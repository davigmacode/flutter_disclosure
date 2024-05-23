import 'package:flutter/material.dart';
import 'controller.dart';
import 'widget.dart';
import 'icon.dart';
import 'types.dart';
import 'theme.dart';

/// A single-line ListTile with an expansion arrow icon
/// that expands or collapses the tile to reveal or hide the children.
class DisclosureTile extends ListTile {
  /// Creates a ListTile with an expansion arrow icon
  /// that expands or collapses the tile to reveal or hide the children.
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
    this.inset,
    this.children = const [],
  });

  /// An initial value indicates whether the disclosure state is closed or not
  final bool closed;

  /// Triggered on disclosure state update
  final ValueChanged<bool>? onToggle;

  /// Triggered on disclosure state update to opened
  final VoidCallback? onOpen;

  /// Triggered on disclosure state update to closed
  final VoidCallback? onClose;

  /// The duration over which to animate the parameters of this widget.
  final Duration? duration;

  /// The curve to apply when animating the parameters of this widget.
  final Curve? curve;

  final DisclosureWrapper? wrapper;

  /// The widgets that are displayed when the tile expands.
  final List<Widget> children;

  /// Specifies padding for children.
  final EdgeInsetsGeometry? inset;

  Widget? get defaultTrailing =>
      children.isNotEmpty ? const DisclosureIcon() : null;

  @override
  Widget build(BuildContext context) {
    if (children.isEmpty) {
      return ListTile(
        title: title,
        subtitle: subtitle,
        leading: leading,
        trailing: trailing,
        onTap: onTap,
        dense: dense,
      );
    }

    final theme = DisclosureTheme.of(context);
    final effectiveInset = inset ?? theme.tileInset;
    return Disclosure(
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
            leading: leading,
            trailing: trailing ?? defaultTrailing,
            onTap: children.isNotEmpty ? state.toggle : null,
            dense: dense,
          );
        },
      ),
      child: ListView(
        shrinkWrap: true,
        padding: effectiveInset,
        children: children,
      ),
    );
  }
}
