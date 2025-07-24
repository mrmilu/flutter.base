import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../../utils/extensions/color_extension.dart';
import '../../utils/styles/colors.dart';

class EnteAnimWidget extends StatefulWidget {
  const EnteAnimWidget({super.key, this.height = 200});
  final double height;

  @override
  State<EnteAnimWidget> createState() => _EnteAnimWidgetState();
}

class _EnteAnimWidgetState extends State<EnteAnimWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  late Offset blueOrbitCenter;
  late Offset greenOrbitCenter;

  @override
  void initState() {
    super.initState();

    // Inicializar centros de las órbitas
    blueOrbitCenter = Offset.zero;
    greenOrbitCenter = Offset.zero;

    // Configurar el controlador de animación
    _controller = AnimationController(
      duration: const Duration(seconds: 5), // Duración del ciclo
      vsync: this,
    )..repeat(); // Repetir en bucle

    // Crear una animación que va de 0 a 1
    _animation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _controller, curve: Curves.linear),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.height,
      child: AnimatedBuilder(
        animation: _animation,
        builder: (context, child) {
          return CustomPaint(
            painter: GradientCirclesPainter(
              animationValue: _animation.value,
              blueOrbitCenter: blueOrbitCenter,
              greenOrbitCenter: greenOrbitCenter,
              circleRadius: widget.height / 2,
              onSizeChanged: (size) {
                // Ajustar los centros de las órbitas al tamaño del lienzo
                if (blueOrbitCenter == Offset.zero) {
                  blueOrbitCenter = Offset(
                    size.width / 2 - 20,
                    size.height / 2 + 0,
                  );
                  greenOrbitCenter = Offset(
                    size.width / 2 + 20,
                    size.height / 2 - 20,
                  );
                }
              },
            ),
            size: Size.infinite,
          );
        },
      ),
    );
  }
}

class GradientCirclesPainter extends CustomPainter {
  final double animationValue;
  final Offset blueOrbitCenter;
  final Offset greenOrbitCenter;
  final Function(Size) onSizeChanged;
  final double circleRadius;

  GradientCirclesPainter({
    required this.animationValue,
    required this.blueOrbitCenter,
    required this.greenOrbitCenter,
    required this.onSizeChanged,
    this.circleRadius = 100,
  });

  @override
  void paint(Canvas canvas, Size size) {
    // Notificar el tamaño al estado para ajustar los centros de las órbitas
    onSizeChanged(size);

    // Definir los gradientes
    final blueGradient =
        RadialGradient(
          colors: [
            AppColors.primaryAzulSuave.wOpacity(0.8),
            AppColors.primaryAzulClaro.wOpacity(0.0),
          ],
          stops: [0.0, 1.0],
        ).createShader(
          Rect.fromCircle(
            center: Offset.zero,
            radius: circleRadius,
          ),
        );

    final greenGradient =
        RadialGradient(
          colors: [
            AppColors.primaryVerdeAzulado.wOpacity(0.8),
            AppColors.primaryVerdeMedio.wOpacity(0.0),
          ],
          stops: [0.0, 1.0],
        ).createShader(
          Rect.fromCircle(
            center: Offset.zero,
            radius: circleRadius + 10,
          ),
        );

    // Definir parámetros del movimiento circular
    const blueOrbitRadius = 15.0; // Radio pequeño para un movimiento leve
    const greenOrbitRadius = 15.0;
    const blueOrbitSpeed = 1.0; // 1 ciclo completo por animación
    const greenOrbitSpeed = -1.0; // 1 ciclo completo en dirección opuesta

    // Calcular ángulos para un movimiento cíclico exacto
    final blueAngle = animationValue * 2 * math.pi * blueOrbitSpeed;
    final greenAngle = animationValue * 2 * math.pi * greenOrbitSpeed;

    final bluePosition = Offset(
      blueOrbitCenter.dx + blueOrbitRadius * math.cos(blueAngle),
      blueOrbitCenter.dy + blueOrbitRadius * math.sin(blueAngle),
    );

    final greenPosition = Offset(
      greenOrbitCenter.dx + greenOrbitRadius * math.cos(greenAngle),
      greenOrbitCenter.dy + greenOrbitRadius * math.sin(greenAngle),
    );

    // Círculo azul
    final bluePaint = Paint()..shader = blueGradient;
    canvas.save();
    canvas.translate(bluePosition.dx, bluePosition.dy);
    canvas.drawCircle(Offset.zero, 100, bluePaint);
    canvas.restore();

    // Círculo verde
    final greenPaint = Paint()..shader = greenGradient;
    canvas.save();
    canvas.translate(greenPosition.dx, greenPosition.dy);
    canvas.drawCircle(Offset.zero, 100, greenPaint);
    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
