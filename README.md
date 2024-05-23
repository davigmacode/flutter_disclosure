[![Pub Version](https://img.shields.io/pub/v/disclosure)](https://pub.dev/packages/disclosure) ![GitHub](https://img.shields.io/github/license/davigmacode/flutter_disclosure) [![GitHub](https://badgen.net/badge/icon/buymeacoffee?icon=buymeacoffee&color=yellow&label)](https://www.buymeacoffee.com/davigmacode) [![GitHub](https://badgen.net/badge/icon/ko-fi?icon=kofi&color=red&label)](https://ko-fi.com/davigmacode)

Simplify building custom UIs with accessible controls for showing and hiding content, like accordion panels.

[![Preview](https://github.com/davigmacode/flutter_disclosure/raw/main/media/preview.gif)](https://davigmacode.github.io/flutter_disclosure)

[Demo](https://davigmacode.github.io/flutter_disclosure)

## Usage

To read more about classes and other references used by `disclosure`, see the [API Reference](https://pub.dev/documentation/disclosure/latest/).

### Import the package
```dart
import 'package:disclosure/disclosure.dart';
```

### Disclosure panel with scrollable content
```dart
/** spellchecker: disable */
Disclosure(
  wrapper: (state, child) {
    return Card.outlined(
      color: state.closed ? null : Colors.yellow.shade100,
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        side: BorderSide(
          color: state.closed ? Colors.black26 : Colors.amber,
          width: state.closed ? 1 : 2,
        ),
      ),
      borderRadius: BorderRadius.circular(10),
      child: child,
    );
  },
  header: const DisclosureButton(
    child: ListTile(
      title: Text('Disclosure Panel'),
      trailing: DisclosureIcon(),
    ),
  ),
  divider: const Divider(height: 1),
  child: const DisclosureView(
    maxHeight: 200,
    padding: EdgeInsets.all(15.0),
    child: Text(
      "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
    ),
  ),
)
```

### Grouped multiple disclosure
```dart
DisclosureGroup(
  multiple: false,
  clearable: true,
  padding: const EdgeInsets.all(15),
  children: List<Widget>.generate(5, (i) {
    return Disclosure(
      key: ValueKey('disclosure-$i'),
      wrapper: (state, child) {
        return Card.outlined(
          color: state.closed ? null : Colors.yellow.shade100,
          clipBehavior: Clip.antiAlias,
          shape: RoundedRectangleBorder(
            side: BorderSide(
              color: state.closed ? Colors.black26 : Colors.amber,
              width: state.closed ? 1 : 2,
            ),
          ),
          child: child,
        );
      },
      header: DisclosureButton(
        child: ListTile(
          title: Text('Disclosure Panel ${i + 1}'),
          trailing: const DisclosureIcon(),
        ),
      ),
      divider: const Divider(height: 1),
      child: const Padding(
        padding: EdgeInsets.all(15),
        child: Text(
          "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen.",
        ),
      ),
    );
  }),
)
```

### Disclosure tile for menus and lists
```dart
DisclosureTile(
  title: const Text('Nested Menu'),
  children: [
    DisclosureTile(
      title: const Text('Menu Item'),
      onTap: () {},
    ),
    DisclosureTile(
      title: const Text('Nested Menu'),
      children: [
        DisclosureTile(
          title: const Text('Menu Item'),
          onTap: () {},
        ),
      ],
    ),
  ],
),
```

### Complex implementation with secondary actions and grid layout
```dart
Disclosure(
  secondary: DisclosureButton.basic(
    child: Image.network(
      'https://picsum.photos/500?image=1',
      fit: BoxFit.cover,
    ),
  ),
  child: Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      GridView(
        shrinkWrap: true,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
        ),
        children: [
          Image.network('https://picsum.photos/150?image=1'),
          Image.network('https://picsum.photos/150?image=2'),
          Image.network('https://picsum.photos/150?image=3'),
          Image.network('https://picsum.photos/150?image=4'),
          Image.network('https://picsum.photos/150?image=5'),
          Image.network('https://picsum.photos/150?image=6'),
          Image.network('https://picsum.photos/150?image=7'),
          Image.network('https://picsum.photos/150?image=8'),
          Image.network('https://picsum.photos/150?image=9'),
        ],
      ),
      const Padding(
        padding: EdgeInsets.all(15.0),
        child: Text(
          "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
        ),
      ),
      DisclosureButton(
        wrapper: DisclosureButtonWrapper.outlined,
        child: Text('Close'),
      ),
      const SizedBox(height: 20),
    ],
  ),
)
```

### Spoiler text with limited visibility
```dart
Disclosure(
  closed: true,
  secondary: DisclosureButton(
    child: Padding(
      padding: EdgeInsets.all(20.0),
      child: Text(
        "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
      ),
    ),
  ),
  child: Padding(
    padding: EdgeInsets.all(20.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
        ),
        SizedBox(height: 20),
        DisclosureButton.tonal(
          child: Text(
            'Show less',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      ],
    ),
  ),
)
```

## Sponsoring

<a href="https://www.buymeacoffee.com/davigmacode" target="_blank"><img src="https://cdn.buymeacoffee.com/buttons/v2/default-yellow.png" alt="Buy Me A Coffee" height="45"></a>
<a href="https://ko-fi.com/davigmacode" target="_blank"><img src="https://storage.ko-fi.com/cdn/brandasset/kofi_s_tag_white.png" alt="Ko-Fi" height="45"></a>

If this package or any other package I created is helping you, please consider to sponsor me so that I can take time to read the issues, fix bugs, merge pull requests and add features to these packages.