import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../extensions/color_extension.dart';

class Gauge extends StatefulWidget {
  const Gauge({
    super.key,
    required this.color,
    required this.value,
    this.width = 100,
    this.height = 100,
    this.child,
    this.baseStrokeWidth = 4,
    this.valueStrokeWidth = 6,
    this.isShareable = false,
  }) : assert(
         value >= 0,
         'Value percentage must be equal to or greater than 0',
       );

  /// Parts per unit
  final double value;
  final Color color;
  final double width;
  final double height;
  final Widget? child;
  final double baseStrokeWidth;
  final double valueStrokeWidth;
  final bool isShareable;

  @override
  State<Gauge> createState() => _GaugeState();
}

class _GaugeState extends State<Gauge> with TickerProviderStateMixin {
  late final AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1600),
    );
    _animation =
        Tween<double>(
          begin: widget.isShareable ? widget.value : 0,
          end: widget.value,
        ).animate(_controller)..addListener(() {
          setState(() {});
        });
    if (widget.value > 0) _controller.forward();

    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final nonFractionalPart = _animation.value.truncate().toDouble();
    final fractionalPart = _animation.value - nonFractionalPart;

    return SizedBox(
      width: widget.width,
      height: widget.height,
      child: widget.value > 1
          ? _OverlappingGauge(
              nonFractionalPart: nonFractionalPart,
              color: widget.color,
              baseStrokeWidth: widget.baseStrokeWidth,
              valueStrokeWidth: widget.valueStrokeWidth,
              fractionalPart: fractionalPart,
              child: widget.child,
            )
          : widget.value <= 1
          ? CustomPaint(
              painter: GaugePainter(
                value: _animation.value,
                color: widget.value <= 1 ? widget.color : widget.color.darken(),
                baseStrokeWidth: widget.baseStrokeWidth,
                valueStrokeWidth: widget.valueStrokeWidth,
              ),
              child: Center(child: widget.child),
            )
          : CustomPaint(
              painter: _GaugeGradientPainter(
                value: _animation.value,
                colors: [
                  widget.color.darken(40),
                  widget.color,
                ],
                stops: [
                  0.0,
                  0.8,
                ],
                backgroundColor: widget.color,
                baseStrokeWidth: widget.baseStrokeWidth,
                valueStrokeWidth: widget.valueStrokeWidth,
              ),
              child: Center(child: widget.child),
            ),
    );
  }
}

class _OverlappingGauge extends StatelessWidget {
  final double nonFractionalPart;
  final Color color;
  final Widget? child;
  final double baseStrokeWidth;
  final double valueStrokeWidth;
  final double fractionalPart;

  const _OverlappingGauge({
    required this.nonFractionalPart,
    required this.fractionalPart,
    required this.baseStrokeWidth,
    required this.valueStrokeWidth,
    required this.color,
    this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: CustomPaint(
            painter: _GaugeGradientPainter(
              value: nonFractionalPart,
              stops: [
                fractionalPart,
                fractionalPart + 0.8,
              ],
              backgroundColor: color,
              colors: [
                color.darken(40),
                color,
              ],
              baseStrokeWidth: baseStrokeWidth,
              valueStrokeWidth: valueStrokeWidth,
            ),
          ),
        ),
        Positioned.fill(
          child: CustomPaint(
            key: const ValueKey('2'),
            painter: GaugePainter(
              value: fractionalPart,
              color: color,
              baseStrokeWidth: baseStrokeWidth,
              valueStrokeWidth: valueStrokeWidth,
            ),
            child: Center(child: child),
          ),
        ),
      ],
    );
  }
}

class GaugePainter extends CustomPainter {
  GaugePainter({
    required this.value,
    required this.color,
    this.baseStrokeWidth = 4,
    this.valueStrokeWidth = 6,
  });

  final double value;
  final Color color;
  final double baseStrokeWidth;
  final double valueStrokeWidth;

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final minSize = math.min(size.width, size.height);

    canvas.drawCircle(
      center,
      minSize / 2,
      Paint()
        ..style = PaintingStyle.stroke
        ..color = Colors
            .black // color.wOpacity(0.15)
        ..strokeWidth = baseStrokeWidth,
    );

    canvas.drawArc(
      Rect.fromCenter(center: center, width: minSize, height: minSize),
      -math.pi / 2,
      2 * math.pi * value,
      false,
      Paint()
        ..style = PaintingStyle.stroke
        ..strokeCap = StrokeCap.round
        ..color = color
        ..strokeWidth = valueStrokeWidth,
    );

    canvas.saveLayer(
      Rect.fromCenter(
        center: center,
        width: minSize + 6,
        height: minSize + 6,
      ),
      Paint(),
    );
    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

class _GaugeGradientPainter extends CustomPainter {
  final double value;
  final Color backgroundColor;
  final List<Color> colors;
  final List<double> stops;
  final double baseStrokeWidth;
  final double valueStrokeWidth;

  _GaugeGradientPainter({
    required this.value,
    required this.backgroundColor,
    required this.colors,
    this.baseStrokeWidth = 4,
    this.valueStrokeWidth = 6,
    this.stops = const [0.0, 0.1],
  }) : assert(
         colors.length >= 2,
         'At least two colors are required to create a gradient',
       );

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final minSize = math.min(size.width, size.height);

    // Gradient settings
    final gradient = SweepGradient(
      colors: colors,
      stops: stops,
      startAngle: value <= 1
          ? 3 * math.pi / 2
          : ((value - 1) * 2 * math.pi) + (3 * math.pi / 2),
      endAngle: value <= 1
          ? (7 * math.pi / 2)
          : ((value - 1) * 2 * math.pi) + (7 * math.pi / 2),
      tileMode: TileMode.repeated,
    );

    var scapSize = valueStrokeWidth / 2;
    double scapToDegree = scapSize / (minSize / 2);

    // Gradient Arc
    canvas.drawArc(
      Rect.fromCenter(center: center, width: minSize, height: minSize),
      -math.pi / 2 + scapToDegree,
      2 * math.pi * value - (2 * scapToDegree),
      false,
      Paint()
        ..style = PaintingStyle.stroke
        ..strokeCap = StrokeCap.round
        ..shader = gradient.createShader(
          Rect.fromCircle(center: center, radius: minSize / 2),
          textDirection: TextDirection.ltr,
        )
        ..strokeWidth = valueStrokeWidth,
    );

    canvas.saveLayer(
      Rect.fromCenter(center: center, width: minSize + 6, height: minSize + 6),
      Paint(),
    );

    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
