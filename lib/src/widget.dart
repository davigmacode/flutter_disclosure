import 'package:flutter/widgets.dart';
import 'controller.dart';

typedef DisclosureLayoutBuilder = AnimatedSwitcherLayoutBuilder;

typedef DisclosureTransitionBuilder = AnimatedSwitcherTransitionBuilder;

typedef DisclosureWrapper = Widget Function(
  DisclosureController state,
  Widget child,
);

/// Simplify building custom UIs with accessible controls
/// for showing and hiding content, like accordion panels.
class Disclosure extends StatelessWidget {
  /// Create a disclosure widget
  const Disclosure({
    super.key,
    this.closed = false,
    this.onToggle,
    this.onOpen,
    this.onClose,
    this.duration = defaultDuration,
    this.curve = defaultCurve,
    this.wrapper = Disclosure.defaultWrapper,
    this.header,
    this.divider,
    this.secondary,
    required this.child,
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
  final Duration duration;

  /// The curve to apply when animating the parameters of this widget.
  final Curve curve;

  final DisclosureWrapper wrapper;

  /// The header remains persistent, while the collapsible section displays underneath.
  final Widget? header;

  /// The widget displays a visual divider between the header and collapsible elements.
  ///
  /// If either the header or body element is collapsed or empty,
  /// the widget automatically hides itself.
  /// This prevents unnecessary visual clutter
  /// when there's no separation needed.
  final Widget? divider;

  /// Replacement content for closed state.
  final Widget? secondary;

  /// The widget displayed when the widget is opened. (Hidden when closed)
  final Widget child;

  static const defaultDuration = Duration(milliseconds: 200);
  static const defaultCurve = Curves.linear;

  static const defaultWrapper = _defaultWrapper;
  static Widget _defaultWrapper(DisclosureController state, Widget child) {
    return child;
  }

  @override
  Widget build(BuildContext context) {
    return DisclosureProvider(
      controller: DisclosureController(
        closed: closed,
        onToggle: onToggle,
        onOpen: onOpen,
        onClose: onClose,
      ),
      child: DisclosureConsumer(
        builder: (state, _) {
          final hasHeader = header != null;
          final hasChild = state.opened || secondary != null;
          final needDivider = hasHeader && hasChild;

          Widget collapsible = AnimatedCrossFade(
            firstChild: secondary ?? Container(),
            secondChild: child,
            crossFadeState: state.closed
                ? CrossFadeState.showFirst
                : CrossFadeState.showSecond,
            duration: duration,
            sizeCurve: curve,
            firstCurve: curve,
            secondCurve: curve,
          );

          if (hasHeader) {
            collapsible = Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                header,
                if (needDivider) divider,
                collapsible,
              ].whereType<Widget>().toList(growable: false),
            );
          }

          return wrapper(state, collapsible);
        },
      ),
    );
  }
}
