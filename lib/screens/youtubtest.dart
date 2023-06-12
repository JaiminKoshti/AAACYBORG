import 'package:flutter/material.dart';
import 'package:webviewtube/webviewtube.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Webviewtube',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const WebviewtubeDemo(),
    );
  }
}

class WebviewtubeDemo extends StatefulWidget {
  const WebviewtubeDemo({Key? key}) : super(key: key);

  @override
  State<WebviewtubeDemo> createState() => _WebviewtubeDemoState();
}

class _WebviewtubeDemoState extends State<WebviewtubeDemo> {
  final controller = WebviewtubeController();
  final options = const WebviewtubeOptions(
      forceHd: true, loop: true, interfaceLanguage: 'zh-Hant');

  @override
  void dispose() {
    // If a controller is passed to the player, remember to dispose it when
    // it's not in need.
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Webviewtube Demo'),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(vertical: 10),
        children: <Widget>[
          Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Default IFrame Player',
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
              ),
              WebviewtubePlayer(
                videoId: '4AoFA19gbLo',
                options: options,
                controller: controller,
              ),
            ],
          ),
          const SizedBox(height: 70),

        ],
      ),
    );
  }
}