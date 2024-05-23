import 'package:flutter/widgets.dart';

class DisclosureGroupController extends ChangeNotifier {
  DisclosureGroupController({
    List<Key> value = const [],
    ValueChanged<List<Key>>? onChanged,
    this.multiple = false,
    this.clearable = false,
  })  : _value = Set.from(value),
        _onChanged = onChanged;

  final Set<Key> _value;

  final ValueChanged<List<Key>>? _onChanged;

  /// allow to select multiple values
  final bool multiple;

  /// will always have a value
  final bool clearable;

  List<Key> get value => _value.toList();

  bool has(Key value) => _value.contains(value);

  ValueChanged<bool> select(
    Key item, {
    ValueChanged<bool>? onChanged,
  }) {
    return (bool active) {
      if (has(item) == active) return;
      toggle(item, active);
      onChanged?.call(active);
    };
  }

  /// Mutator to mark a [T] value as either active or inactive.
  void toggle(Key item, [bool? active]) {
    active = active ?? !has(item);
    return active
        ? multiple
            ? add(item)
            : replace([item])
        : remove(item);
  }

  /// Mutator to mark a [T] value as active.
  void add(Key item) {
    if (_value.add(item)) {
      notifyListeners();
      _onChanged?.call(value);
    }
  }

  /// Mutator to mark a [T] value as inactive.
  void remove(Key item) {
    if (!clearable && _value.length == 1) return;

    if (_value.remove(item)) {
      notifyListeners();
      _onChanged?.call(value);
    }
  }

  void replace(List<Key> value) {
    _value
      ..clear()
      ..addAll(value);
    notifyListeners();
    _onChanged?.call(value);
  }

  void clear() {
    _value.clear();
    notifyListeners();
    _onChanged?.call(value);
  }
}

/// An inherited widget for a [DisclosureController],
/// which updates its dependencies when the [notifier] is triggered
class DisclosureGroupProvider
    extends InheritedNotifier<DisclosureGroupController> {
  /// Creates a widget that provides [DisclosureController] to descendant.
  const DisclosureGroupProvider({
    super.key,
    required DisclosureGroupController controller,
    required super.child,
  }) : super(notifier: controller);

  /// The [DisclosureController] from the closest instance of
  /// this class that encloses the given context.
  static DisclosureGroupController? maybeOf(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<DisclosureGroupProvider>()
        ?.notifier;
  }

  /// The [DisclosureController] from the closest instance of
  /// this class that encloses the given context.
  static DisclosureGroupController of(BuildContext context) {
    final notifier = maybeOf(context);
    assert(notifier != null, 'No DisclosureGroup found in context');
    return notifier!;
  }
}

class DisclosureGroup extends StatelessWidget {
  const DisclosureGroup({
    super.key,
    this.value = const [],
    this.onChanged,
    this.multiple = false,
    this.clearable = false,
    this.padding,
    required this.children,
  });

  final List<Key> value;

  final ValueChanged<List<Key>>? onChanged;

  /// allow to select multiple values
  final bool multiple;

  /// will always have a value
  final bool clearable;

  final EdgeInsetsGeometry? padding;

  final List<Widget> children;

  /// The [DisclosureController] from the closest instance of
  /// this class that encloses the given context.
  static DisclosureGroupController? maybeOf(BuildContext context) {
    return DisclosureGroupProvider.maybeOf(context);
  }

  /// The [DisclosureController] from the closest instance of
  /// this class that encloses the given context.
  static DisclosureGroupController of(BuildContext context) {
    return DisclosureGroupProvider.of(context);
  }

  @override
  Widget build(BuildContext context) {
    return DisclosureGroupProvider(
      controller: DisclosureGroupController(
        value: value,
        onChanged: onChanged,
        multiple: multiple,
        clearable: clearable,
      ),
      child: ListView(
        shrinkWrap: true,
        padding: padding,
        children: children,
      ),
    );
  }
}
