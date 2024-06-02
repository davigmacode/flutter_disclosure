import 'package:flutter/widgets.dart';
import 'controller.dart';

/// A widget that switches between two child widgets based on a state value
/// from a [DisclosureController].
///
/// This widget uses an [AnimatedSwitcher] to animate the transition between
/// the two child widgets. The `closed` and `opened` properties specify the
/// widgets to display when the disclosure is closed and opened, respectively.
///
/// The `duration` property controls the duration of the animation. The
/// `curve` property controls the animation curve. The `transition` property
/// is a builder function that can be used to customize the animation between
/// the two child widgets. The `layout` property is a builder function that
/// can be used to customize the layout of the child widgets during the
/// animation.
class DisclosureSwitcher extends StatelessWidget {
  /// Creates a DisclosureSwitcher.
  ///
  /// * `closed`: The widget to display when the disclosure is closed.
  /// * `opened`: The widget to display when the disclosure is opened.
  /// * `duration`: The duration of the animation between the two child widgets.
  ///   Defaults to [Duration.zero].
  /// * `curve`: The curve of the animation. Defaults to [Curves.linear].
  /// * `transition`: The builder function used to customize the animation
  ///   between the two child widgets. Defaults to
  ///   [AnimatedSwitcher.defaultTransitionBuilder].
  /// * `layout`: The builder function used to customize the layout of the
  ///   child widgets during the animation. Defaults to
  ///   [AnimatedSwitcher.defaultLayoutBuilder].
  const DisclosureSwitcher({
    super.key,
    this.closed,
    this.opened,
    this.duration = Duration.zero,
    this.curve = Curves.linear,
    this.transition = defaultTransitionBuilder,
    this.layout = defaultLayoutBuilder,
  });

  /// The widget to display when the disclosure is closed.
  final Widget? closed;

  /// The widget to display when the disclosure is opened.
  final Widget? opened;

  /// The duration of the animation between the two child widgets.
  final Duration duration;

  /// The curve of the animation.
  final Curve curve;

  /// The builder function used to customize the animation between the two
  /// child widgets.
  final AnimatedSwitcherTransitionBuilder transition;

  /// The builder function used to customize the layout of the child widgets
  /// during the animation.
  final AnimatedSwitcherLayoutBuilder layout;

  /// The default transition builder.
  static const defaultTransitionBuilder =
      AnimatedSwitcher.defaultTransitionBuilder;

  /// The default layout builder.
  static const defaultLayoutBuilder = AnimatedSwitcher.defaultLayoutBuilder;

  Widget? _withKey(String key, Widget? child) {
    return child != null
        ? KeyedSubtree(
            key: ValueKey(key),
            child: child,
          )
        : null;
  }

  @override
  Widget build(BuildContext context) {
    return DisclosureConsumer(
      builder: (state, child) {
        return AnimatedSwitcher(
          duration: duration,
          reverseDuration: duration,
          switchInCurve: curve,
          switchOutCurve: curve,
          transitionBuilder: transition,
          layoutBuilder: layout,
          child: state.closed
              ? _withKey('closed', closed)
              : _withKey('opened', opened),
        );
      },
    );
  }
}
