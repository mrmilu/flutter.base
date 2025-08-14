import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'full_screen_image_page.dart';

class ImageNetworkWidget extends StatelessWidget {
  final String? imageUrl;
  final String? imageFullScreenUrl;
  final BoxFit boxFit;
  final double height, width;
  final bool allowFullscreen;
  final String? placeholderSvg; // Permitir SVG placeholder personalizado
  final Widget? errorWidget; // Widget personalizado para errores

  const ImageNetworkWidget({
    super.key,
    required this.imageUrl,
    this.imageFullScreenUrl,
    this.boxFit = BoxFit.cover,
    this.height = 300,
    this.width = 300,
    this.allowFullscreen = false,
    this.placeholderSvg,
    this.errorWidget,
  });

  @override
  Widget build(BuildContext context) {
    // Función helper para mostrar el placeholder
    Widget buildPlaceholder() {
      return SvgPicture.string(
        placeholderSvg ?? _emptyProfileSvg,
        height: height,
        width: width,
        fit: boxFit,
      );
    }

    // Función helper para el widget de error personalizado
    Widget buildErrorWidget() {
      return errorWidget ??
          SizedBox(
            width: width,
            height: height,
            child: const Center(child: Icon(Icons.broken_image)),
          );
    }

    if (imageUrl == null) {
      return buildPlaceholder();
    }

    if (imageUrl!.isEmpty || imageUrl!.contains('http') == false) {
      return buildPlaceholder();
    }

    // Verificar si es SVG
    if (imageUrl!.split('.').last.substring(0, 3) == 'svg') {
      return SvgPicture.network(
        imageUrl!,
        fit: boxFit,
        height: height,
        width: width,
        placeholderBuilder: (context) => buildPlaceholder(),
      );
    }

    final widget = CachedNetworkImage(
      imageUrl: imageUrl!,
      fit: boxFit,
      height: height,
      width: width,
      placeholder: (context, url) => buildPlaceholder(),
      errorWidget: (context, value, e) => buildErrorWidget(),
    );

    if (!allowFullscreen) {
      return widget;
    }

    return GestureDetector(
      onTap: () {
        if (allowFullscreen && imageFullScreenUrl != null) {
          Navigator.push(
            context,
            PageRouteBuilder<void>(
              pageBuilder: (context, animation1, animation2) {
                return ScaleTransition(
                  scale: animation1,
                  child: FullscreenImagePage(imageUrl: imageFullScreenUrl!),
                );
              },
            ),
          );
        }
      },
      child: widget,
    );
  }
}

// SVGs predefinidos para diferentes usos
class RMImagePlaceholders {
  /// SVG placeholder para perfiles de usuario (por defecto)
  static const String userProfile = '''
<svg width="300" height="300" viewBox="0 0 300 300" fill="none" xmlns="http://www.w3.org/2000/svg">
  <!-- Fondo principal -->
  <rect width="300" height="300" rx="8" fill="#F8F9FA"/>
  
  <!-- Círculo de fondo para el avatar -->
  <circle cx="150" cy="150" r="80" fill="#E9ECEF"/>
  
  <!-- Ícono de persona -->
  <!-- Cabeza -->
  <circle cx="150" cy="130" r="25" fill="#ADB5BD"/>
  
  <!-- Cuerpo -->
  <path d="M150 165 C130 165, 115 175, 110 190 C108 195, 108 200, 110 205 L190 205 C192 200, 192 195, 190 190 C185 175, 170 165, 150 165 Z" fill="#ADB5BD"/>
  
  <!-- Decoración sutil -->
  <circle cx="150" cy="150" r="79" stroke="#DEE2E6" stroke-width="1"/>
  
  <!-- Pequeño indicador de imagen en la esquina -->
  <g transform="translate(240, 240)">
    <circle cx="0" cy="0" r="15" fill="#6C757D"/>
    <path d="M-8 -3 L-3 2 L3 -4 L8 1 L8 8 L-8 8 Z" fill="white"/>
    <circle cx="2" cy="-6" r="2" fill="white"/>
  </g>
</svg>
''';

  /// SVG placeholder minimalista
  static const String minimal = '''
<svg width="300" height="300" viewBox="0 0 300 300" fill="none" xmlns="http://www.w3.org/2000/svg">
  <rect width="300" height="300" rx="150" fill="#F5F5F5"/>
  <circle cx="150" cy="120" r="35" fill="#BDBDBD"/>
  <path d="M150 170 C120 170, 95 190, 95 220 L95 250 L205 250 L205 220 C205 190, 180 170, 150 170 Z" fill="#BDBDBD"/>
</svg>
''';

  /// SVG placeholder para organizaciones/empresas
  static const String organization = '''
<svg width="300" height="300" viewBox="0 0 300 300" fill="none" xmlns="http://www.w3.org/2000/svg">
  <rect width="300" height="300" rx="12" fill="#F8F9FA"/>
  <rect x="75" y="75" width="150" height="105" rx="8" fill="#ADB5BD"/>
  <rect x="90" y="90" width="120" height="75" fill="white"/>
  <rect x="75" y="195" width="150" height="30" rx="4" fill="#ADB5BD"/>
  <!-- Ícono de edificio -->
  <g transform="translate(150, 135)">
    <rect x="-15" y="-15" width="30" height="30" fill="#6C757D"/>
    <rect x="-10" y="-10" width="5" height="5" fill="white"/>
    <rect x="0" y="-10" width="5" height="5" fill="white"/>
    <rect x="5" y="-10" width="5" height="5" fill="white"/>
    <rect x="-10" y="0" width="5" height="5" fill="white"/>
    <rect x="0" y="0" width="5" height="5" fill="white"/>
    <rect x="5" y="0" width="5" height="5" fill="white"/>
  </g>
</svg>
''';

  /// SVG placeholder para imágenes generales
  static const String image = '''
<svg width="300" height="300" viewBox="0 0 300 300" fill="none" xmlns="http://www.w3.org/2000/svg">
  <rect width="300" height="300" rx="8" fill="#F8F9FA"/>
  <rect x="50" y="50" width="200" height="200" rx="4" fill="#E9ECEF" stroke="#DEE2E6" stroke-width="2"/>
  
  <!-- Ícono de imagen -->
  <g transform="translate(150, 150)">
    <!-- Marco de imagen -->
    <rect x="-40" y="-40" width="80" height="80" rx="4" fill="none" stroke="#ADB5BD" stroke-width="2"/>
    
    <!-- Montañas -->
    <path d="M-40 20 L-20 0 L0 20 L20 0 L40 20 L40 40 L-40 40 Z" fill="#ADB5BD"/>
    
    <!-- Sol -->
    <circle cx="20" cy="-20" r="8" fill="#6C757D"/>
  </g>
  
  <!-- Indicador de carga -->
  <g transform="translate(270, 270)">
    <circle cx="0" cy="0" r="12" fill="#6C757D"/>
    <path d="M-6 -2 L-2 2 L2 -2 L6 2 L6 6 L-6 6 Z" fill="white"/>
  </g>
</svg>
''';
}

// SVG para perfil vacío/placeholder (mantenido por compatibilidad)
const String _emptyProfileSvg = RMImagePlaceholders.userProfile;
