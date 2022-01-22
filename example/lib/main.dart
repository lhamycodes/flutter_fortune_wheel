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
  int selected = 0;

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
              onFling: (val) {
                if (val) {
                  // was flung right (i.e from left to right)
                  setState(() {
                    if (selected > 0 && selected <= items.length - 1) {
                      selected -= 1;
                    } else {
                      selected = items.length - 1;
                    }
                  });
                } else {
                  // was flung left (i.e from right to left)
                  setState(() {
                    if (selected < items.length - 1) {
                      selected += 1;
                    } else {
                      selected = 0;
                    }
                  });
                }
                print(selected);
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
