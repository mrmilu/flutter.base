import 'dart:developer';
import 'dart:io';

void main() {
  final dir = Directory('lib/src/api/lib/model');
  if (!dir.existsSync()) {
    log('Directorio de modelos no encontrado.');
    return;
  }

  for (var file in dir.listSync().whereType<File>()) {
    if (file.path.endsWith('.dart')) {
      generateInterface(file);
    }
  }
}

void generateInterface(File file) {
  final content = file.readAsStringSync();
  final lines = content.split('\n');

  // Extraer el nombre de la clase
  final classLine = lines.firstWhere(
    (line) => line.trim().startsWith('class '),
    orElse: () => '',
  );
  if (classLine.isEmpty) {
    log('No se encontró una clase en ${file.path}');
    return;
  }

  final className = classLine.split('class ')[1].split(' {')[0].trim();

  // Extraer las propiedades (líneas que definen variables de instancia)
  final properties = <String>[];
  bool insideClass = false;
  for (var line in lines) {
    final trimmedLine = line.trim();

    // Detectar el inicio de la clase
    if (trimmedLine.startsWith('class $className {')) {
      insideClass = true;
      continue;
    }

    // Detectar el fin de la clase
    if (insideClass && trimmedLine == '}') {
      break;
    }

    // Buscar propiedades (líneas que terminan con ';' y no son métodos ni constructores)
    if (insideClass &&
        trimmedLine.endsWith(';') &&
        !trimmedLine.contains('(') && // Excluir métodos y constructores
        !trimmedLine.startsWith('///') && // Excluir comentarios
        !trimmedLine.startsWith('@') && // Excluir anotaciones
        trimmedLine.isNotEmpty) {
      // Extraer el tipo y el nombre de la propiedad
      final parts = trimmedLine.split(' ');
      if (parts.length >= 2) {
        final type = parts[0]; // Por ejemplo, "String?" o "Address?"
        final name = parts[1].replaceAll(';', ''); // Por ejemplo, "cups"
        properties.add('$type get $name;');
      }
    }
  }

  if (properties.isEmpty) {
    log('No se encontraron propiedades en ${file.path}');
    return;
  }

  // Crear la interfaz
  final interfaceContent =
      '''
// ignore_for_file: one_member_abstracts
abstract class I$className {
  ${properties.join('\n  ')}
}
''';

  // Escribir la interfaz en un nuevo archivo
  final newFile = File('${file.parent.path}/i_${file.uri.pathSegments.last}');
  newFile.writeAsStringSync(interfaceContent);
  log('Interfaz generada: ${newFile.path}');
}
