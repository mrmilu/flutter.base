import 'package:flutter/material.dart';

import '../../utils/extensions/color_extension.dart';

class EnteWidget extends StatelessWidget {
  const EnteWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: double.infinity,
      child: CustomPaint(
        painter: CircleGradientPainter(),
      ),
    );
  }
}

class CircleGradientPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width * 0.4;

    final gradient = const RadialGradient(
      center: Alignment.center,
      radius: 0.8,
      colors: [
        Color(0xFF8AFFC1),
        Color(0xFF4AC8E0),
      ],
      stops: [0.0, 1.0],
    );

    final paint = Paint()
      ..shader = gradient.createShader(
        Rect.fromCircle(center: center, radius: radius),
      )
      ..style = PaintingStyle.fill
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 10.0);

    // Dibujar una sombra
    final shadowPaint = Paint()
      ..color = Colors.black.wOpacity(0.3)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 10.0);

    canvas.drawCircle(
      Offset(center.dx - 10, center.dy + 30),
      radius - 10,
      shadowPaint,
    );
    canvas.drawCircle(center, radius, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
