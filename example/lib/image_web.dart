import 'dart:ui_web';
import 'package:web/web.dart' as web;
import 'package:flutter/widgets.dart';

class PlatformImage extends StatelessWidget {
  const PlatformImage(
    this.url, {
    super.key,
    this.aspectRatio = 1,
  });

  final String url;
  final double aspectRatio;

  @override
  Widget build(BuildContext context) {
    // https://github.com/flutter/flutter/issues/41563
    // ignore: undefined_prefixed_name
    platformViewRegistry.registerViewFactory(
      url,
      (int _) => web.HTMLImageElement()
        ..src = url
        ..style.objectFit = 'cover',
    );
    return AspectRatio(
      aspectRatio: aspectRatio,
      child: HtmlElementView(viewType: url),
    );
  }
}
