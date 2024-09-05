import 'package:flutter/material.dart';

class CustomUnderlineTabIndicator extends Decoration {
  final BorderSide borderSide;
  final EdgeInsetsGeometry insets;
  final BorderRadius borderRadius;

  const CustomUnderlineTabIndicator({
    this.borderSide = const BorderSide(width: 2.0, color: Colors.blue),
    this.insets = EdgeInsets.zero,
    this.borderRadius = BorderRadius.zero,
  });

  @override
  BoxPainter createBoxPainter([VoidCallback? onChanged]) {
    return _CustomUnderlinePainter(this, onChanged);
  }
}

class _CustomUnderlinePainter extends BoxPainter {
  final CustomUnderlineTabIndicator decoration;

  _CustomUnderlinePainter(this.decoration, VoidCallback? onChanged)
      : super(onChanged);

  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration configuration) {
    assert(configuration.size != null);

    final Rect rect = Offset(
      offset.dx + decoration.insets.resolve(TextDirection.ltr).left,
      offset.dy + configuration.size!.height - decoration.borderSide.width,
    ) &
    Size(
      configuration.size!.width - decoration.insets.horizontal,
      decoration.borderSide.width,
    );

    final Paint paint = decoration.borderSide.toPaint();
    final RRect rrect = RRect.fromRectAndCorners(
      rect,
      topLeft: decoration.borderRadius.topLeft,
      topRight: decoration.borderRadius.topRight,
    );

    canvas.drawRRect(rrect, paint);
  }
}