import 'dart:developer';
import 'dart:io';

import 'package:yaml/yaml.dart';

void main() {
  try {
    final yamlFile = File(
      '../fastlight-clientes.api/openapi.yml',
    ).readAsStringSync();
    final yaml = loadYaml(yamlFile);

    // Extraer los esquemas (asumiendo que es un archivo OpenAPI)
    final schemas = yaml['components']['schemas'] as YamlMap?;

    if (schemas == null) {
      log('No se encontraron esquemas en el archivo .yml');
      return;
    }

    // Crear el directorio si no existe
    final outputDir = Directory('lib/src/_api/models');
    if (!outputDir.existsSync()) {
      outputDir.createSync(recursive: true);
      log('Directorio creado: ${outputDir.path}');
    }

    for (var entry in schemas.entries) {
      final modelName = entry.key as String;
      final schema = entry.value as YamlMap;

      final properties = <String>[];
      final constructorParams = <String>[];
      final schemaProperties = schema['properties'] as YamlMap?;

      if (schemaProperties != null) {
        for (var propEntry in schemaProperties.entries) {
          final propName = propEntry.key as String;
          final propInfo = propEntry.value as YamlMap;
          final type = _resolveType(propInfo, schemas);
          // Convertir el nombre de snake_case a camelCase
          final camelCaseName = _toCamelCase(propName);
          properties.add('final $type $camelCaseName;');
          constructorParams.add('required this.$camelCaseName');
        }
      }

      if (properties.isEmpty) {
        log('No se encontraron propiedades para el modelo $modelName');
        continue;
      }

      final classContent =
          '''
class ${modelName}MAPI {
  ${properties.join('\n  ')}

  ${modelName}MAPI({
    ${constructorParams.join(',\n    ')},
  });
}
''';

      final outputFile = File(
        'lib/src/_api/models/${modelName.toLowerCase()}_m_api.dart',
      );
      outputFile.writeAsStringSync(classContent);
      log('Clase generada: $modelName');
    }
  } catch (e, stackTrace) {
    log('Error: $e');
    log('Stack trace: $stackTrace');
  }
}

String _toCamelCase(String snakeCase) {
  final words = snakeCase.split('_');
  if (words.length == 1) {
    return snakeCase; // Si no hay guiones bajos, devolver tal cual
  }
  return words[0] +
      words
          .sublist(1)
          .map(
            (word) => word[0].toUpperCase() + word.substring(1).toLowerCase(),
          )
          .join('');
}

String _resolveType(YamlMap propInfo, YamlMap schemas) {
  if (propInfo.containsKey('\$ref')) {
    // Manejar referencias ($ref)
    final ref = propInfo['\$ref'] as String;
    final refName = ref.split('/').last;
    return '${refName}MAPI';
  }

  final type = propInfo['type'] as String;
  switch (type) {
    case 'string':
      return 'String';
    case 'integer':
      return 'int';
    case 'number':
      return 'double';
    case 'boolean':
      return 'bool';
    case 'array':
      final items = propInfo['items'] as YamlMap;
      final itemType = _resolveType(items, schemas);
      return 'List<$itemType>';
    case 'object':
      return 'Map<String, dynamic>';
    default:
      return type;
  }
}
