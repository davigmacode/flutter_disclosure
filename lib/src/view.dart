import 'package:flutter/widgets.dart';
import 'controller.dart';

class DisclosureView extends StatelessWidget {
  /// Creates a box in which a single widget can be scrolled.
  const DisclosureView({
    super.key,
    this.minWidth,
    this.maxWidth,
    this.minHeight,
    this.maxHeight,
    this.constraints,
    this.padding,
    required this.child,
  });

  /// Creates a disclosure view using builder and provides disclosure state
  DisclosureView.builder({
    super.key,
    this.minWidth,
    this.maxWidth,
    this.minHeight,
    this.maxHeight,
    this.constraints,
    this.padding,
    required DisclosureBuilder builder,
    Widget? child,
  }) : child = DisclosureConsumer(
          builder: builder,
          child: child,
        );

  /// The minimum width that satisfies the constraints.
  final double? minWidth;

  /// The maximum width that satisfies the constraints.
  ///
  /// Might be [double.infinity].
  final double? maxWidth;

  /// The minimum height that satisfies the constraints.
  final double? minHeight;

  /// The maximum height that satisfies the constraints.
  ///
  /// Might be [double.infinity].
  final double? maxHeight;

  /// The additional constraints to impose on the child.
  final BoxConstraints? constraints;

  /// The amount of space by which to inset the child.
  final EdgeInsetsGeometry? padding;

  /// The widget below this widget in the tree.
  final Widget child;

  BoxConstraints get effectiveConstraints {
    return (constraints ?? const BoxConstraints()).copyWith(
      minWidth: minWidth,
      maxWidth: maxWidth,
      minHeight: minHeight,
      maxHeight: maxHeight,
    );
  }

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: effectiveConstraints,
      child: SingleChildScrollView(
        padding: padding,
        child: child,
      ),
    );
  }
}
