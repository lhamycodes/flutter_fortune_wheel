import 'package:flutter/material.dart';
import 'package:flutter_fortune_wheel/flutter_fortune_wheel.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:fortune_wheel_demo/common/common.dart';

class FortuneBarPage extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final selected = useState(0);
    final isAnimating = useState(false);

    void handleRoll() {
      selected.value = roll(
        fortuneValues.length,
        lastValue: selected.value,
      );
    }

    return Column(
      children: [
        SizedBox(height: 8),
        RollButtonWithPreview(
          selected: selected.value,
          items: fortuneValues,
          onPressed: isAnimating.value ? null : handleRoll,
        ),
        SizedBox(height: 8),
        Expanded(
          child: Center(
            child: FortuneBar(
              selected: selected.value,
              items: [
                for (var it in fortuneValues) FortuneItem(child: Text(it))
              ],
              onFling: (val) => handleRoll,
              onAnimationStart: () {
                isAnimating.value = true;
              },
              onAnimationEnd: () {
                isAnimating.value = false;
              },
            ),
          ),
        ),
      ],
    );
  }
}
