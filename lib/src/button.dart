import 'package:flutter/material.dart';
import 'controller.dart';

/// Determines button behavior based on the disclosure state
typedef DisclosureButtonCallback = VoidCallback Function(
  DisclosureController state,
);

/// Invoked to construct the button's container
typedef DisclosureButtonBuilder = Widget Function(
  VoidCallback action,
  Widget child,
);

abstract class DisclosureButtonAction {
  /// Inverts the disclosure state (open/closed)
  static const DisclosureButtonCallback toggle = _toggle;
  static VoidCallback _toggle(DisclosureController state) => state.toggle;

  /// Set the disclosure state to opened
  static const DisclosureButtonCallback open = _open;
  static VoidCallback _open(DisclosureController state) => state.open;

  /// Set the disclosure state to closed
  static const DisclosureButtonCallback close = _close;
  static VoidCallback _close(DisclosureController state) => state.close;
}

abstract class DisclosureButtonWrapper {
  /// Use [GestureDetector] as disclosure button wrapper
  static const basic = _basic;
  static Widget _basic(
    VoidCallback action,
    Widget child,
  ) {
    return GestureDetector(
      onTap: action,
      child: child,
    );
  }

  /// Use [InkWell] as disclosure button wrapper
  static const DisclosureButtonBuilder ripple = _ripple;
  static Widget _ripple(action, child) {
    return InkWell(
      onTap: action,
      child: child,
    );
  }

  /// Use [OutlinedButton] as disclosure button wrapper
  static const DisclosureButtonBuilder outlined = _outlined;
  static Widget _outlined(action, child) {
    return OutlinedButton(
      onPressed: action,
      child: child,
    );
  }

  /// Use [FilledButton] as disclosure button wrapper
  static const DisclosureButtonBuilder filled = _filled;
  static Widget _filled(action, child) {
    return FilledButton(
      onPressed: action,
      child: child,
    );
  }

  /// Use [FilledButton.tonal] as disclosure button wrapper
  static const DisclosureButtonBuilder tonal = _tonal;
  static Widget _tonal(action, child) {
    return FilledButton.tonal(
      onPressed: action,
      child: child,
    );
  }

  /// Use [TextButton] as disclosure button wrapper
  static const DisclosureButtonBuilder text = _text;
  static Widget _text(action, child) {
    return TextButton(
      onPressed: action,
      child: child,
    );
  }

  /// Use [IconButton] as disclosure button wrapper
  static const DisclosureButtonBuilder icon = _icon;
  static Widget _icon(action, child) {
    return IconButton(
      onPressed: action,
      icon: child,
    );
  }

  /// Use [IconButton.filled] as disclosure button wrapper
  static const DisclosureButtonBuilder iconFilled = _iconFilled;
  static Widget _iconFilled(action, child) {
    return IconButton.filled(
      onPressed: action,
      icon: child,
    );
  }

  /// Use [IconButton.filledTonal] as disclosure button wrapper
  static const DisclosureButtonBuilder iconTonal = _iconTonal;
  static Widget _iconTonal(action, child) {
    return IconButton.filledTonal(
      onPressed: action,
      icon: child,
    );
  }

  /// Use [IconButton.outlined] as disclosure button wrapper
  static const DisclosureButtonBuilder iconOutlined = _iconOutlined;
  static Widget _iconOutlined(action, child) {
    return IconButton.outlined(
      onPressed: action,
      icon: child,
    );
  }
}

/// A button that controls the disclosure state.
class DisclosureButton extends StatelessWidget {
  /// Create a disclosure button
  /// with toggle as default action
  /// and [InkWell] as default wrapper.
  const DisclosureButton({
    super.key,
    this.action = DisclosureButtonAction.toggle,
    this.wrapper = DisclosureButtonWrapper.ripple,
    this.padding = EdgeInsets.zero,
    required this.child,
  });

  /// Create a disclosure close button
  /// with [InkWell] as default wrapper
  const DisclosureButton.close({
    super.key,
    this.wrapper = DisclosureButtonWrapper.ripple,
    this.padding = EdgeInsets.zero,
    required this.child,
  }) : action = DisclosureButtonAction.close;

  /// Create a disclosure open button
  /// with [InkWell] as default wrapper
  const DisclosureButton.open({
    super.key,
    this.wrapper = DisclosureButtonWrapper.ripple,
    this.padding = EdgeInsets.zero,
    required this.child,
  }) : action = DisclosureButtonAction.open;

  /// Create a disclosure button with [GestureDetector] as wrapper.
  const DisclosureButton.basic({
    super.key,
    this.action = DisclosureButtonAction.toggle,
    this.padding = EdgeInsets.zero,
    required this.child,
  }) : wrapper = DisclosureButtonWrapper.basic;

  /// Create a disclosure button with [OutlinedButton] as wrapper.
  const DisclosureButton.outlined({
    super.key,
    this.action = DisclosureButtonAction.toggle,
    this.padding = EdgeInsets.zero,
    required this.child,
  }) : wrapper = DisclosureButtonWrapper.outlined;

  /// Create a disclosure button with [FilledButton] as wrapper.
  const DisclosureButton.filled({
    super.key,
    this.action = DisclosureButtonAction.toggle,
    this.padding = EdgeInsets.zero,
    required this.child,
  }) : wrapper = DisclosureButtonWrapper.filled;

  /// Create a disclosure button with [FilledButton.tonal] as wrapper.
  const DisclosureButton.tonal({
    super.key,
    this.action = DisclosureButtonAction.toggle,
    this.padding = EdgeInsets.zero,
    required this.child,
  }) : wrapper = DisclosureButtonWrapper.tonal;

  /// Create a disclosure button with [TextButton] as wrapper.
  const DisclosureButton.text({
    super.key,
    this.action = DisclosureButtonAction.toggle,
    this.padding = EdgeInsets.zero,
    required this.child,
  }) : wrapper = DisclosureButtonWrapper.text;

  /// Create a disclosure button with [IconButton] as wrapper.
  const DisclosureButton.icon({
    super.key,
    this.action = DisclosureButtonAction.toggle,
    this.padding = EdgeInsets.zero,
    required this.child,
  }) : wrapper = DisclosureButtonWrapper.icon;

  /// Create a disclosure button with [IconButton.filled] as wrapper.
  const DisclosureButton.iconFilled({
    super.key,
    this.action = DisclosureButtonAction.toggle,
    this.padding = EdgeInsets.zero,
    required this.child,
  }) : wrapper = DisclosureButtonWrapper.iconFilled;

  /// Create a disclosure button with [IconButton.filledTonal] as wrapper.
  const DisclosureButton.iconTonal({
    super.key,
    this.action = DisclosureButtonAction.toggle,
    this.padding = EdgeInsets.zero,
    required this.child,
  }) : wrapper = DisclosureButtonWrapper.iconTonal;

  /// Create a disclosure button with [IconButton.outlined] as wrapper.
  const DisclosureButton.iconOutlined({
    super.key,
    this.action = DisclosureButtonAction.toggle,
    this.padding = EdgeInsets.zero,
    required this.child,
  }) : wrapper = DisclosureButtonWrapper.iconOutlined;

  /// Determines button behavior based on the disclosure state
  final DisclosureButtonCallback action;

  /// Invoked to construct the button's container
  final DisclosureButtonBuilder wrapper;

  /// Specifies padding for the child, and secondary (if exists).
  final EdgeInsetsGeometry padding;

  /// The widget below this widget in the tree.
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return DisclosureConsumer(
      child: Padding(
        padding: padding,
        child: child,
      ),
      builder: (state, child) {
        child = AbsorbPointer(child: child);
        return wrapper(action(state), child);
      },
    );
  }
}
