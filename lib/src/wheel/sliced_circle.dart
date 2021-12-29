part of 'wheel.dart';

class _SlicedCircle extends StatelessWidget {
  final List<FortuneItem> items;
  final StyleStrategy? styleStrategy;

  const _SlicedCircle({
    Key? key,
    required this.items,
    this.styleStrategy,
  })  : assert(items != null && items.length > 1),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    final anglePerChild = 2 * Math.pi / items.length;

    return LayoutBuilder(builder: (context, constraints) {
      final smallerSide = getSmallerSide(constraints);
      final offsetX = Directionality.of(context) == TextDirection.ltr
          ? constraints.maxWidth / 2
          : 0.0;

      return Transform.translate(
        offset: Offset(offsetX, constraints.maxHeight / 2),
        child: Stack(
          children: items.asMap().keys.map((index) {
            final theme = Theme.of(context);
            final style = items[index].style ??
                styleStrategy!.getItemStyle(theme, index, items.length);

            final childAngle = anglePerChild * index;
            // first slice starts at 90 degrees, if 0 degrees is at the top.
            // The angle offset puts the center of the first slice at the top.
            final angleOffset = -(Math.pi / 2 + anglePerChild / 2);

            return Transform.rotate(
              alignment: Alignment.topLeft,
              angle: childAngle + angleOffset,
              child: _CircleSliceLayout(
                handler: items[index],
                child: DefaultTextStyle(
                  textAlign: style.textAlign,
                  style: style.textStyle,
                  child: items[index].child,
                ),
                slice: _CircleSlice(
                  radius: smallerSide / 2,
                  angle: 2 * Math.pi / items.length,
                  fillColor: style.color,
                  strokeColor: style.borderColor,
                  strokeWidth: style.borderWidth,
                ),
              ),
            );
          }).toList(),
        ),
      );
    });
  }
}

class _TransformedCircleSlice extends StatelessWidget {
  final TransformedFortuneItem item;
  final StyleStrategy styleStrategy;
  final _WheelData wheelData;
  final int index;

  const _TransformedCircleSlice({
    Key? key,
    required this.item,
    required this.styleStrategy,
    required this.index,
    required this.wheelData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final style = item.style ??
        styleStrategy.getItemStyle(theme, index, wheelData.itemCount);

    return _CircleSliceLayout(
      handler: item,
      child: DefaultTextStyle(
        textAlign: style.textAlign,
        style: style.textStyle,
        child: item.child,
      ),
      slice: _CircleSlice(
        radius: wheelData.radius,
        angle: wheelData.itemAngle,
        fillColor: style.color,
        strokeColor: style.borderColor,
        strokeWidth: style.borderWidth,
      ),
    );
  }
}

class _CircleSlices extends StatelessWidget {
  final List<TransformedFortuneItem> items;
  final StyleStrategy styleStrategy;
  final _WheelData wheelData;

  const _CircleSlices({
    Key? key,
    required this.items,
    required this.styleStrategy,
    required this.wheelData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final slices = [
      for (var i = 0; i < items.length; i++)
        Transform.translate(
          offset: items[i].offset,
          child: Transform.rotate(
            alignment: Alignment.topLeft,
            angle: items[i].angle,
            child: _TransformedCircleSlice(
              item: items[i],
              styleStrategy: styleStrategy,
              index: i,
              wheelData: wheelData,
            ),
          ),
        ),
    ];

    return Stack(
      children: slices,
    );
  }
}
