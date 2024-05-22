import 'package:flutter/material.dart';
import 'controller.dart';
import 'widget.dart';
import 'icon.dart';

/// A single-line ListTile with an expansion arrow icon
/// that expands or collapses the tile to reveal or hide the children.
@immutable
class DisclosureTile extends ListTile {
  /// Creates a ListTile with an expansion arrow icon
  /// that expands or collapses the tile to reveal or hide the children.
  const DisclosureTile({
    super.key,
    super.title,
    super.subtitle,
    super.leading,
    super.trailing,
    super.enabled = true,
    this.closed = true,
    this.inset,
    required this.children,
  });

  /// An initial value indicates whether the disclosure state is closed or not
  final bool closed;

  /// The widgets that are displayed when the tile expands.
  final List<Widget> children;

  /// Specifies padding for children.
  final EdgeInsetsGeometry? inset;

  Widget? get defaultTrailing =>
      children.isNotEmpty ? const DisclosureIcon() : null;

  @override
  Widget build(BuildContext context) {
    return Disclosure(
      closed: closed,
      header: DisclosureConsumer(
        builder: (state, child) {
          return ListTile(
            title: title,
            subtitle: subtitle,
            leading: leading,
            trailing: trailing ?? defaultTrailing,
            onTap: children.isNotEmpty ? state.toggle : null,
          );
        },
      ),
      child: ListView(
        shrinkWrap: true,
        padding: inset ?? const EdgeInsets.fromLTRB(25, 0, 0, 0),
        children: children,
      ),
    );
  }
}
