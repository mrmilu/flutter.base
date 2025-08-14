# Unificación de Union Types (Freezed) y Enums

Esta documentación describe la estrategia de unificación del proyecto hacia el uso de **Union Types con Freezed** para failures y **Enums** para types, estableciendo patrones consistentes y mejores prácticas para el desarrollo.

## 📋 Tabla de Contenidos

- [Introducción](#-introducción)
- [Union Types para Failures](#-union-types-para-failures)
  - [¿Por qué Union Types?](#por-qué-union-types)
  - [Patrón de Implementación](#patrón-de-implementación)
- [Enums para Types](#-enums-para-types)
  - [¿Por qué Enums?](#por-qué-enums)
  - [Patrón de Implementación Enums](#patrón-de-implementación-enums)
  - [Migración de Types Existentes](#migración-de-types-existentes)
- [Beneficios de la Unificación](#-beneficios-de-la-unificación)
- [Conclusión](#-conclusión)

## 🎯 Introducción

La unificación hacia union types con Freezed y enums busca:

- **Consistencia**: Patrones uniformes en toda la aplicación
- **Type Safety**: Mejor seguridad de tipos en tiempo de compilación  
- **Mantenibilidad**: Código más fácil de mantener y extender
- **Code Generation**: Reducción de boilerplate mediante Freezed
- **Pattern Matching**: Aprovechamiento de las capacidades modernas de Dart
- **Composición**: Jerarquías de failures reutilizables

## 🔗 Union Types para Failures

### ¿Por qué Union Types?

Los union types con Freezed ofrecen ventajas significativas sobre las clases tradicionales:

#### ✅ **Ventajas**
- **Exhaustividad**: El compilador garantiza que todos los casos estén manejados
- **Type Safety**: Imposible crear instancias no válidas
- **Pattern Matching**: Sintaxis moderna y expresiva con `when`
- **Inmutabilidad**: Estructura inmutable por diseño
- **Code Generation**: Freezed genera automáticamente el boilerplate
- **Composición**: Permite anidar failures para jerarquías complejas

#### ❌ **Problemas que Resuelve**
- Herencia compleja y difícil de testear
- Casos no manejados en tiempo de ejecución
- Código boilerplate innecesario
- Dificultad para garantizar cobertura completa

### Patrón de Implementación

#### Estructura Base (Basada en el proyecto)

**1. Failure Base General**
```dart
import 'package:freezed_annotation/freezed_annotation.dart';

part 'general_base_failure.freezed.dart';

@freezed
abstract class GeneralBaseFailure with _$GeneralBaseFailure {
  const factory GeneralBaseFailure.unauthorized({
    @Default('unauthorized') String code,
    @Default('No estás autorizado. Por favor, inicia sesión.') String message,
  }) = GeneralBaseFailureUnauthorized;

  const factory GeneralBaseFailure.internalError({
    @Default('internalError') String code,
    @Default('Error interno del servidor. Intenta más tarde.') String message,
  }) = GeneralBaseFailureInternalError;

  const factory GeneralBaseFailure.networkError({
    @Default('networkError') String code,
    @Default('Sin conexión a internet. Verifica tu red.') String message,
  }) = GeneralBaseFailureNetworkError;

  const factory GeneralBaseFailure.timeoutError({
    @Default('timeoutError') String code,
    @Default('La solicitud tardó demasiado. Intenta de nuevo.') String message,
  }) = GeneralBaseFailureTimeoutError;

  const factory GeneralBaseFailure.invalidResponseFormat({
    @Default('invalidResponseFormat') String code,
    @Default('Formato de respuesta inválido. Contacta soporte.') String message,
  }) = GeneralBaseFailureInvalidResponseFormat;

  const factory GeneralBaseFailure.unexpectedError({
    @Default('unexpectedError') String code,
    @Default('Error inesperado. Intenta más tarde.') String message,
  }) = GeneralBaseFailureUnexpectedError;

  const GeneralBaseFailure._();

  // Factory para crear desde código string
  static GeneralBaseFailure fromString(String code, [String? message]) {
    return switch (code) {
      'unauthorized' => GeneralBaseFailure.unauthorized(
        code: code,
        message: message ?? 'No estás autorizado. Por favor, inicia sesión.',
      ),
      'internalError' => GeneralBaseFailure.internalError(
        code: code,
        message: message ?? 'Error interno del servidor. Intenta más tarde.',
      ),
      'networkError' => GeneralBaseFailure.networkError(
        code: code,
        message: message ?? 'Sin conexión a internet. Verifica tu red.',
      ),
      'timeoutError' => GeneralBaseFailure.timeoutError(
        code: code,
        message: message ?? 'La solicitud tardó demasiado. Intenta de nuevo.',
      ),
      'invalidResponseFormat' => GeneralBaseFailure.invalidResponseFormat(
        code: code,
        message: message ?? 'Formato de respuesta inválido. Contacta soporte.',
      ),
      _ => GeneralBaseFailure.unexpectedError(
        code: code,
        message: message ?? 'Error inesperado. Intenta más tarde.',
      ),
    };
  }
}
```

**2. Failure Específico con Composición**
```dart
import 'package:freezed_annotation/freezed_annotation.dart';
import 'general_base_failure.dart';

part 'get_user_failure.freezed.dart';

@freezed
abstract class GetUserFailure with _$GetUserFailure {
  // Failures específicos del dominio
  const factory GetUserFailure.userNotFound({
    @Default('userNotFound') String code,
    @Default('Usuario no encontrado.') String msg,
  }) = GetUserFailureUserNotFound;

  const factory GetUserFailure.userInvalid({
    @Default('userInvalid') String code,
    @Default('Usuario inválido.') String msg,
  }) = GetUserFailureUserInvalid;

  // Composición: Reutiliza failures generales
  const factory GetUserFailure.general(GeneralBaseFailure error) =
      GetUserFailureGeneral;

  const GetUserFailure._();

  // Getter unificado para mensajes
  String get message => when(
    userNotFound: (code, msg) => msg,
    userInvalid: (code, msg) => msg,
    general: (appError) => appError.message,
  );

  // Factory para crear desde código string
  static GetUserFailure fromString(String code, [String? message]) {
    return switch (code) {
      'userNotFound' => GetUserFailure.userNotFound(
        msg: message ?? 'Usuario no encontrado.',
      ),
      'userInvalid' => GetUserFailure.userInvalid(
        msg: message ?? 'Usuario inválido.',
      ),
      _ => GetUserFailure.general(
        GeneralBaseFailure.fromString(code, message),
      ),
    };
  }
}
```

#### Patrón de Uso

```dart
// En servicios/repositorios
Future<Either<GetUserFailure, User>> getUser(String id) async {
  try {
    final response = await dio.get('/users/$id');
    
    if (response.statusCode == 200) {
      return Right(User.fromJson(response.data));
    } else if (response.statusCode == 404) {
      return Left(GetUserFailure.userNotFound());
    } else if (response.statusCode == 400) {
      return Left(GetUserFailure.userInvalid());
    } else {
      // Delegar a failures generales
      return Left(GetUserFailure.general(
        GeneralBaseFailure.fromString('internalError'),
      ));
    }
  } on DioException catch (e) {
    if (e.type == DioExceptionType.connectionTimeout) {
      return Left(GetUserFailure.general(
        GeneralBaseFailure.timeoutError(),
      ));
    }
    return Left(GetUserFailure.general(
      GeneralBaseFailure.networkError(),
    ));
  } catch (e) {
    return Left(GetUserFailure.general(
      GeneralBaseFailure.unexpectedError(),
    ));
  }
}

// En la capa de presentación
result.fold(
  (failure) => failure.when(
    userNotFound: (code, msg) => showUserNotFoundDialog(),
    userInvalid: (code, msg) => showValidationError(msg),
    general: (generalFailure) => generalFailure.when(
      unauthorized: (code, message) => redirectToLogin(),
      networkError: (code, message) => showNoConnectionBanner(),
      timeoutError: (code, message) => showRetryButton(),
      internalError: (code, message) => showGenericError(),
      invalidResponseFormat: (code, message) => contactSupport(),
      unexpectedError: (code, message) => logErrorAndShowGeneric(),
    ),
  ),
  (user) => showUserProfile(user),
);
```


## 🎨 Enums para Types

### ¿Por qué Enums?

Los enums proporcionan una forma segura y eficiente de representar conjuntos fijos de valores:

#### ✅ **Ventajas**
- **Valores Predefinidos**: Solo valores válidos permitidos
- **Performance**: Comparaciones eficientes
- **Serialización**: Fácil conversión a/desde JSON
- **Autocompletado**: Mejor experiencia de desarrollo
- **Refactoring**: Cambios seguros y rastreables

#### ❌ **Problemas que Resuelve**
- Strings mágicos dispersos en el código
- Errores tipográficos en valores constantes
- Dificultad para rastrear todos los valores posibles
- Falta de validación en tiempo de compilación

### Patrón de Implementación Enums

#### Enum Básico
```dart
enum UserRole {
  admin,
  moderator,
  user,
  guest;
  
  /// Obtener el valor string para serialización
  String get value => name;
  
  /// Crear desde string
  static UserRole? fromString(String value) {
    return UserRole.values.where((role) => role.value == value).firstOrNull;
  }
  
  /// Verificar permisos
  bool get canManageUsers => this == UserRole.admin || this == UserRole.moderator;
  bool get canCreateContent => this != UserRole.guest;
  
  /// Descripción legible
  String get displayName {
    return switch (this) {
      UserRole.admin => 'Administrador',
      UserRole.moderator => 'Moderador',
      UserRole.user => 'Usuario',
      UserRole.guest => 'Invitado',
    };
  }
}
```

#### Enum con Valores Personalizados
```dart
enum ApiEndpoint {
  users('/api/users'),
  posts('/api/posts'),
  comments('/api/comments'),
  auth('/api/auth');
  
  const ApiEndpoint(this.path);
  
  final String path;
  
  /// Construir URL completa
  String url(String baseUrl) => '$baseUrl$path';
  
  /// Obtener método HTTP por defecto
  String get defaultMethod {
    return switch (this) {
      ApiEndpoint.auth => 'POST',
      _ => 'GET',
    };
  }
}
```

#### Enum para Estados
```dart
enum LoadingState {
  initial,
  loading,
  success,
  error;
  
  bool get isLoading => this == LoadingState.loading;
  bool get isSuccess => this == LoadingState.success;
  bool get isError => this == LoadingState.error;
  bool get isInitial => this == LoadingState.initial;
  
  /// Para usar en UI
  String get displayText {
    return switch (this) {
      LoadingState.initial => 'Listo',
      LoadingState.loading => 'Cargando...',
      LoadingState.success => 'Completado',
      LoadingState.error => 'Error',
    };
  }
}
```

### Migración de Types Existentes

#### ❌ **Antes (Strings/Constants)**
```dart
class UserTypes {
  static const String admin = 'admin';
  static const String user = 'user';
  static const String guest = 'guest';
}

// Uso problemático
String userType = 'amin'; // Typo no detectado
if (userType == UserTypes.admin) { ... }
```

#### ✅ **Después (Enums)**
```dart
enum UserType {
  admin,
  user,
  guest;
  
  static UserType fromString(String value) {
    return UserType.values.firstWhere(
      (type) => type.name == value,
      orElse: () => throw ArgumentError('Invalid user type: $value'),
    );
  }
}

// Uso seguro
UserType userType = UserType.admin; // Type-safe
if (userType == UserType.admin) { ... } // No typos posibles
```

## 🎯 Beneficios de la Unificación

### 1. **Type Safety Mejorada**
```dart
// Antes: Posibles errores en runtime
String handleError(dynamic error) {
  if (error is NetworkError) return 'Network issue';
  if (error is ServerError) return 'Server issue';
  // ¿Qué pasa si hay otros tipos?
  return 'Unknown error';
}

// Después: Exhaustividad garantizada
String handleError(ApiFailure failure) {
  return failure.when(
    network: () => 'Network issue',
    server: (code, message) => 'Server issue: $message',
    timeout: (duration) => 'Timeout after ${duration.inSeconds}s',
    unknown: (error) => 'Unknown error: $error',
  );
}
```

### 2. **Refactoring Seguro**
- Renombrar casos actualiza automáticamente todo el código
- Agregar nuevos casos fuerza actualización de pattern matching
- Eliminar casos muestra errores de compilación

### 3. **Mejor Experiencia de Desarrollo**
- Autocompletado completo
- Documentación inline
- Navegación precisa en IDE
- Detección temprana de errores

---

## 📝 Conclusión

La unificación hacia union types para failures y enums para types proporciona:

- **Código más seguro y predecible**
- **Mejor experiencia de desarrollo**
- **Mantenimiento simplificado**
- **Patrones consistentes en toda la aplicación**

Esta estrategia asegura que el código sea más robusto, mantenible y fácil de testear, aprovechando las características modernas de Dart para crear aplicaciones más confiables.

> **Nota**: Para información detallada sobre testing de union types y enums, consulta la [documentación de testing](./testing.md) del proyecto.
