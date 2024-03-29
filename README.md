[![Pub Version](https://img.shields.io/pub/v/disclosure)](https://pub.dev/packages/disclosure) ![GitHub](https://img.shields.io/github/license/davigmacode/flutter_disclosure) [![GitHub](https://badgen.net/badge/icon/buymeacoffee?icon=buymeacoffee&color=yellow&label)](https://www.buymeacoffee.com/davigmacode) [![GitHub](https://badgen.net/badge/icon/ko-fi?icon=kofi&color=red&label)](https://ko-fi.com/davigmacode)

Simplify building custom UIs with accessible controls for showing and hiding content, like accordion panels.

[![Preview](https://github.com/davigmacode/flutter_disclosure/raw/main/media/preview.gif)](https://davigmacode.github.io/flutter_disclosure)

[Demo](https://davigmacode.github.io/flutter_disclosure)

## Usage

To read more about classes and other references used by `disclosure`, see the [API Reference](https://pub.dev/documentation/disclosure/latest/).

```dart
/** spellchecker: disable */
Card.outlined(
  clipBehavior: Clip.hardEdge,
  child: Disclosure(
    header: DisclosureButton(
      child: ListTile(
        title: Text('Disclosure Panel'),
        trailing: DisclosureIcon(),
      ),
    ),
    divider: Divider(height: 1),
    child: DisclosureView(
      maxHeight: 200,
      padding: EdgeInsets.all(15.0),
      child: Text(
        "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
      ),
    ),
  ),
)
```

## Sponsoring

<a href="https://www.buymeacoffee.com/davigmacode" target="_blank"><img src="https://cdn.buymeacoffee.com/buttons/v2/default-yellow.png" alt="Buy Me A Coffee" height="45"></a>
<a href="https://ko-fi.com/davigmacode" target="_blank"><img src="https://storage.ko-fi.com/cdn/brandasset/kofi_s_tag_white.png" alt="Ko-Fi" height="45"></a>

If this package or any other package I created is helping you, please consider to sponsor me so that I can take time to read the issues, fix bugs, merge pull requests and add features to these packages.