import 'package:flutter/material.dart';
import 'controller.dart';
import 'widget.dart';
import 'icon.dart';

@immutable
class DisclosureTile extends StatelessWidget {
  const DisclosureTile({
    super.key,
    this.title,
    this.subtitle,
    this.leading,
    this.trailing,
    this.enabled = true,
    this.closed = true,
    this.inset,
    required this.children,
  });

  /// A widget to display before the title.
  ///
  /// Typically an [Icon] or a [CircleAvatar] widget.
  final Widget? leading;

  /// The primary content of the list tile.
  ///
  /// Typically a [Text] widget.
  ///
  /// This should not wrap. To enforce the single line limit, use
  /// [Text.maxLines].
  final Widget? title;

  /// Additional content displayed below the title.
  ///
  /// Typically a [Text] widget.
  ///
  /// If [isThreeLine] is false, this should not wrap.
  ///
  /// If [isThreeLine] is true, this should be configured to take a maximum of
  /// two lines. For example, you can use [Text.maxLines] to enforce the number
  /// of lines.
  ///
  /// The subtitle's default [TextStyle] depends on [TextTheme.bodyMedium] except
  /// [TextStyle.color]. The [TextStyle.color] depends on the value of [enabled]
  /// and [selected].
  ///
  /// When [enabled] is false, the text color is set to [ThemeData.disabledColor].
  ///
  /// When [selected] is false, the text color is set to [ListTileTheme.textColor]
  /// if it's not null and to [TextTheme.bodySmall]'s color if [ListTileTheme.textColor]
  /// is null.
  final Widget? subtitle;

  /// A widget to display after the title.
  ///
  /// Typically an [Icon] widget.
  ///
  /// To show right-aligned metadata (assuming left-to-right reading order;
  /// left-aligned for right-to-left reading order), consider using a [Row] with
  /// [CrossAxisAlignment.baseline] alignment whose first item is [Expanded] and
  /// whose second child is the metadata text, instead of using the [trailing]
  /// property.
  final Widget? trailing;

  /// Whether this list tile is interactive.
  ///
  /// If false, this list tile is styled with the disabled color from the
  /// current [Theme] and the [onTap] and [onLongPress] callbacks are
  /// inoperative.
  final bool enabled;

  final bool closed;

  final List<Widget> children;

  final EdgeInsetsGeometry? inset;

  Widget? get defaultTrailing =>
      children.isNotEmpty ? const DisclosureIcon() : null;

  @override
  Widget build(BuildContext context) {
    return Disclosure(
      closed: closed,
      header: DisclosureConsumer(
        builder: (context, state, child) {
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
