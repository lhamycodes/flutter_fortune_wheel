import 'package:flutter/material.dart';
import 'package:flutter_fortune_wheel/flutter_fortune_wheel.dart';

void main() {
  runApp(ExampleApp());
}

class ExampleApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fortune Wheel Example',
      home: ExamplePage(),
    );
  }
}

class ExamplePage extends StatefulWidget {
  @override
  _ExamplePageState createState() => _ExamplePageState();
}

class _ExamplePageState extends State<ExamplePage> {
  int selected = 4;

  final items = <String>[
    'Grogu',
    'Mace Windu',
    'Obi-Wan Kenobi',
    'Han Solo',
    'Luke Skywalker',
    'Darth Vader',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter Fortune Wheel'),
      ),
      body: Column(
        children: [
          Expanded(
            child: FortuneWheel(
              selected: selected,
              animateFirst: false,
              rotationCount: 0,
              onFling: () {
                setState(() {
                  if (selected < items.length - 1) {
                    selected += 1;
                  } else {
                    selected = 0;
                  }
                });
              },
              items: [
                for (var i = 0; i < items.length; i++) ...[
                  FortuneItem(
                    child: Text(items[i]),
                    onTap: () {
                      setState(() {
                        selected = i;
                      });

                      print("Tapped IT ${items[i]}");
                    },
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}
