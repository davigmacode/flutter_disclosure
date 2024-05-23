import 'package:flutter/widgets.dart';
import 'controller.dart';

/// A widget that provides a scrollable container for a single child,
/// often used within a `Disclosure` widget.
class DisclosureView extends StatelessWidget {
  /// Creates a DisclosureView.
  ///
  /// * The `minWidth`, `maxWidth`, `minHeight`, and `maxHeight` properties
  /// control the minimum and maximum dimensions of the scrollable area.
  /// * The `constraints` property allows further customization of the layout.
  /// * The `padding` property adds space around the child.
  /// * The `child` property specifies the content to be scrolled.
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

  /// Creates a DisclosureView using a builder and provides the disclosure state.
  ///
  /// The `builder` callback receives the `DisclosureController` and the child.
  /// This allows for dynamic content based on the disclosure state.
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

  /// Calculates the effective constraints based on the provided properties.
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
