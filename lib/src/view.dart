import 'package:flutter/widgets.dart';
import 'controller.dart';

class DisclosureView extends StatelessWidget {
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

  final double? minWidth;
  final double? maxWidth;
  final double? minHeight;
  final double? maxHeight;
  final BoxConstraints? constraints;
  final EdgeInsetsGeometry? padding;
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
