import 'package:flutter/widgets.dart';

/// A controller for managing the state of a disclosure group.
class DisclosureGroupController extends ChangeNotifier {
  /// Creates a DisclosureGroupController instance.
  ///
  /// * The `value` property specifies the initial set of active disclosures.
  /// * The `onChanged` callback is invoked when the active disclosures change.
  /// * The `multiple` property determines whether multiple disclosures can be
  /// selected simultaneously.
  /// * The `clearable` property controls whether all disclosures can be cleared.
  DisclosureGroupController({
    List<Key> value = const [],
    ValueChanged<List<Key>>? onChanged,
    this.multiple = false,
    this.clearable = false,
  })  : _value = Set.from(value),
        _onChanged = onChanged;

  /// The current set of active disclosures.
  final Set<Key> _value;

  /// A callback that is invoked when the active disclosures change.
  final ValueChanged<List<Key>>? _onChanged;

  /// Whether multiple disclosures can be selected simultaneously.
  final bool multiple;

  /// Whether all disclosures can be cleared.
  final bool clearable;

  /// Returns the current set of active disclosures.
  List<Key> get value => _value.toList();

  /// Checks if a specific disclosure is active.
  bool has(Key value) => _value.contains(value);

  /// Selects or deselects a specific disclosure.
  ///
  /// * The `item` parameter specifies the disclosure to toggle.
  /// * The `onChanged` callback is invoked when the selection changes.
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

  /// Toggles the active state of a specific disclosure.
  ///
  /// * The `item` parameter specifies the disclosure to toggle.
  /// * The `active` parameter (optional) determines the new state.
  void toggle(Key item, [bool? active]) {
    active = active ?? !has(item);
    return active
        ? multiple
            ? add(item)
            : replace([item])
        : remove(item);
  }

  /// Adds a disclosure to the active set.
  ///
  /// * The `item` parameter specifies the disclosure to add.
  void add(Key item) {
    if (_value.add(item)) {
      notifyListeners();
      _onChanged?.call(value);
    }
  }

  /// Removes a disclosure from the active set.
  ///
  /// * The `item` parameter specifies the disclosure to remove.
  void remove(Key item) {
    if (!clearable && _value.length == 1) return;

    if (_value.remove(item)) {
      notifyListeners();
      _onChanged?.call(value);
    }
  }

  /// Replaces the active set of disclosures with a new set.
  ///
  /// * The `value` parameter specifies the new set of active disclosures.
  void replace(List<Key> value) {
    _value
      ..clear()
      ..addAll(value);
    notifyListeners();
    _onChanged?.call(value);
  }

  /// Clears all active disclosures.
  void clear() {
    _value.clear();
    notifyListeners();
    _onChanged?.call(value);
  }
}

/// An inherited widget that provides access to the [DisclosureGroupController].
class DisclosureGroupProvider
    extends InheritedNotifier<DisclosureGroupController> {
  /// Creates a DisclosureGroupProvider instance.
  ///
  /// * The `controller` parameter specifies the [DisclosureGroupController] to provide.
  /// * The `child` parameter specifies the widget that will receive the controller
  const DisclosureGroupProvider({
    super.key,
    required DisclosureGroupController controller,
    required super.child,
  }) : super(notifier: controller);

  /// Provides access to the [DisclosureGroupController]
  /// from the closest DisclosureGroupProvider instance.
  static DisclosureGroupController? maybeOf(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<DisclosureGroupProvider>()
        ?.notifier;
  }

  /// Provides access to the [DisclosureGroupController] from the closest
  /// DisclosureGroupProvider instance, asserting that it exists.
  static DisclosureGroupController of(BuildContext context) {
    final notifier = maybeOf(context);
    assert(notifier != null, 'No DisclosureGroup found in context');
    return notifier!;
  }
}

/// A widget that manages a group of disclosures
/// and provides a controller for state management.
class DisclosureGroup extends StatelessWidget {
  /// Creates a DisclosureGroup widget.
  ///
  /// * The `value` property specifies the initial set of active disclosures.
  /// * The `onChanged` callback is invoked when the active disclosures change.
  /// * The `multiple` property determines whether multiple disclosures can be
  /// selected simultaneously.
  /// * The `clearable` property controls whether all disclosures can be cleared.
  /// * The `padding` property sets the padding around the disclosure group's
  /// children.
  /// * The `children` property is a list of widgets that represent the disclosures.
  const DisclosureGroup({
    super.key,
    this.value = const [],
    this.onChanged,
    this.multiple = false,
    this.clearable = false,
    this.padding,
    required this.children,
  });

  /// The initial set of active disclosures.
  final List<Key> value;

  /// A callback that is invoked when the active disclosures change.
  final ValueChanged<List<Key>>? onChanged;

  /// Whether multiple disclosures can be selected simultaneously.
  final bool multiple;

  /// Whether all disclosures can be cleared.
  final bool clearable;

  /// The padding around the disclosure group's children.
  final EdgeInsetsGeometry? padding;

  /// The list of widgets that represent the disclosures.
  final List<Widget> children;

  /// Provides access to the [DisclosureGroupController] if available,
  /// otherwise returns null.
  static DisclosureGroupController? maybeOf(BuildContext context) {
    return DisclosureGroupProvider.maybeOf(context);
  }

  /// Provides access to the [DisclosureGroupController]
  /// from the closest DisclosureGroup instance.
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
