/* spell-checker: disable */
import 'package:flutter/material.dart';
import 'package:disclosure/disclosure.dart';
import 'package:wx_text/wx_text.dart';
import 'image.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Disclosure',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Wrapper(
      children: <Widget>[
        const Padding(
          padding: EdgeInsets.fromLTRB(0, 40, 0, 25),
          child: Center(
            child: WxText.displayMedium('Disclosure'),
          ),
        ),
        Example(
          title: 'Disclosure panel with scrollable content',
          child: Disclosure(
            wrapper: (state, child) {
              return Card.outlined(
                color: state.closed ? null : Colors.yellow.shade100,
                clipBehavior: Clip.antiAlias,
                shape: RoundedRectangleBorder(
                  side: BorderSide(
                    color: state.closed ? Colors.black26 : Colors.amber,
                    width: state.closed ? 1 : 2,
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
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
          ),
        ),
        const SizedBox(height: 20),
        Example(
          title: 'Disclosure group',
          child: Card.outlined(
            child: DisclosureGroup(
              multiple: false,
              clearable: true,
              padding: const EdgeInsets.all(15),
              children: List<Widget>.generate(3, (i) {
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
            ),
          ),
        ),
        const SizedBox(height: 20),
        Example(
          title: 'Disclosure tile',
          child: Card.filled(
            clipBehavior: Clip.hardEdge,
            child: DisclosureTheme.merge(
              icon: Icons.arrow_drop_down,
              wrapper: (state, child) {
                final side = BorderSide(
                  color: Colors.black26,
                  style: state.closed ? BorderStyle.none : BorderStyle.solid,
                );
                return AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  decoration: BoxDecoration(
                    border: Border(top: side, bottom: side),
                  ),
                  child: child,
                );
              },
              child: ListView(
                shrinkWrap: true,
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
                      DisclosureTile(
                        title: const Text('Nested Menu'),
                        children: [
                          DisclosureTile(
                            title: const Text('Menu Item'),
                            onTap: () {},
                          ),
                          DisclosureTile(
                            title: const Text('Menu Item'),
                            onTap: () {},
                          ),
                          DisclosureTile(
                            title: const Text('Menu Item'),
                            onTap: () {},
                          ),
                        ],
                      ),
                      DisclosureTile(
                        title: const Text('Menu Item'),
                        onTap: () {},
                      ),
                    ],
                  ),
                  DisclosureTile(
                    title: const Text('Menu Item'),
                    onTap: () {},
                  ),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(height: 20),
        Example(
          title: 'Complex implementation',
          child: Card(
            clipBehavior: Clip.hardEdge,
            child: Disclosure(
              secondary: const DisclosureButton.basic(
                child: PlatformImage(
                  'https://picsum.photos/500?image=1',
                  aspectRatio: 16 / 9,
                ),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  GridView(
                    shrinkWrap: true,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                    ),
                    children: const [
                      PlatformImage('https://picsum.photos/150?image=1'),
                      PlatformImage('https://picsum.photos/150?image=2'),
                      PlatformImage('https://picsum.photos/150?image=3'),
                      PlatformImage('https://picsum.photos/150?image=4'),
                      PlatformImage('https://picsum.photos/150?image=5'),
                      PlatformImage('https://picsum.photos/150?image=6'),
                    ],
                  ),
                  const Padding(
                    padding: EdgeInsets.all(15.0),
                    child: Text(
                      "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.",
                    ),
                  ),
                  const DisclosureButton(
                    wrapper: DisclosureButtonWrapper.outlined,
                    child: Text('Close'),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(height: 20),
        const Example(
          title: 'Spoiler text',
          child: Card.outlined(
            clipBehavior: Clip.hardEdge,
            child: Disclosure(
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
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 40),
      ],
    );
  }
}

class Wrapper extends StatelessWidget {
  const Wrapper({
    super.key,
    required this.children,
  });

  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(
              maxWidth: 450,
            ),
            child: SizedBox(
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: children,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class Example extends StatelessWidget {
  const Example({
    super.key,
    required this.title,
    required this.child,
  });

  final String title;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
          child: WxText.labelLarge(title),
        ),
        child,
      ],
    );
  }
}
