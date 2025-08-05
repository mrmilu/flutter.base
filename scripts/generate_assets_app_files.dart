// ignore_for_file: avoid_print

import 'dart:io';

void main() {
  print('🚀 Generando archivos de assets...\n');

  final assetGenerator = AssetGenerator();
  assetGenerator.generateAllAssetFiles();

  print('\n✅ ¡Archivos de assets generados exitosamente!');
}

class AssetGenerator {
  static const String assetsPath = 'assets';
  static const String outputPath = 'lib/src/shared/presentation/utils/assets';

  void generateAllAssetFiles() {
    _generateIconsFile();
    _generateImagesFile();
    _generateLottiesFile();
    _generateRiveFile();
  }

  void _generateIconsFile() {
    final iconsDir = Directory('$assetsPath/icons');
    if (!iconsDir.existsSync()) {
      print('⚠️  Carpeta assets/icons no encontrada, saltando...');
      return;
    }

    final iconFiles = _getFilesFromDirectory(iconsDir, [
      '.svg',
      '.png',
      '.jpg',
      '.jpeg',
    ]);
    final content = _generateIconsContent(iconFiles);

    _writeFile('$outputPath/app_assets_icons.dart', content);
    print('📁 Generado: app_assets_icons.dart (${iconFiles.length} iconos)');
  }

  void _generateImagesFile() {
    final imagesDir = Directory('$assetsPath/images');
    if (!imagesDir.existsSync()) {
      print('⚠️  Carpeta assets/images no encontrada, saltando...');
      return;
    }

    final imageFiles = _getFilesFromDirectory(imagesDir, [
      '.png',
      '.jpg',
      '.jpeg',
      '.webp',
      '.gif',
    ]);
    final content = _generateImagesContent(imageFiles);

    _writeFile('$outputPath/app_assets_images.dart', content);
    print(
      '🖼️  Generado: app_assets_images.dart (${imageFiles.length} imágenes)',
    );
  }

  void _generateLottiesFile() {
    final lottiesDir = Directory('$assetsPath/lotties');
    if (!lottiesDir.existsSync()) {
      print('⚠️  Carpeta assets/lotties no encontrada, saltando...');
      return;
    }

    final lottieFiles = _getFilesFromDirectory(lottiesDir, ['.json']);
    final content = _generateLottiesContent(lottieFiles);

    _writeFile('$outputPath/app_assets_lotties.dart', content);
    print(
      '🎭 Generado: app_assets_lotties.dart (${lottieFiles.length} animaciones)',
    );
  }

  void _generateRiveFile() {
    final riveDir = Directory('$assetsPath/rive');
    if (!riveDir.existsSync()) {
      print('⚠️  Carpeta assets/rive no encontrada, saltando...');
      return;
    }

    final riveFiles = _getFilesFromDirectory(riveDir, ['.riv', '.flr']);
    final content = _generateRiveContent(riveFiles);

    _writeFile('$outputPath/app_assets_rive.dart', content);
    print(
      '🎮 Generado: app_assets_rive.dart (${riveFiles.length} animaciones)',
    );
  }

  List<FileInfo> _getFilesFromDirectory(
    Directory dir,
    List<String> extensions,
  ) {
    final files = <FileInfo>[];

    for (final entity in dir.listSync(recursive: true)) {
      if (entity is File) {
        final fileName = entity.path.split('/').last;
        final extension = '.${fileName.split('.').last}';

        if (extensions.contains(extension.toLowerCase())) {
          final relativePath = entity.path.replaceFirst(
            '${Directory.current.path}/',
            '',
          );
          final variableName = _generateVariableName(fileName);

          files.add(
            FileInfo(
              fileName: fileName,
              relativePath: relativePath,
              variableName: variableName,
            ),
          );
        }
      }
    }

    files.sort((a, b) => a.variableName.compareTo(b.variableName));
    return files;
  }

  String _generateVariableName(String fileName) {
    // Remover extensión
    final nameWithoutExtension = fileName.split('.').first;

    // Convertir de snake_case a camelCase
    final parts = nameWithoutExtension.split('_');
    if (parts.length == 1) return parts.first;

    final camelCase =
        parts.first +
        parts
            .skip(1)
            .map(
              (part) =>
                  part.isEmpty ? '' : part[0].toUpperCase() + part.substring(1),
            )
            .join();

    return camelCase;
  }

  String _generateIconsContent(List<FileInfo> files) {
    final buffer = StringBuffer();

    buffer.writeln('/// Constantes para los iconos de la aplicación');
    buffer.writeln('/// Generado automáticamente - NO EDITAR MANUALMENTE');
    buffer.writeln('class AppAssetsIcons {');
    buffer.writeln('  /// Previene instanciación de la clase');
    buffer.writeln('  AppAssetsIcons._();');
    buffer.writeln();
    buffer.writeln(
      '  // =============================================================================',
    );
    buffer.writeln('  // 🎨 ICONOS');
    buffer.writeln(
      '  // =============================================================================',
    );
    buffer.writeln();
    buffer.writeln('  /// Ruta base para los iconos');
    buffer.writeln('  static const String _iconsPath = \'$assetsPath/icons\';');
    buffer.writeln();

    for (final file in files) {
      final comment = _generateCommentFromFileName(file.fileName);
      buffer.writeln('  /// $comment - ${file.relativePath}');
      buffer.writeln(
        '  static const String ${file.variableName} = \'${file.relativePath}\';',
      );
      buffer.writeln();
    }

    buffer.writeln(
      '  // =============================================================================',
    );
    buffer.writeln('  // 🎯 UTILIDADES');
    buffer.writeln(
      '  // =============================================================================',
    );
    buffer.writeln();
    buffer.writeln('  /// Genera la ruta completa para un icono personalizado');
    buffer.writeln('  ///');
    buffer.writeln('  /// Uso:');
    buffer.writeln('  /// ```dart');
    buffer.writeln('  /// AppAssetsIcons.iconPath(\'custom_icon.svg\')');
    buffer.writeln('  /// // Retorna: \'$assetsPath/icons/custom_icon.svg\'');
    buffer.writeln('  /// ```');
    buffer.writeln(
      '  static String iconPath(String iconName) => \'\$_iconsPath/\$iconName\';',
    );
    buffer.writeln('}');

    return buffer.toString();
  }

  String _generateImagesContent(List<FileInfo> files) {
    final buffer = StringBuffer();

    buffer.writeln('/// Constantes para las imágenes de la aplicación');
    buffer.writeln('/// Generado automáticamente - NO EDITAR MANUALMENTE');
    buffer.writeln('class AppAssetsImages {');
    buffer.writeln('  /// Previene instanciación de la clase');
    buffer.writeln('  AppAssetsImages._();');
    buffer.writeln();
    buffer.writeln(
      '  // =============================================================================',
    );
    buffer.writeln('  // 🖼️ IMÁGENES');
    buffer.writeln(
      '  // =============================================================================',
    );
    buffer.writeln();
    buffer.writeln('  /// Ruta base para las imágenes');
    buffer.writeln(
      '  static const String _imagesPath = \'$assetsPath/images\';',
    );
    buffer.writeln();

    for (final file in files) {
      final comment = _generateCommentFromFileName(file.fileName);
      buffer.writeln('  /// $comment - ${file.relativePath}');
      buffer.writeln(
        '  static const String ${file.variableName} = \'${file.relativePath}\';',
      );
      buffer.writeln();
    }

    buffer.writeln(
      '  // =============================================================================',
    );
    buffer.writeln('  // 🎯 UTILIDADES');
    buffer.writeln(
      '  // =============================================================================',
    );
    buffer.writeln();
    buffer.writeln(
      '  /// Genera la ruta completa para una imagen personalizada',
    );
    buffer.writeln(
      '  static String imagePath(String imageName) => \'\$_imagesPath/\$imageName\';',
    );
    buffer.writeln('}');

    return buffer.toString();
  }

  String _generateLottiesContent(List<FileInfo> files) {
    final buffer = StringBuffer();

    buffer.writeln(
      '/// Constantes para las animaciones Lottie de la aplicación',
    );
    buffer.writeln('/// Generado automáticamente - NO EDITAR MANUALMENTE');
    buffer.writeln('class AppAssetsLotties {');
    buffer.writeln('  /// Previene instanciación de la clase');
    buffer.writeln('  AppAssetsLotties._();');
    buffer.writeln();
    buffer.writeln(
      '  // =============================================================================',
    );
    buffer.writeln('  // 🎭 ANIMACIONES LOTTIE');
    buffer.writeln(
      '  // =============================================================================',
    );
    buffer.writeln();
    buffer.writeln('  /// Ruta base para las animaciones Lottie');
    buffer.writeln(
      '  static const String _lottiesPath = \'$assetsPath/lotties\';',
    );
    buffer.writeln();

    for (final file in files) {
      final comment = _generateCommentFromFileName(file.fileName);
      buffer.writeln('  /// $comment - ${file.relativePath}');
      buffer.writeln(
        '  static const String ${file.variableName} = \'${file.relativePath}\';',
      );
      buffer.writeln();
    }

    buffer.writeln(
      '  // =============================================================================',
    );
    buffer.writeln('  // 🎯 UTILIDADES');
    buffer.writeln(
      '  // =============================================================================',
    );
    buffer.writeln();
    buffer.writeln(
      '  /// Genera la ruta completa para una animación Lottie personalizada',
    );
    buffer.writeln(
      '  static String lottiePath(String lottieName) => \'\$_lottiesPath/\$lottieName\';',
    );
    buffer.writeln('}');

    return buffer.toString();
  }

  String _generateRiveContent(List<FileInfo> files) {
    final buffer = StringBuffer();

    buffer.writeln('/// Constantes para las animaciones Rive de la aplicación');
    buffer.writeln('/// Generado automáticamente - NO EDITAR MANUALMENTE');
    buffer.writeln('class AppAssetsRive {');
    buffer.writeln('  /// Previene instanciación de la clase');
    buffer.writeln('  AppAssetsRive._();');
    buffer.writeln();
    buffer.writeln(
      '  // =============================================================================',
    );
    buffer.writeln('  // 🎮 ANIMACIONES RIVE');
    buffer.writeln(
      '  // =============================================================================',
    );
    buffer.writeln();
    buffer.writeln('  /// Ruta base para las animaciones Rive');
    buffer.writeln('  static const String _rivePath = \'$assetsPath/rive\';');
    buffer.writeln();

    for (final file in files) {
      final comment = _generateCommentFromFileName(file.fileName);
      buffer.writeln('  /// $comment - ${file.relativePath}');
      buffer.writeln(
        '  static const String ${file.variableName} = \'${file.relativePath}\';',
      );
      buffer.writeln();
    }

    buffer.writeln(
      '  // =============================================================================',
    );
    buffer.writeln('  // 🎯 UTILIDADES');
    buffer.writeln(
      '  // =============================================================================',
    );
    buffer.writeln();
    buffer.writeln(
      '  /// Genera la ruta completa para una animación Rive personalizada',
    );
    buffer.writeln(
      '  static String rivePath(String riveName) => \'\$_rivePath/\$riveName\';',
    );
    buffer.writeln('}');

    return buffer.toString();
  }

  String _generateCommentFromFileName(String fileName) {
    final nameWithoutExtension = fileName.split('.').first;
    final words = nameWithoutExtension.split('_');

    // Capitalizar cada palabra
    final capitalizedWords = words
        .map((word) {
          if (word.isEmpty) return word;
          return word[0].toUpperCase() + word.substring(1).toLowerCase();
        })
        .join(' ');

    return capitalizedWords;
  }

  void _writeFile(String path, String content) {
    final file = File(path);

    // Crear directorio si no existe
    final dir = Directory(file.parent.path);
    if (!dir.existsSync()) {
      dir.createSync(recursive: true);
    }

    file.writeAsStringSync(content);
  }
}

class FileInfo {
  final String fileName;
  final String relativePath;
  final String variableName;

  FileInfo({
    required this.fileName,
    required this.relativePath,
    required this.variableName,
  });
}
