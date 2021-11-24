import 'package:flutter/material.dart';
import 'package:fortune_wheel_demo/pages/wheel.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Fortune Wheel Demo'),
      ),
      body: FortuneWheelPage(),
    );
  }
}
