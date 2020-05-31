import 'package:flutter/cupertino.dart';

class CircleTabIndicator extends Decoration {
  final BoxPainter _painter;

  CircleTabIndicator({@required Color color, @required double radius})
      : _painter = _CirclePainter(color, radius);

  @override
  BoxPainter createBoxPainter([onChanged]) => _painter;
}

class _CirclePainter extends BoxPainter {
  final Paint _paint;
  final double radius;

  _CirclePainter(Color color, this.radius)
      : _paint = Paint()
          ..color = color
          ..isAntiAlias = true
          ..strokeWidth = radius;

  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration cfg) {
    final Offset circleOffset =
        offset + Offset(cfg.size.width / 1.6, cfg.size.height - radius - 5);
    canvas.drawCircle(circleOffset, radius, _paint);

    final p1 =
        offset + Offset(cfg.size.width / 2.8, cfg.size.height - radius - 5);
    final p2 =
        offset + Offset(cfg.size.width / 2, cfg.size.height - radius - 5);
    canvas.drawLine(p1, p2, _paint);
  }
}
