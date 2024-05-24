import 'package:flutter/widgets.dart';
import 'controller.dart';
import 'types.dart';
import 'theme.dart';
import 'group.dart';

/// A versatile widget for creating accessible and visually appealing disclosures,
/// commonly used for accordion-style content.
class Disclosure extends StatelessWidget {
  /// Creates a Disclosure widget.
  ///
  /// * The `closed` property determines the initial state of the disclosure (open or closed).
  /// * The `onToggle` callback is invoked when the disclosure state changes.
  /// * The `onOpen` callback is invoked when the disclosure is opened.
  /// * The `onClose` callback is invoked when the disclosure is closed.
  /// * The `duration` property controls the animation duration for state changes.
  /// * The `curve` property controls the animation curve for state changes.
  /// * The `wrapper` property allows customization of the overall disclosure wrapper.
  /// * The `header` property defines the content that remains visible in the closed state.
  /// * The `divider` property displays a visual divider between the header and collapsible content.
  /// * The `secondary` property provides alternative content for the closed state.
  /// * The `child` property specifies the content that is hidden when closed and revealed when opened.
  const Disclosure({
    super.key,
    this.closed = true,
    this.onToggle,
    this.onOpen,
    this.onClose,
    this.duration,
    this.curve,
    this.insets,
    this.wrapper,
    this.header,
    this.divider,
    this.secondary,
    required this.child,
  });

  /// Whether the disclosure is initially closed.
  final bool closed;

  /// A callback that is invoked when the disclosure state changes.
  final ValueChanged<bool>? onToggle;

  /// A callback that is invoked when the disclosure is opened.
  final VoidCallback? onOpen;

  /// A callback that is invoked when the disclosure is closed.
  final VoidCallback? onClose;

  /// The duration over which to animate the disclosure state changes.
  final Duration? duration;

  /// The curve to apply when animating the disclosure state changes.
  final Curve? curve;

  /// Specifies padding for the child, and secondary (if exists).
  final EdgeInsetsGeometry? insets;

  /// A widget that wraps the entire disclosure content, allowing customization.
  final DisclosureWrapper? wrapper;

  /// The content that remains visible in the closed state.
  final Widget? header;

  /// A visual divider between the header and collapsible content.
  final Widget? divider;

  /// Alternative content for the closed state.
  final Widget? secondary;

  /// The content that is hidden when closed and revealed when opened.
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final theme = DisclosureTheme.of(context);
    final effectiveDuration = duration ?? theme.duration;
    final effectiveCurve = curve ?? theme.curve;
    final effectiveWrapper = wrapper ?? theme.wrapper;
    final effectiveInsets = insets ?? theme.insets;

    return DisclosureProvider(
      controller: DisclosureController(
        key: key,
        group: DisclosureGroup.maybeOf(context),
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
            firstChild: secondary != null
                ? Padding(
                    padding: effectiveInsets,
                    child: secondary,
                  )
                : Container(),
            secondChild: Padding(
              padding: effectiveInsets,
              child: child,
            ),
            crossFadeState: state.closed
                ? CrossFadeState.showFirst
                : CrossFadeState.showSecond,
            duration: effectiveDuration,
            sizeCurve: effectiveCurve,
            firstCurve: effectiveCurve,
            secondCurve: effectiveCurve,
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

          return effectiveWrapper(state, collapsible);
        },
      ),
    );
  }
}
