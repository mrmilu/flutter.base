import 'package:flutter/material.dart';

import '../../../utils/styles/colors.dart';
import '../../common/button_scale_widget.dart';
import '../../common/image_asset_widget.dart';

/// Widget de botón outlined personalizado del design system
///
/// Uso:
/// ```dart
/// CustomOutlinedButton.primary(
///   key: Key('my-outlined-button'),
///   label: 'Outlined Button',
///   onPressed: () {},
/// )
/// ```
class CustomOutlinedButton extends StatelessWidget {
  /// Texto del botón
  final String label;

  /// Función que se ejecuta al presionar el botón
  final VoidCallback onPressed;

  /// Color de fondo personalizado
  final Color? backgroundColor;

  /// Color del texto personalizado
  final Color? foregroundColor;

  /// Padding personalizado
  final EdgeInsets? padding;

  /// Si el botón está deshabilitado
  final bool isDisabled;

  /// Si el botón está en estado de carga
  final bool isLoading;

  /// Ruta del icono (opcional)
  final String? iconPath;

  /// Si el icono va a la derecha del texto
  final bool iconRight;

  /// Alineación del texto
  final TextAlign? textAlign;

  /// Estilo de texto personalizado
  final TextStyle? textStyle;

  /// Widget de icono personalizado
  final Widget? iconWidget;

  const CustomOutlinedButton._({
    super.key,
    required this.label,
    required this.onPressed,
    this.backgroundColor,
    this.foregroundColor,
    this.padding,
    this.isDisabled = false,
    this.isLoading = false,
    this.iconPath,
    this.iconRight = false,
    this.textAlign,
    this.textStyle,
    this.iconWidget,
  });

  /// Crea un botón outlined con estilo primario
  const CustomOutlinedButton.primary({
    Key? key,
    required String label,
    required VoidCallback onPressed,
    Color? backgroundColor,
    Color? foregroundColor,
    EdgeInsets? padding,
    bool isDisabled = false,
    bool isLoading = false,
    String? iconPath,
    bool iconRight = false,
    TextAlign? textAlign,
    TextStyle? textStyle,
    Widget? iconWidget,
  }) : this._(
         key: key,
         label: label,
         onPressed: onPressed,
         backgroundColor: backgroundColor,
         foregroundColor: foregroundColor,
         padding: padding,
         isDisabled: isDisabled,
         isLoading: isLoading,
         iconPath: iconPath,
         iconRight: iconRight,
         textAlign: textAlign,
         textStyle: textStyle,
         iconWidget: iconWidget,
       );

  @override
  Widget build(BuildContext context) {
    return ButtonScaleWidget(
      onTap: isDisabled
          ? null
          : () {
              if (isLoading) return;
              onPressed();
            },
      child: OutlinedButton(
        onPressed: () {
          if (isLoading || isDisabled) return;
          onPressed();
        },
        style: OutlinedButton.styleFrom(
          disabledBackgroundColor: Colors.transparent,
          disabledForegroundColor: AppColors.disabled,
          side: isDisabled
              ? const BorderSide(color: AppColors.disabled)
              : foregroundColor != null
              ? BorderSide(color: foregroundColor!)
              : null,
          backgroundColor: isDisabled ? Colors.transparent : backgroundColor,
          foregroundColor: isDisabled ? AppColors.disabled : foregroundColor,
          padding: padding,
        ),
        child: isLoading
            ? Padding(
                padding: const EdgeInsets.symmetric(vertical: 2.0),
                child: SizedBox(
                  height: 16,
                  width: 16,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    color:
                        foregroundColor ?? _getDefaultForegroundColor(context),
                  ),
                ),
              )
            : Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (!iconRight && iconPath != null) ...[
                    ImageAssetWidget.icon(
                      path: iconPath!,
                      width: 20,
                      height: 20,
                    ),
                    const SizedBox(width: 8),
                  ],
                  if (!iconRight && iconWidget != null) ...[
                    iconWidget!,
                    const SizedBox(width: 8),
                  ],
                  Flexible(
                    child: Text(label, textAlign: textAlign, style: textStyle),
                  ),
                  if (iconRight && iconPath != null) ...[
                    const SizedBox(width: 8),
                    ImageAssetWidget.icon(
                      path: iconPath!,
                      width: 20,
                      height: 20,
                    ),
                  ],
                  if (iconRight && iconWidget != null) ...[
                    const SizedBox(width: 8),
                    iconWidget!,
                  ],
                ],
              ),
      ),
    );
  }

  /// Obtiene el color de texto por defecto según el tema actual
  Color _getDefaultForegroundColor(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    return brightness == Brightness.dark
        ? Colors.white
        : AppColors.specificContentHigh;
  }
}
