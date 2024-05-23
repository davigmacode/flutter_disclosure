import 'package:flutter/widgets.dart';
import 'group.dart';

typedef DisclosureBuilder = Widget Function(
  DisclosureController state,
  Widget? child,
);

/// Controller of the disclosure state and how it behaves
class DisclosureController extends ChangeNotifier {
  /// Creates a DisclosureController instance.
  ///
  /// * The `key` property uniquely identifies the disclosure within a group.
  /// * The `group` property specifies the [DisclosureGroupController] to which the disclosure belongs.
  /// * The `closed` property determines the initial state of the disclosure.
  /// * The `onToggle` callback is invoked when the disclosure state changes.
  /// * The `onOpen` callback is invoked when the disclosure is opened.
  /// * The `onClose` callback is invoked when the disclosure is closed.
  DisclosureController({
    Key? key,
    DisclosureGroupController? group,
    required bool closed,
    ValueChanged<bool>? onToggle,
    VoidCallback? onOpen,
    VoidCallback? onClose,
  })  : _key = key,
        _closed = closed,
        _onToggle = onToggle,
        _onOpen = onOpen,
        _onClose = onClose,
        assert(
          group == null || key != null,
          'Grouped disclosure should have key',
        ) {
    _group = group?..addListener(() => notifyListeners());
  }

  final Key? _key;
  late final DisclosureGroupController? _group;
  bool get grouped => _group != null;

  bool _closed;
  final ValueChanged<bool>? _onToggle;
  final VoidCallback? _onOpen;
  final VoidCallback? _onClose;

  /// Whether the disclosure is currently closed.
  bool get closed => grouped ? !_group!.has(_key!) : _closed;

  /// Whether the disclosure is currently opened.
  bool get opened => !closed;

  /// Set the disclosure state to new value
  /// and notify its listeners.
  void assign(bool value) {
    if (closed != value) {
      if (grouped) {
        _group!.toggle(_key!, !value);
      } else {
        _closed = value;
      }
      notifyListeners();
      _onToggle?.call(closed);
    }
  }

  /// Inverts the disclosure state (open/closed)
  void toggle() {
    assign(!closed);
  }

  /// Set the disclosure state to closed
  void close() {
    assign(true);
    _onClose?.call();
  }

  /// Set the disclosure state to opened
  void open() {
    assign(false);
    _onOpen?.call();
  }
}

/// An inherited widget for a [DisclosureController],
/// which updates its dependencies when the [notifier] is triggered
class DisclosureProvider extends InheritedNotifier<DisclosureController> {
  /// Creates a widget that provides [DisclosureController] to descendant.
  const DisclosureProvider({
    super.key,
    required DisclosureController controller,
    required super.child,
  }) : super(notifier: controller);

  /// Create a disclosure provider using widget builder
  DisclosureProvider.builder({
    super.key,
    required DisclosureController controller,
    required DisclosureBuilder builder,
    Widget? child,
  }) : super(
          child: DisclosureConsumer(
            builder: builder,
            child: child,
          ),
        );

  /// Provides access to the [DisclosureController]
  /// from the closest DisclosureProvider instance.
  static DisclosureController? maybeOf(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<DisclosureProvider>()
        ?.notifier;
  }

  /// Provides access to the [DisclosureController] from the closest
  /// DisclosureProvider instance, asserting that it exists.
  static DisclosureController of(BuildContext context) {
    final notifier = maybeOf(context);
    assert(notifier != null,
        'No Disclosure or DisclosureProvider found in context');
    return notifier!;
  }
}

/// A widget that consumes [DisclosureController] from the closest instance.
class DisclosureConsumer extends StatelessWidget {
  /// Create a disclosure consumer widget
  const DisclosureConsumer({
    super.key,
    required this.builder,
    this.child,
  });

  /// The widget below this widget in the tree.
  final Widget? child;

  /// Builder that gets called when the disclosure changes.
  final DisclosureBuilder builder;

  @override
  Widget build(BuildContext context) {
    return builder(DisclosureProvider.of(context), child);
  }
}
