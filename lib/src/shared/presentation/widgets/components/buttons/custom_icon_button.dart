import 'package:flutter/material.dart';

import '../../../utils/styles/colors/colors_context.dart';
import '../../common/image_asset_widget.dart';

/// Widget de botón de icono personalizado del design system
///
/// Uso:
/// ```dart
/// CustomIconButton.primary(
///   key: Key('my-icon-button'),
///   iconPath: RMAssets.iconInfo, // Usar assets del package
///   onPressed: () {},
/// )
///
/// // O con un icono personalizado:
/// CustomIconButton.primary(
///   iconPath: RMAssets.iconPath('mi_icono.svg'),
///   onPressed: () {},
/// )
/// ```

/// Widget de botón de icono personalizado del design system
///
/// Uso:
/// ```dart
/// CustomIconButton.primary(
///   key: Key('my-icon-button'),
///   iconPath: 'assets/icons/star.png',
///   onPressed: () {},
/// )
/// ```
class CustomIconButton extends StatelessWidget {
  /// Ruta del icono
  final String iconPath;

  /// Función que se ejecuta al presionar el botón
  final VoidCallback? onPressed;

  /// Si el botón está habilitado
  final bool enabled;

  /// Si el botón está en estado de carga
  final bool isLoading;

  /// Color de fondo personalizado
  final Color? backgroundColor;

  /// Color del icono personalizado
  final Color? foregroundColor;

  /// Si el botón tiene borde
  final bool withBorder;

  /// Padding del botón
  final EdgeInsetsGeometry? padding;

  const CustomIconButton._({
    super.key,
    required this.iconPath,
    required this.onPressed,
    this.enabled = true,
    this.isLoading = false,
    this.backgroundColor,
    this.foregroundColor,
    this.withBorder = false,
    this.padding,
  });

  /// Crea un botón de icono con estilo primario
  const CustomIconButton.primary({
    Key? key,
    required String iconPath,
    required VoidCallback? onPressed,
    bool enabled = true,
    bool isLoading = false,
    Color? backgroundColor,
    Color? foregroundColor,
    bool withBorder = false,
    EdgeInsetsGeometry? padding,
  }) : this._(
         key: key,
         iconPath: iconPath,
         onPressed: onPressed,
         enabled: enabled,
         isLoading: isLoading,
         backgroundColor: backgroundColor,
         foregroundColor: foregroundColor,
         withBorder: withBorder,
         padding: padding,
       );

  const CustomIconButton.outline({
    Key? key,
    required String iconPath,
    required VoidCallback? onPressed,
    bool enabled = true,
    bool isLoading = false,
    Color? backgroundColor,
    Color? foregroundColor,
    EdgeInsetsGeometry? padding,
  }) : this._(
         key: key,
         iconPath: iconPath,
         onPressed: onPressed,
         enabled: enabled,
         isLoading: isLoading,
         backgroundColor: backgroundColor ?? Colors.transparent,
         foregroundColor: foregroundColor,
         withBorder: true,
         padding: padding,
       );

  @override
  Widget build(BuildContext context) {
    final effectiveOnPressed = enabled ? onPressed : null;

    return TextButton(
      onPressed: effectiveOnPressed,
      style: TextButton.styleFrom(
        padding:
            padding ?? const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
        minimumSize: const Size(12, 12),
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        visualDensity: VisualDensity.compact,
        shape: withBorder
            ? RoundedRectangleBorder(
                side: BorderSide(
                  color: context.colors.onDisabled,
                ),
                borderRadius: BorderRadius.circular(8),
              )
            : null,
        disabledBackgroundColor: context.colors.disabled,
        disabledForegroundColor: context.colors.onDisabled,
        foregroundColor: _getForegroundColor(context),
        backgroundColor: _getBackgroundColor(context),
        overlayColor: Colors.transparent,
      ),
      autofocus: true,
      child: isLoading
          ? SizedBox(
              height: 20,
              width: 20,
              child: Padding(
                padding: const EdgeInsets.all(2.0),
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  color: _getForegroundColor(context),
                ),
              ),
            )
          : ImageAssetWidget(
              path: iconPath,
              height: 20,
              width: 20,
              color: _getForegroundColor(context),
            ),
    );
  }

  Color? _getBackgroundColor(BuildContext context) {
    if (!enabled) return context.colors.disabled;
    return backgroundColor ?? context.colors.primary;
  }

  Color _getForegroundColor(BuildContext context) {
    if (!enabled) return Colors.white;
    if (foregroundColor != null) return foregroundColor!;
    final brightness = Theme.of(context).brightness;
    return brightness == Brightness.dark ? Colors.white : Colors.black;
  }
}
