# Sistema de Colores - Flutter Base

## 📋 Descripción

Este sistema de colores implementa una arquitectura flexible que permite definir diferentes paletas para temas claro y oscuro, manteniendo una interfaz consistente y fácil de usar.

## 🏗️ Arquitectura

### Estructura de Archivos

```
styles/
├── colors.dart          # Archivo principal que exporta todo
├── colors_base.dart     # Clase abstracta base
├── colors_light.dart    # Implementación tema claro
├── colors_dark.dart     # Implementación tema oscuro
└── README.md           # Esta documentación
```

### Clase Abstracta Base (`colors_base.dart`)
```dart
abstract class AppColors {
  // Define la interfaz común para todos los colores
  Color get primary;
  Color get secondary;
  // ... más colores
  
  // Métodos estáticos de conveniencia
  static AppColorsLight get light => AppColorsLight.instance;
  static AppColorsDark get dark => AppColorsDark.instance;
}
```

### Implementaciones Específicas
- `AppColorsLight` en `colors_light.dart` - Tema claro
- `AppColorsDark` en `colors_dark.dart` - Tema oscuro

## 🎨 Uso Básico

### Importación
```dart
import 'package:flutter_base/src/shared/presentation/utils/styles/colors.dart';
```

El archivo principal `colors.dart` exporta automáticamente todas las clases necesarias.

### 🚀 Acceso Automático a Colores (Recomendado)

#### Opción 1: `AppColors.of(context)` 
```dart
Widget build(BuildContext context) {
  return Container(
    color: AppColors.of(context).primary,  // Se adapta automáticamente al tema
    child: Text(
      'Texto',
      style: TextStyle(color: AppColors.of(context).onBackground),
    ),
  );
}
```

#### Opción 2: Extension `context.colors` (Más Concisa)
```dart
Widget build(BuildContext context) {
  return Container(
    color: context.colors.primary,  // Más corto y limpio
    child: Text(
      'Texto',
      style: TextStyle(color: context.colors.onBackground),
    ),
  );
}
```

#### Opción 3: Con `AppColorsProvider` (Para casos complejos)
```dart
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AppColorsProvider(
      child: MyWidget(),
    );
  }
}

class MyWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final colors = AppColorsInherited.of(context);
    return Container(color: colors.primary);
  }
}
```

### 🎯 Acceso Manual por Tema

Si necesitas acceso específico a un tema:

### 🎯 Acceso Manual por Tema

Si necesitas acceso específico a un tema:

```dart
// Obtener colores para tema claro
final lightColors = AppColors.light;
final primaryColor = lightColors.primary;

// Obtener colores para tema oscuro  
final darkColors = AppColors.dark;
final primaryColor = darkColors.primary;
```

### 📱 Comparación de Métodos

| Método | Sintaxis | Ventajas | Casos de Uso |
|--------|----------|----------|--------------|
| `AppColors.of(context)` | `AppColors.of(context).primary` | Estándar Flutter, explícito | Componentes generales |
| `context.colors` | `context.colors.primary` | Más conciso, fácil de leer | Uso frecuente en widgets |
| `AppColors.light/dark` | `AppColors.light.primary` | Control manual del tema | Casos específicos |
| `AppColorsProvider` | `AppColorsInherited.of(context)` | Control avanzado | Apps complejas |

## 🌈 Categorías de Colores

### Colores Principales
- `primary` - Color primario de la aplicación
- `secondary` - Color secundario 
- `tertiary` - Color terciario

### Colores de Fondo
- `background` - Fondo principal
- `onBackground` - Texto sobre fondo
- `grey` - Gris general
- `disabled` / `onDisabled` - Estados deshabilitados

### Colores Básicos
- `specificBasicBlack` - Negro específico
- `specificBasicWhite` - Blanco específico
- `specificBasicGrey` - Gris específico

### Colores Semánticos
- `specificSemanticError` - Color de error
- `specificSemanticWarning` - Color de advertencia
- `specificSemanticSuccess` - Color de éxito

### Gradientes
- `gradientPrimary` - Gradiente principal
- `gradientSecondary` - Gradiente secundario
- `gradientTertiary` - Gradiente terciario

## 🔧 Integración con Themes

El sistema está completamente integrado con `theme.dart`:

```dart
final lightColorScheme = ColorScheme.light(
  primary: AppColors.light.primary,
  secondary: AppColors.light.secondary,
  // ... más configuraciones
);

final darkColorScheme = ColorScheme.dark(
  primary: AppColors.dark.primary,
  secondary: AppColors.dark.secondary,
  // ... más configuraciones
);
```

## 📱 Ejemplo Práctico

```dart
class MyWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final colors = isDark ? AppColors.dark : AppColors.light;
    
    return Card(
      color: colors.specificSurfaceLow,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Text(
              'Título',
              style: TextStyle(
                color: colors.specificContentHigh,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            Container(
              decoration: BoxDecoration(
                gradient: colors.gradientPrimary,
                borderRadius: BorderRadius.circular(8),
              ),
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: colors.primary,
                  foregroundColor: colors.onPrimary,
                ),
                child: Text('Acción'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
```

## ✨ Ventajas de la Nueva Estructura

1. **Organización**: Código separado en archivos lógicos y manejables
2. **Consistencia**: Una sola fuente de verdad para todos los colores
3. **Flexibilidad**: Fácil cambio entre temas claro y oscuro
4. **Mantenibilidad**: Cambios centralizados se propagan automáticamente
5. **Type Safety**: Dart proporciona verificación de tipos en tiempo de compilación
6. **Autocompletado**: IDE muestra todas las opciones disponibles
7. **Documentación**: Colores organizados por categorías semánticas
8. **Modularidad**: Cada tema puede modificarse independientemente

## 🔄 Migración

La separación en archivos es transparente para el código existente:
- Las importaciones de `colors.dart` siguen funcionando igual
- `AppColors.light.primary` y `AppColors.dark.primary` funcionan como antes
- No se requieren cambios en el código existente

## 🎯 Mejores Prácticas

1. **Importa solo el archivo principal**: `import 'colors.dart'`
2. **Usa lógica dinámica** para seleccionar automáticamente el tema correcto
3. **Categoriza los colores** según su propósito semántico
4. **Mantén consistencia** entre temas claro y oscuro
5. **Documenta cambios** cuando agregues nuevos colores
6. **Prueba en ambos temas** antes de hacer commit
7. **Modifica archivos específicos**: Edita `colors_light.dart` o `colors_dark.dart` según necesites

## 📁 Archivos Relacionados

- `colors_base.dart` - Clase abstracta base
- `colors_light.dart` - Implementación tema claro
- `colors_dark.dart` - Implementación tema oscuro
- `theme.dart` - Integración con themes de Flutter
- `color_usage_example.dart` - Ejemplo de uso completo
