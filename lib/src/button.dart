import 'package:flutter/material.dart';
import 'controller.dart';

typedef DisclosureButtonCallback = VoidCallback Function(
  DisclosureController state,
);

typedef DisclosureButtonBuilder = Widget Function(
  BuildContext context,
  VoidCallback action,
  Widget child,
);

abstract class DisclosureButtonAction {
  static const DisclosureButtonCallback toggle = _toggle;
  static VoidCallback _toggle(DisclosureController state) => state.toggle;

  static const DisclosureButtonCallback open = _open;
  static VoidCallback _open(DisclosureController state) => state.open;

  static const DisclosureButtonCallback close = _close;
  static VoidCallback _close(DisclosureController state) => state.close;
}

abstract class DisclosureButtonWrapper {
  static const basic = _basic;
  static Widget _basic(
    BuildContext context,
    VoidCallback action,
    Widget child,
  ) {
    return GestureDetector(
      onTap: action,
      child: child,
    );
  }

  static const DisclosureButtonBuilder ripple = _ripple;
  static Widget _ripple(context, action, child) {
    return InkWell(
      onTap: action,
      child: child,
    );
  }

  static const DisclosureButtonBuilder outlined = _outlined;
  static Widget _outlined(context, action, child) {
    return OutlinedButton(
      onPressed: action,
      child: child,
    );
  }

  static const DisclosureButtonBuilder filled = _filled;
  static Widget _filled(context, action, child) {
    return FilledButton(
      onPressed: action,
      child: child,
    );
  }

  static const DisclosureButtonBuilder tonal = _tonal;
  static Widget _tonal(context, action, child) {
    return FilledButton.tonal(
      onPressed: action,
      child: child,
    );
  }

  static const DisclosureButtonBuilder text = _text;
  static Widget _text(context, action, child) {
    return TextButton(
      onPressed: action,
      child: child,
    );
  }

  static const DisclosureButtonBuilder icon = _icon;
  static Widget _icon(context, action, child) {
    return IconButton(
      onPressed: action,
      icon: child,
    );
  }

  static const DisclosureButtonBuilder iconFilled = _iconFilled;
  static Widget _iconFilled(context, action, child) {
    return IconButton.filled(
      onPressed: action,
      icon: child,
    );
  }

  static const DisclosureButtonBuilder iconTonal = _iconTonal;
  static Widget _iconTonal(context, action, child) {
    return IconButton.filledTonal(
      onPressed: action,
      icon: child,
    );
  }

  static const DisclosureButtonBuilder iconOutlined = _iconOutlined;
  static Widget _iconOutlined(context, action, child) {
    return IconButton.outlined(
      onPressed: action,
      icon: child,
    );
  }
}

class DisclosureButton extends StatelessWidget {
  const DisclosureButton({
    super.key,
    this.action = DisclosureButtonAction.toggle,
    this.wrapper = DisclosureButtonWrapper.ripple,
    required this.child,
  });

  const DisclosureButton.close({
    super.key,
    this.wrapper = DisclosureButtonWrapper.ripple,
    required this.child,
  }) : action = DisclosureButtonAction.close;

  const DisclosureButton.open({
    super.key,
    this.wrapper = DisclosureButtonWrapper.ripple,
    required this.child,
  }) : action = DisclosureButtonAction.open;

  const DisclosureButton.basic({
    super.key,
    this.action = DisclosureButtonAction.toggle,
    required this.child,
  }) : wrapper = DisclosureButtonWrapper.basic;

  const DisclosureButton.outlined({
    super.key,
    this.action = DisclosureButtonAction.toggle,
    required this.child,
  }) : wrapper = DisclosureButtonWrapper.outlined;

  const DisclosureButton.filled({
    super.key,
    this.action = DisclosureButtonAction.toggle,
    required this.child,
  }) : wrapper = DisclosureButtonWrapper.filled;

  const DisclosureButton.tonal({
    super.key,
    this.action = DisclosureButtonAction.toggle,
    required this.child,
  }) : wrapper = DisclosureButtonWrapper.tonal;

  const DisclosureButton.text({
    super.key,
    this.action = DisclosureButtonAction.toggle,
    required this.child,
  }) : wrapper = DisclosureButtonWrapper.text;

  const DisclosureButton.icon({
    super.key,
    this.action = DisclosureButtonAction.toggle,
    required this.child,
  }) : wrapper = DisclosureButtonWrapper.icon;

  const DisclosureButton.iconFilled({
    super.key,
    this.action = DisclosureButtonAction.toggle,
    required this.child,
  }) : wrapper = DisclosureButtonWrapper.iconFilled;

  const DisclosureButton.iconTonal({
    super.key,
    this.action = DisclosureButtonAction.toggle,
    required this.child,
  }) : wrapper = DisclosureButtonWrapper.iconTonal;

  const DisclosureButton.iconOutlined({
    super.key,
    this.action = DisclosureButtonAction.toggle,
    required this.child,
  }) : wrapper = DisclosureButtonWrapper.iconOutlined;

  final DisclosureButtonCallback action;
  final DisclosureButtonBuilder wrapper;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return DisclosureConsumer(
      child: child,
      builder: (context, state, child) {
        return wrapper(context, action(state), child!);
      },
    );
  }
}
