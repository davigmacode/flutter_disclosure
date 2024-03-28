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
  static const defaults = _defaults;
  static Widget _defaults(
    BuildContext context,
    VoidCallback action,
    Widget child,
  ) {
    return GestureDetector(
      onTap: action,
      child: child,
    );
  }

  static const inkWell = _inkWell;
  static DisclosureButtonBuilder _inkWell() {
    return (context, action, child) {
      return InkWell(
        onTap: action,
        child: child,
      );
    };
  }

  static const listTile = _listTile;
  static DisclosureButtonBuilder _listTile({
    Widget? leading,
    Widget? title,
    Widget? subtitle,
    Widget? trailing,
  }) {
    return (context, action, child) {
      return ListTile(
        onTap: action,
        title: title,
        subtitle: subtitle,
        leading: leading,
        trailing: trailing,
      );
    };
  }
}

class DisclosureButton extends StatelessWidget {
  const DisclosureButton({
    super.key,
    this.action = DisclosureButtonAction.toggle,
    this.wrapper = DisclosureButtonWrapper.defaults,
    required this.child,
  });

  const DisclosureButton.close({
    super.key,
    this.wrapper = DisclosureButtonWrapper.defaults,
    required this.child,
  }) : action = DisclosureButtonAction.close;

  const DisclosureButton.open({
    super.key,
    this.wrapper = DisclosureButtonWrapper.defaults,
    required this.child,
  }) : action = DisclosureButtonAction.open;

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

class DisclosureInkWell extends DisclosureButton {
  const DisclosureInkWell({
    super.key,
    super.action,
    required super.child,
  });

  const DisclosureInkWell.close({
    super.key,
    required super.child,
  }) : super.close();

  const DisclosureInkWell.open({
    super.key,
    required super.child,
  }) : super.open();

  @override
  DisclosureButtonBuilder get wrapper {
    return DisclosureButtonWrapper.inkWell();
  }
}
