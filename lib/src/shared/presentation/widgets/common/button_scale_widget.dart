import 'dart:async';

import 'package:flutter/material.dart';

/// Widget que proporciona un efecto de escala al tocar un botón
///
/// Cuando el usuario toca el widget, se reduce al [percentScale] especificado
/// y luego regresa a su tamaño original con una animación suave.
///
/// **Nota importante:** Si [percentScale] es igual a 1.0, no se ejecutará
/// ninguna animación para evitar errores, ya que no habría cambio de escala.
///
/// Ejemplo de uso:
/// ```dart
/// ButtonScaleWidget(
///   percentScale: 0.95, // Se reduce al 95% del tamaño original
///   onTap: () => print('Botón presionado'),
///   child: Container(
///     padding: EdgeInsets.all(16),
///     child: Text('Presióname'),
///   ),
/// )
/// ```
class ButtonScaleWidget extends StatefulWidget {
  const ButtonScaleWidget({
    super.key,
    required this.onTap,
    required this.child,
    this.percentScale = 0.96,
    this.alignment = Alignment.center,
  }) : assert(
         percentScale > 0.0 && percentScale <= 1.0,
         'percentScale debe estar entre 0.0 y 1.0',
       );

  /// Callback que se ejecuta cuando se toca el widget
  final VoidCallback? onTap;

  /// Widget hijo que se mostrará con el efecto de escala
  final Widget child;

  /// Escala a la que se reduce el widget al tocarlo (0.0 - 1.0)
  ///
  /// - 0.95 = se reduce al 95% del tamaño original
  /// - 1.0 = sin efecto de escala (desactiva la animación)
  /// - Valores menores crean efectos más dramáticos
  final double percentScale;

  /// Alineación del efecto de transformación
  final Alignment alignment;

  @override
  State<ButtonScaleWidget> createState() => _ButtonScaleWidgetState();
}

class _ButtonScaleWidgetState extends State<ButtonScaleWidget>
    with SingleTickerProviderStateMixin {
  double squareScaleA = 1;
  late AnimationController _controllerA;

  /// Si percentScale es 1, no hay animación
  bool get _shouldAnimate => widget.percentScale < 1.0;

  @override
  void initState() {
    if (_shouldAnimate) {
      _controllerA = AnimationController(
        vsync: this,
        lowerBound: widget.percentScale,
        value: 1,
        duration: const Duration(milliseconds: 100),
      );
      _controllerA.addListener(() {
        setState(() {
          squareScaleA = _controllerA.value;
        });
      });
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () {
        if (_shouldAnimate) {
          _controllerA.reverse();
        }
        if (widget.onTap != null) widget.onTap!();
      },
      onTapDown: (dp) {
        if (_shouldAnimate) {
          _controllerA.reverse();
        }
      },
      onTapUp: (dp) {
        if (_shouldAnimate) {
          Timer(const Duration(milliseconds: 50), () {
            if (mounted) _controllerA.fling();
          });
        }
      },
      onTapCancel: () {
        if (_shouldAnimate) {
          _controllerA.fling();
        }
      },
      child: Transform.scale(
        scale: squareScaleA,
        alignment: widget.alignment,
        child: widget.child,
      ),
    );
  }

  @override
  void dispose() {
    if (_shouldAnimate) {
      _controllerA.dispose();
    }
    super.dispose();
  }
}
