# Tests Reales - Flutter Base

Este documento describe los tests reales implementados para el proyecto Flutter Base, basados en la arquitectura y componentes reales del proyecto.

## 📁 Estructura de Tests

```
test/
├── helpers/
│   └── pump_app.dart                    # Utilidad para tests de widgets
├── unit/
│   ├── locale/
│   │   ├── presentation/providers/
│   │   │   └── locale_cubit_test.dart   # Tests del LocaleCubit
│   │   └── data/
│   │       └── locale_repository_impl_test.dart  # Tests del repositorio
│   └── auth/
│       └── data/
│           └── mock_auth_service_test.dart  # Tests de autenticación
├── widget/
│   └── shared/presentation/widgets/components/checkboxs/
│       └── custom_checkbox_widget_test.dart  # Tests del checkbox personalizado
├── integration/
│   └── app_integration_test.dart        # Tests de integración de la app
├── run_tests.sh                         # Script para ejecutar tests
└── README_TESTS.md                      # Este documento
```

## 🧪 Tipos de Tests Implementados

### 1. Tests Unitarios

#### LocaleCubit Tests (`test/unit/locale/presentation/providers/locale_cubit_test.dart`)
- **Propósito**: Testear la lógica de cambio de idioma usando el patrón Cubit real del proyecto
- **Componentes reales testeados**:
  - `LocaleCubit` con estados `LocaleState`
  - `ILocaleRepository` con mock implementation
  - Variable global `appLocaleCode`
- **Escenarios**:
  - Estado inicial correcto
  - Cambio de idioma exitoso
  - Carga de idioma desde repositorio
  - Manejo de errores del repositorio

#### LocaleRepositoryImpl Tests (`test/unit/locale/data/locale_repository_impl_test.dart`)
- **Propósito**: Testear la persistencia de idioma usando SharedPreferences real
- **Componentes reales testeados**:
  - `LocaleRepositoryImpl` real
  - `SharedPreferences` con mocking
- **Escenarios**:
  - Guardado y recuperación de idioma
  - Manejo de casos sin datos previos
  - Múltiples instancias de repositorio

#### MockAuthService Tests (`test/unit/auth/data/mock_auth_service_test.dart`)
- **Propósito**: Testear lógica de autenticación usando el patrón ResultOr real
- **Componentes reales testeados**:
  - Patrón `ResultOr<F>` del proyecto
  - Enum `AuthError` personalizado
  - Validaciones de email y contraseña
- **Escenarios**:
  - Login exitoso y fallido
  - Registro exitoso y fallido
  - Validación de formato de email
  - Validación de longitud de contraseña

### 2. Tests de Widgets

#### CustomCheckboxWidget Tests (`test/widget/shared/presentation/widgets/components/checkboxs/custom_checkbox_widget_test.dart`)
- **Propósito**: Testear el widget checkbox personalizado real del proyecto
- **Componentes reales testeados**:
  - `CustomCheckboxWidget` con todas sus propiedades
  - Callbacks `onChanged`
  - Estados enabled/disabled
  - Textos de título, error e información
- **Escenarios**:
  - Renderizado con diferentes estados
  - Interacción de usuario (tap)
  - Cambios de estado (checked/unchecked)
  - Display de textos auxiliares
  - Estados habilitado/deshabilitado

### 3. Tests de Integración

#### App Integration Tests (`test/integration/app_integration_test.dart`)
- **Propósito**: Testear el comportamiento completo de la aplicación
- **Componentes reales testeados**:
  - Aplicación completa desde `main.dart`
  - Navegación y transiciones
  - Manejo de orientación
  - Elementos de UI básicos
- **Escenarios**:
  - Inicio correcto de la aplicación
  - Splash screen y navegación
  - Rotación de pantalla
  - Interacciones básicas de usuario
  - Múltiples interacciones secuenciales

## 🛠️ Utilidades de Test

### PumpApp Helper (`test/helpers/pump_app.dart`)
- **Propósito**: Utilidad para configurar el entorno de testing de widgets
- **Funcionalidades**:
  - Configuración de MaterialApp con tema
  - Integración con sistema de localización real (`S.delegate`)
  - Soporte para BlocProvider
  - Configuración de rutas y navegación

## 🚀 Cómo Ejecutar los Tests

### Opción 1: Script Automatizado
```bash
# Hacer el script ejecutable
chmod +x test/run_tests.sh

# Ejecutar script interactivo
./test/run_tests.sh

# O ejecutar directamente una categoría
./test/run_tests.sh 1  # Tests unitarios
./test/run_tests.sh 2  # Tests de widgets
./test/run_tests.sh 3  # Tests de integración
./test/run_tests.sh 4  # Todos los tests
```

### Opción 2: Comandos Flutter Directos
```bash
# Todos los tests
flutter test

# Solo tests unitarios
flutter test test/unit/

# Solo tests de widgets
flutter test test/widget/

# Solo tests de integración
flutter test test/integration/

# Test específico
flutter test test/unit/locale/presentation/providers/locale_cubit_test.dart

# Con reporte detallado
flutter test --reporter=expanded
```

## 🎯 Patrones de Testing Implementados

### 1. Arrange-Act-Assert (AAA)
Todos los tests siguen el patrón AAA para claridad:
```dart
testWidgets('Debería mostrar título cuando se proporciona', (tester) async {
  // Arrange
  const title = 'Test Title';
  
  // Act
  await tester.pumpWidget(
    MaterialApp(home: CustomCheckboxWidget(title: title))
  );
  
  // Assert
  expect(find.text(title), findsOneWidget);
});
```

### 2. Mocking de Dependencias
```dart
// Mock del repositorio usando clase simple
class MockLocaleRepository implements ILocaleRepository {
  String? _languageCode;
  
  @override
  Future<void> changeLanguageCode(String languageCode) async {
    _languageCode = languageCode;
  }
  
  @override
  Future<String?> findLanguageCode() async => _languageCode;
}
```

### 3. Testing de Estados con Cubit
```dart
testWidgets('Debería cambiar idioma correctamente', (tester) async {
  // Arrange
  final repository = MockLocaleRepository();
  final cubit = LocaleCubit(repository);
  
  // Act
  await cubit.changeLanguage('en');
  
  // Assert
  expect(cubit.state.locale.languageCode, 'en');
  expect(appLocaleCode, 'en');
});
```

### 4. Testing de Widgets con Interacción
```dart
testWidgets('Debería llamar onChanged cuando se toca', (tester) async {
  // Arrange
  bool? result;
  
  // Act
  await tester.pumpWidget(MaterialApp(
    home: CustomCheckboxWidget(
      onChanged: (value) => result = value,
    ),
  ));
  
  await tester.tap(find.byType(Checkbox));
  await tester.pump();
  
  // Assert
  expect(result, true);
});
```

## 📊 Cobertura de Testing

### Componentes Cubiertos ✅
- ✅ LocaleCubit (gestión de idioma)
- ✅ LocaleRepositoryImpl (persistencia)
- ✅ CustomCheckboxWidget (widget personalizado)
- ✅ Autenticación básica (lógica de negocio)
- ✅ Integración de app completa

### Componentes Sugeridos para Futuras Implementaciones 💡
- 🔄 AuthCubit y otros Cubits del proyecto
- 🔄 CustomTextFieldWidget y otros widgets personalizados
- 🔄 Tests de navegación entre pantallas
- 🔄 Tests de APIs reales con mocking de HTTP
- 🔄 Tests de validación de formularios
- 🔄 Tests de persistencia de datos complejos

## 🎨 Características Destacadas

### Uso de Componentes Reales
- Todos los tests usan componentes reales del proyecto, no ejemplos genéricos
- Respetan la arquitectura Cubit-based establecida
- Utilizan los patrones ResultOr<F> y Resource<F,T> reales
- Integran con el sistema de localización real (S.delegate)

### Mocking Inteligente
- Mocks simples sin dependencias externas complejas
- Implementación directa de interfaces del proyecto
- SharedPreferences con setMockInitialValues
- Respeto de los tipos y patrones establecidos

### Testing Comprehensivo
- Estados iniciales y transiciones
- Manejo de errores y casos edge
- Interacciones de usuario reales
- Integración entre capas de la arquitectura

## 🔧 Configuración y Dependencias

Los tests funcionan con las dependencias ya presentes en el proyecto:
- `flutter_test` (incluido por defecto)
- `shared_preferences` (ya en pubspec.yaml)
- `flutter_bloc` (ya en pubspec.yaml)

No se requieren dependencias adicionales como mockito o bloc_test.

## 📝 Notas Importantes

1. **Patrón ResultOr**: Los tests implementan correctamente el uso del patrón ResultOr con el método `.when()` para verificación de tipos de error.

2. **Estados Freezed**: Se respetan los estados generados con Freezed y sus métodos copyWith.

3. **Variables Globales**: Se testea correctamente la variable global `appLocaleCode` que es parte de la arquitectura real.

4. **SharedPreferences**: Se usa el patrón oficial de mocking con `setMockInitialValues`.

5. **Widget Testing**: Se integra correctamente con el sistema de temas y localización del proyecto.

Estos tests proporcionan una base sólida para verificar el funcionamiento correcto de los componentes reales del proyecto Flutter Base y pueden servir como referencia para implementar tests adicionales siguiendo los mismos patrones.
