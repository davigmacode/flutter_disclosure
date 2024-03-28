import 'package:flutter/widgets.dart';
import 'controller.dart';
import 'transition.dart';
import 'layout.dart';

/// Simplify building custom UIs with accessible controls
/// for showing and hiding content, like accordion panels.
class Disclosure extends StatelessWidget {
  /// Create a disclosure widget
  const Disclosure({
    super.key,
    this.closed = false,
    this.onChanged,
    this.onOpened,
    this.onClosed,
    this.duration = defaultDuration,
    this.curve = defaultCurve,
    this.transitionBuilder = DisclosureTransition.crossFade,
    this.layoutBuilder = DisclosureLayout.defaults,
    this.header,
    this.divider,
    this.secondary,
    required this.child,
  });

  final bool closed;
  final ValueChanged<bool>? onChanged;
  final VoidCallback? onOpened;
  final VoidCallback? onClosed;
  final Duration duration;
  final Curve curve;

  /// A function that wraps a new [content] with an animation that transitions the [content] in when the animation runs in the forward direction and out when the animation runs in the reverse direction. This is only called when a new [content] is set (not for each build), or when a new [transitionBuilder] is set. If a new [transitionBuilder] is set, then the transition is rebuilt for the current content and all previous children using the new [transitionBuilder]. The function must not return null.
  final DisclosureTransitionBuilder? transitionBuilder;

  /// A function that wraps all of the children that are transitioning out, and the [child] that's transitioning in, with a widget that lays all of them out. This is called every time this widget is built. The function must not return null.
  final DisclosureLayoutBuilder layoutBuilder;

  /// The header remains persistent, while the collapsible section displays underneath.
  final Widget? header;
  final Widget? divider;
  final Widget? secondary;
  final Widget child;

  static const defaultDuration = Duration(milliseconds: 200);
  static const defaultCurve = Curves.linear;

  @override
  Widget build(BuildContext context) {
    return DisclosureProvider(
      controller: DisclosureController(
        closed: closed,
        onChanged: onChanged,
        onOpened: onOpened,
        onClosed: onClosed,
      ),
      child: DisclosureConsumer(
        builder: (context, state, _) {
          final hasChild = state.opened || secondary != null;
          final needDivider = header != null && hasChild;
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              header,
              if (needDivider) divider,
              transitionBuilder != null
                  ? AnimatedSwitcher(
                      duration: duration,
                      switchInCurve: curve,
                      switchOutCurve: curve,
                      transitionBuilder: transitionBuilder!,
                      layoutBuilder: layoutBuilder,
                      child: state.closed
                          ? (secondary ?? const SizedBox.shrink())
                          : child,
                    )
                  : AnimatedCrossFade(
                      firstChild: secondary ??
                          ConstrainedBox(
                            constraints: const BoxConstraints.expand(),
                          ),
                      secondChild: child,
                      crossFadeState: state.closed
                          ? CrossFadeState.showFirst
                          : CrossFadeState.showSecond,
                      duration: duration,
                      sizeCurve: curve,
                      firstCurve: curve,
                      secondCurve: curve,
                    ),
            ].whereType<Widget>().toList(growable: false),
          );
        },
      ),
    );
  }
}
