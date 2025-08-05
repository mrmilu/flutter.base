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
    final outputDir = Directory('lib/src/_api/interfaces');
    if (!outputDir.existsSync()) {
      outputDir.createSync(recursive: true);
      log('Directorio creado: ${outputDir.path}');
    }

    for (var entry in schemas.entries) {
      final modelName = entry.key as String;
      final schema = entry.value as YamlMap;

      final properties = <String>[];
      final imports = <String>{}; // Para almacenar las importaciones necesarias
      final schemaProperties = schema['properties'] as YamlMap?;
      final requiredFields = (schema['required'] as YamlList?)?.toList() ?? [];

      if (schemaProperties != null) {
        for (var propEntry in schemaProperties.entries) {
          final propName = propEntry.key as String;
          final propInfo = propEntry.value as YamlMap;
          final typeInfo = _resolveType(propInfo, schemas);
          final type = typeInfo['type'] as String;
          final isRequired = requiredFields.contains(propName);
          final dartType = isRequired ? type : '$type?';
          final camelCaseName = _toCamelCase(propName);
          properties.add('$dartType get $camelCaseName;');

          // Añadir importaciones para tipos referenciados
          final referencedTypes = _extractReferencedTypes(typeInfo);
          for (var refType in referencedTypes) {
            // Eliminar el prefijo 'I' del tipo para obtener el nombre del esquema original
            final refName = refType.startsWith('I')
                ? refType.substring(1)
                : refType;
            imports.add("import 'i_${refName.toLowerCase()}.dart';");
          }
        }
      }

      // Generar las importaciones (si las hay)
      final importsLists = imports.toList()..sort((a, b) => a.compareTo(b));
      final importsContent = importsLists.isNotEmpty
          ? '${importsLists.join('\n')}\n'
          : '';

      final interfaceContent =
          '''
// ignore_for_file: one_member_abstracts
$importsContent
abstract class I$modelName {
  ${properties.join('\n  ')}
}
''';

      final outputFile = File(
        'lib/src/_api/interfaces/i_${modelName.toLowerCase()}.dart',
      );
      outputFile.writeAsStringSync(interfaceContent);
      log('Interfaz generada: I$modelName');
    }
  } catch (e, stackTrace) {
    log('Error: $e');
    log('Stack trace: $stackTrace');
  }
}

String _toCamelCase(String snakeCase) {
  final words = snakeCase.split('_');
  if (words.length == 1) return snakeCase;
  return words[0] +
      words
          .sublist(1)
          .map(
            (word) => word[0].toUpperCase() + word.substring(1).toLowerCase(),
          )
          .join('');
}

Map<String, dynamic> _resolveType(YamlMap propInfo, YamlMap schemas) {
  if (propInfo.containsKey('\$ref')) {
    // Manejar referencias ($ref)
    final ref = propInfo['\$ref'] as String;
    final refName = ref.split('/').last;
    return {'type': 'I$refName', 'isRef': true};
  }

  final type = propInfo['type'] as String;
  switch (type) {
    case 'string':
      return {'type': 'String', 'isRef': false};
    case 'integer':
      return {'type': 'int', 'isRef': false};
    case 'number':
      return {'type': 'double', 'isRef': false};
    case 'boolean':
      return {'type': 'bool', 'isRef': false};
    case 'array':
      final items = propInfo['items'] as YamlMap;
      final itemTypeInfo = _resolveType(items, schemas);
      final itemType = itemTypeInfo['type'] as String;
      return {
        'type': 'List<$itemType>',
        'isList': true,
        'itemType': itemType,
        'isRef': itemTypeInfo['isRef'],
      };
    case 'object':
      return {'type': 'Map<String, dynamic>', 'isRef': false};
    default:
      return {'type': type, 'isRef': false};
  }
}

List<String> _extractReferencedTypes(Map<String, dynamic> typeInfo) {
  final referencedTypes = <String>[];

  // Si es una lista, solo procesar el tipo de los elementos
  if (typeInfo['isList'] == true) {
    final itemType = typeInfo['itemType'] as String;
    if (typeInfo['isRef'] == true) {
      referencedTypes.add(itemType);
    }
    return referencedTypes; // No procesar el tipo completo (List<IContract>)
  }

  // Si es una referencia directa (por ejemplo, IAddress)
  if (typeInfo['isRef'] == true) {
    referencedTypes.add(typeInfo['type'] as String);
  }

  return referencedTypes;
}
