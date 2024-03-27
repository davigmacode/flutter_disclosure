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
    ValueChanged<bool>? onChanged,
    VoidCallback? onOpened,
    VoidCallback? onClosed,
  })  : _closed = closed,
        _onChanged = onChanged,
        _onOpened = onOpened,
        _onClosed = onClosed;

  bool _closed;
  final ValueChanged<bool>? _onChanged;
  final VoidCallback? _onOpened;
  final VoidCallback? _onClosed;

  bool get closed => _closed;
  bool get opened => !closed;

  void assign(bool expanded) {
    if (_closed != expanded) {
      _closed = expanded;
      notifyListeners();
      _onChanged?.call(_closed);
    }
  }

  void toggle() {
    assign(!_closed);
  }

  void close() {
    assign(true);
    _onClosed?.call();
  }

  void open() {
    assign(false);
    _onOpened?.call();
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
