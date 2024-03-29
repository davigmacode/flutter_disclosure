import 'package:flutter/widgets.dart';

typedef DisclosureBuilder = Widget Function(
  BuildContext context,
  DisclosureController state,
  Widget? child,
);

//--------------------------------------------------------

class DisclosureController extends ChangeNotifier {
  DisclosureController({
    required bool closed,
    ValueChanged<bool>? onToggle,
    VoidCallback? onOpen,
    VoidCallback? onClose,
  })  : _closed = closed,
        _onToggle = onToggle,
        _onOpen = onOpen,
        _onClose = onClose;

  bool _closed;
  final ValueChanged<bool>? _onToggle;
  final VoidCallback? _onOpen;
  final VoidCallback? _onClose;

  bool get closed => _closed;
  bool get opened => !closed;

  void assign(bool expanded) {
    if (_closed != expanded) {
      _closed = expanded;
      notifyListeners();
      _onToggle?.call(_closed);
    }
  }

  void toggle() {
    assign(!_closed);
  }

  void close() {
    assign(true);
    _onClose?.call();
  }

  void open() {
    assign(false);
    _onOpen?.call();
  }
}

//--------------------------------------------------------

class DisclosureProvider extends InheritedNotifier<DisclosureController> {
  const DisclosureProvider({
    super.key,
    required DisclosureController controller,
    required super.child,
  }) : super(notifier: controller);

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

  static DisclosureController of(BuildContext context) {
    final DisclosureProvider? result =
        context.dependOnInheritedWidgetOfExactType<DisclosureProvider>();
    assert(
        result != null, 'No Disclosure or DisclosureProvider found in context');
    return result!.notifier!;
  }
}

//--------------------------------------------------------

class DisclosureConsumer extends StatelessWidget {
  const DisclosureConsumer({
    super.key,
    required this.builder,
    this.child,
  });

  final Widget? child;

  /// Builder that gets called when the expansion changes
  final DisclosureBuilder builder;

  @override
  Widget build(BuildContext context) {
    return builder(context, DisclosureProvider.of(context), child);
  }
}
