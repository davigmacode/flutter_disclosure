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
    return AspectRatio(
      aspectRatio: aspectRatio,
      child: Image.network(url, fit: BoxFit.cover),
    );
  }
}
