/* spell-checker: disable */
import 'package:flutter/material.dart';
import 'package:disclosure/disclosure.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Disclosure Demo',
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
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: SizedBox(
            width: 400,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 40, 0, 25),
                  child: Center(
                    child: Text(
                      'Disclosure Demo',
                      style: Theme.of(context).textTheme.displayMedium,
                    ),
                  ),
                ),
                const Card.outlined(
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
                ),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.fromLTRB(10, 0, 0, 5),
                  child: Text(
                    'Complex Implementation',
                    style: Theme.of(context).textTheme.labelLarge,
                  ),
                ),
                Card(
                  clipBehavior: Clip.hardEdge,
                  child: Disclosure(
                    secondary: DisclosureButton.basic(
                      child: Image.network(
                        'https://picsum.photos/400?image=1',
                        fit: BoxFit.cover,
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
                        const DisclosureButton(
                          wrapper: DisclosureButtonWrapper.outlined,
                          child: Text('Close'),
                        ),
                        const SizedBox(height: 20),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.fromLTRB(10, 0, 0, 5),
                  child: Text(
                    'Spoiler text',
                    style: Theme.of(context).textTheme.labelLarge,
                  ),
                ),
                const Card(
                  clipBehavior: Clip.hardEdge,
                  child: Disclosure(
                    closed: true,
                    secondary: DisclosureButton(
                      child: Padding(
                        padding: EdgeInsets.all(10.0),
                        child: Text(
                          "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
                          ),
                          SizedBox(height: 10),
                          DisclosureButton.text(
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
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.fromLTRB(10, 0, 0, 5),
                  child: Text(
                    'Disclosure Menu',
                    style: Theme.of(context).textTheme.labelLarge,
                  ),
                ),
                Card.filled(
                  clipBehavior: Clip.hardEdge,
                  child: ListView(
                    shrinkWrap: true,
                    children: [
                      ListTile(
                        title: const Text('Menu Item'),
                        onTap: () {},
                      ),
                      DisclosureTile(
                        title: const Text('Nested Menu'),
                        children: [
                          ListTile(
                            title: const Text('Menu Item'),
                            onTap: () {},
                          ),
                          DisclosureTile(
                            title: const Text('Nested Menu'),
                            children: [
                              ListTile(
                                title: const Text('Menu Item'),
                                onTap: () {},
                              ),
                              ListTile(
                                title: const Text('Menu Item'),
                                onTap: () {},
                              ),
                              ListTile(
                                title: const Text('Menu Item'),
                                onTap: () {},
                              ),
                            ],
                          ),
                          ListTile(
                            title: const Text('Menu Item'),
                            onTap: () {},
                          ),
                        ],
                      ),
                      ListTile(
                        title: const Text('Menu Item'),
                        onTap: () {},
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 40),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
