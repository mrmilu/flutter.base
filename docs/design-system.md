# Sistema de Diseño

## Introducción

Flutter Base implementa un sistema de diseño robusto y escalable que incluye colores adaptativos, tipografías, componentes reutilizables y temas. Este documento describe todos los elementos del sistema de diseño y cómo utilizarlos correctamente.

## Tabla de Contenidos

- [Colores](#colores)
- [Tipografía](#tipografía)
- [Componentes](#componentes)
- [Temas](#temas)
- [Iconografía](#iconografía)
- [Espaciado](#espaciado)
- [Ejemplos de Uso](#ejemplos-de-uso)

## Colores

### Sistema de Colores Adaptativos

El proyecto utiliza un sistema de colores abstracto que se adapta automáticamente entre temas claro y oscuro.

#### Estructura del Sistema

```dart
// Clase abstracta base
abstract class AppColors {
  // Colores principales
  Color get primary;
  Color get secondary;
  Color get tertiary;
  
  // Colores de fondo
  Color get background;
  Color get onBackground;
  
  // Colores semánticos
  Color get specificSemanticError;
  Color get specificSemanticWarning;
  Color get specificSemanticSuccess;
  
  // Colores de contenido
  Color get specificContentHigh;
  Color get specificContentMid;
  Color get specificContentLow;
  
  // Más colores específicos...
}
```

#### Implementaciones

**Tema Claro (AppColorsLight)**:
```dart
class AppColorsLight extends AppColors {
  static const AppColorsLight _instance = AppColorsLight._internal();
  static AppColorsLight get instance => _instance;
  
  @override
  Color get primary => const Color(0xFF2196F3);
  
  @override
  Color get secondary => const Color(0xFFFF9800);
  
  // Más colores...
}
```

**Tema Oscuro (AppColorsDark)**:
```dart
class AppColorsDark extends AppColors {
  static const AppColorsDark _instance = AppColorsDark._internal();
  static AppColorsDark get instance => _instance;
  
  @override
  Color get primary => const Color(0xFF64B5F6);
  
  @override
  Color get secondary => const Color(0xFFFFB74D);
  
  // Más colores...
}
```

#### Uso de Colores

**Automático (Recomendado)**:
```dart
// Se adapta automáticamente al tema actual
Container(
  color: AppColors.of(context).primary,
  child: Text(
    'Hello World',
    style: TextStyle(
      color: AppColors.of(context).specificContentHigh,
    ),
  ),
)
```

**Con Extension Methods**:
```dart
// Método más conciso usando extensiones
Container(
  color: context.colors.primary,
  child: Text(
    'Hello World',
    style: TextStyle(color: context.colors.specificContentHigh),
  ),
)
```

**Específico de Tema**:
```dart
// Para casos específicos donde necesites un tema particular
Container(
  color: AppColors.light.primary,  // Siempre tema claro
  color: AppColors.dark.primary,   // Siempre tema oscuro
)
```

### Categorías de Colores

#### 1. Colores Principales
- `primary`: Color principal de la marca
- `secondary`: Color secundario
- `tertiary`: Color terciario

#### 2. Colores de Fondo
- `background`: Fondo principal
- `onBackground`: Texto/iconos sobre el fondo
- `grey`: Gris general
- `disabled`: Elementos deshabilitados

#### 3. Colores Semánticos
- `specificSemanticError`: Errores y estados negativos
- `specificSemanticWarning`: Advertencias
- `specificSemanticSuccess`: Éxito y estados positivos

#### 4. Colores de Contenido
- `specificContentHigh`: Texto de alto contraste
- `specificContentMid`: Texto de contraste medio
- `specificContentLow`: Texto de bajo contraste
- `specificContentInverse`: Texto inverso

#### 5. Colores de Superficie
- `specificSurfaceHigh`: Superficies de alto contraste
- `specificSurfaceMid`: Superficies de contraste medio
- `specificSurfaceLow`: Superficies de bajo contraste

#### 6. Colores de Borde
- `specificBorderMid`: Bordes de contraste medio
- `specificBorderLow`: Bordes de bajo contraste

## Tipografía

### Fuentes

El proyecto utiliza la familia tipográfica **ABCDiatype** con diferentes pesos:

```
assets/fonts/
├── abcdiatype-regular.otf        # Regular (400)
├── abcdiatype-regularitalic.otf  # Regular Italic
├── abcdiatype-medium.otf         # Medium (500)
├── abcdiatype-mediumitalic.otf   # Medium Italic
├── abcdiatype-bold.otf           # Bold (700)
└── abcdiatype-bolditalic.otf     # Bold Italic
```

### Configuración en pubspec.yaml

```yaml
flutter:
  fonts:
    - family: ABCDiatype
      fonts:
        - asset: assets/fonts/abcdiatype-regular.otf
          weight: 400
        - asset: assets/fonts/abcdiatype-regularitalic.otf
          weight: 400
          style: italic
        - asset: assets/fonts/abcdiatype-medium.otf
          weight: 500
        - asset: assets/fonts/abcdiatype-mediumitalic.otf
          weight: 500
          style: italic
        - asset: assets/fonts/abcdiatype-bold.otf
          weight: 700
        - asset: assets/fonts/abcdiatype-bolditalic.otf
          weight: 700
          style: italic
```

### Estilos de Texto

```dart
// Estilos predefinidos usando la fuente del proyecto
class AppTextStyles {
  static const String fontFamily = 'ABCDiatype';
  
  // Títulos
  static const TextStyle headingLarge = TextStyle(
    fontFamily: fontFamily,
    fontSize: 32,
    fontWeight: FontWeight.bold,
    height: 1.25,
  );
  
  static const TextStyle headingMedium = TextStyle(
    fontFamily: fontFamily,
    fontSize: 24,
    fontWeight: FontWeight.bold,
    height: 1.3,
  );
  
  static const TextStyle headingSmall = TextStyle(
    fontFamily: fontFamily,
    fontSize: 20,
    fontWeight: FontWeight.w500,
    height: 1.4,
  );
  
  // Cuerpo de texto
  static const TextStyle bodyLarge = TextStyle(
    fontFamily: fontFamily,
    fontSize: 16,
    fontWeight: FontWeight.normal,
    height: 1.5,
  );
  
  static const TextStyle bodyMedium = TextStyle(
    fontFamily: fontFamily,
    fontSize: 14,
    fontWeight: FontWeight.normal,
    height: 1.43,
  );
  
  static const TextStyle bodySmall = TextStyle(
    fontFamily: fontFamily,
    fontSize: 12,
    fontWeight: FontWeight.normal,
    height: 1.33,
  );
  
  // Etiquetas
  static const TextStyle labelLarge = TextStyle(
    fontFamily: fontFamily,
    fontSize: 14,
    fontWeight: FontWeight.w500,
    height: 1.43,
  );
  
  static const TextStyle labelMedium = TextStyle(
    fontFamily: fontFamily,
    fontSize: 12,
    fontWeight: FontWeight.w500,
    height: 1.33,
  );
  
  static const TextStyle labelSmall = TextStyle(
    fontFamily: fontFamily,
    fontSize: 10,
    fontWeight: FontWeight.w500,
    height: 1.4,
  );
}
```

### Uso de Tipografía

```dart
// Usando estilos predefinidos
Text(
  'Título Principal',
  style: AppTextStyles.headingLarge.copyWith(
    color: AppColors.of(context).specificContentHigh,
  ),
)

// Usando Theme.of(context)
Text(
  'Texto del cuerpo',
  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
    color: AppColors.of(context).specificContentMid,
  ),
)
```

## Componentes

### Botones

#### CustomElevatedButton

Botón principal del sistema con diferentes variantes:

```dart
// Botón estándar
CustomElevatedButton(
  onPressed: () {},
  label: 'Botón Principal',
)

// Botón inverso
CustomElevatedButton.inverse(
  onPressed: () {},
  label: 'Botón Secundario',
)

// Botón con loading
CustomElevatedButton(
  onPressed: () {},
  label: 'Guardar',
  isLoading: isLoadingState,
)

// Botón con icono
CustomElevatedButton.withIcon(
  onPressed: () {},
  label: 'Compartir',
  icon: Icons.share,
)
```

#### Variantes de Botones

```dart
components/buttons/
├── custom_elevated_button.dart     # Botón principal
├── custom_outlined_button.dart     # Botón con borde
├── custom_text_button.dart         # Botón de texto
└── custom_icon_button.dart         # Botón de icono
```

### Inputs

#### CustomTextField

Campo de texto estándar del sistema:

```dart
// Campo básico
CustomTextField(
  controller: emailController,
  labelText: 'Email',
  hintText: 'Ingresa tu email',
)

// Campo con validación
CustomTextField(
  controller: passwordController,
  labelText: 'Contraseña',
  obscureText: true,
  validator: (value) {
    if (value?.isEmpty ?? true) {
      return 'Campo requerido';
    }
    return null;
  },
)

// Campo con prefijo/sufijo
CustomTextField(
  controller: phoneController,
  labelText: 'Teléfono',
  prefixIcon: Icons.phone,
  suffixIcon: Icons.clear,
  onSuffixPressed: () => phoneController.clear(),
)
```

#### Variantes de Inputs

```dart
components/inputs/
├── custom_text_field.dart          # Campo de texto básico
├── custom_search_field.dart        # Campo de búsqueda
├── custom_dropdown_field.dart      # Campo dropdown
├── custom_date_field.dart          # Selector de fecha
└── custom_phone_field.dart         # Campo de teléfono
```

### Selectores

#### SelectImageWidget

Widget para selección de imágenes con permisos:

```dart
// Selector para foto de perfil (circular)
SelectImageWidget.profile(
  imagePath: user.profileImageUrl,
  onImageSelected: (XFile? image) {
    // Manejar imagen seleccionada
  },
)

// Selector para imagen general (rectangular)
SelectImageWidget.picture(
  imagePath: currentImagePath,
  onImageSelected: (XFile? image) {
    // Manejar imagen seleccionada
  },
)

// Con builder personalizado
SelectImageWidget(
  imagePath: imagePath,
  onImageSelected: onImageSelected,
  builder: (context, imageProvider, hasImage) {
    return CustomImageWidget(
      imageProvider: imageProvider,
      hasImage: hasImage,
    );
  },
)
```

### Otros Componentes

```dart
components/
├── buttons/                        # Botones diversos
├── checkboxs/                      # Checkboxes personalizados
├── inputs/                         # Campos de entrada
├── radio_buttons/                  # Botones de radio
├── selects/                        # Selectores diversos
├── sliders/                        # Controles deslizantes
├── switchs/                        # Interruptores
├── tags/                          # Etiquetas
└── text/                          # Componentes de texto
```

## Temas

### Configuración de Temas

El proyecto soporta temas claro y oscuro con transición automática:

```dart
// Theme configuration
class AppTheme {
  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    fontFamily: 'ABCDiatype',
    colorScheme: ColorScheme.light(
      primary: AppColors.light.primary,
      secondary: AppColors.light.secondary,
      background: AppColors.light.background,
      surface: AppColors.light.specificSurfaceMid,
      // Más configuraciones...
    ),
    textTheme: _buildTextTheme(AppColors.light),
    elevatedButtonTheme: _buildElevatedButtonTheme(AppColors.light),
    // Más configuraciones de tema...
  );

  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    fontFamily: 'ABCDiatype',
    colorScheme: ColorScheme.dark(
      primary: AppColors.dark.primary,
      secondary: AppColors.dark.secondary,
      background: AppColors.dark.background,
      surface: AppColors.dark.specificSurfaceMid,
      // Más configuraciones...
    ),
    textTheme: _buildTextTheme(AppColors.dark),
    elevatedButtonTheme: _buildElevatedButtonTheme(AppColors.dark),
    // Más configuraciones de tema...
  );
}
```

### Uso de Temas

```dart
// En MaterialApp
MaterialApp(
  theme: AppTheme.lightTheme,
  darkTheme: AppTheme.darkTheme,
  themeMode: ThemeMode.system, // Automático según sistema
  // Más configuración...
)

// Detección manual del tema
bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
AppColors colors = isDarkMode ? AppColors.dark : AppColors.light;
```

## Iconografía

### Iconos del Sistema

El proyecto incluye iconos SVG personalizados organizados por categorías:

```
assets/icons/
├── appliance_*.svg                 # Iconos de electrodomésticos
├── arrow_*.svg                     # Flechas y navegación
├── entity_*.svg                    # Iconos de entidad/marca
├── logo_*.svg                      # Logos de servicios
├── main_*.svg                      # Iconos principales
├── service_*.svg                   # Iconos de servicios
└── top_bar_*.svg                   # Iconos de barra superior
```

### Uso de Iconos

```dart
// Icono SVG
SvgPicture.asset(
  'assets/icons/icon_home.svg',
  width: 24,
  height: 24,
  colorFilter: ColorFilter.mode(
    AppColors.of(context).specificContentHigh,
    BlendMode.srcIn,
  ),
)

// Icono Material
Icon(
  Icons.home,
  color: AppColors.of(context).specificContentHigh,
  size: 24,
)

// En botones
CustomElevatedButton.withIcon(
  icon: Icons.save,
  label: 'Guardar',
  onPressed: () {},
)
```

## Espaciado

### Sistema de Espaciado

```dart
class AppSpacing {
  // Espaciado básico
  static const double xs = 4.0;
  static const double sm = 8.0;
  static const double md = 16.0;
  static const double lg = 24.0;
  static const double xl = 32.0;
  static const double xxl = 48.0;
  
  // Espaciado específico
  static const double cardPadding = 16.0;
  static const double screenPadding = 20.0;
  static const double buttonHeight = 48.0;
  static const double borderRadius = 8.0;
}
```

### Uso de Espaciado

```dart
// Padding
Padding(
  padding: const EdgeInsets.all(AppSpacing.md),
  child: child,
)

// Margin
Container(
  margin: const EdgeInsets.symmetric(
    horizontal: AppSpacing.lg,
    vertical: AppSpacing.sm,
  ),
  child: child,
)

// SizedBox para espaciado
Column(
  children: [
    Widget1(),
    const SizedBox(height: AppSpacing.md),
    Widget2(),
  ],
)
```

## Ejemplos de Uso

### Página Completa con Sistema de Diseño

```dart
class ExamplePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.of(context).background,
      appBar: AppBar(
        title: Text(
          'Ejemplo',
          style: AppTextStyles.headingMedium.copyWith(
            color: AppColors.of(context).specificContentHigh,
          ),
        ),
        backgroundColor: AppColors.of(context).primary,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.md),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Título
              Text(
                'Bienvenido',
                style: AppTextStyles.headingLarge.copyWith(
                  color: AppColors.of(context).specificContentHigh,
                ),
              ),
              const SizedBox(height: AppSpacing.lg),
              
              // Tarjeta
              Container(
                padding: const EdgeInsets.all(AppSpacing.md),
                decoration: BoxDecoration(
                  color: AppColors.of(context).specificSurfaceMid,
                  borderRadius: BorderRadius.circular(AppSpacing.borderRadius),
                  border: Border.all(
                    color: AppColors.of(context).specificBorderLow,
                  ),
                ),
                child: Column(
                  children: [
                    // Icono
                    Icon(
                      Icons.info,
                      size: 48,
                      color: AppColors.of(context).primary,
                    ),
                    const SizedBox(height: AppSpacing.sm),
                    
                    // Texto
                    Text(
                      'Este es un ejemplo del sistema de diseño',
                      style: AppTextStyles.bodyMedium.copyWith(
                        color: AppColors.of(context).specificContentMid,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: AppSpacing.xl),
              
              // Botones
              CustomElevatedButton(
                onPressed: () {},
                label: 'Botón Principal',
              ),
              const SizedBox(height: AppSpacing.md),
              
              CustomElevatedButton.inverse(
                onPressed: () {},
                label: 'Botón Secundario',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
```

### Form con Validación

```dart
class ExampleForm extends StatefulWidget {
  @override
  State<ExampleForm> createState() => _ExampleFormState();
}

class _ExampleFormState extends State<ExampleForm> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          CustomTextField(
            controller: _nameController,
            labelText: 'Nombre',
            validator: (value) {
              if (value?.isEmpty ?? true) {
                return 'El nombre es requerido';
              }
              return null;
            },
          ),
          const SizedBox(height: AppSpacing.md),
          
          CustomTextField(
            controller: _emailController,
            labelText: 'Email',
            keyboardType: TextInputType.emailAddress,
            validator: (value) {
              if (value?.isEmpty ?? true) {
                return 'El email es requerido';
              }
              if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value!)) {
                return 'Email inválido';
              }
              return null;
            },
          ),
          const SizedBox(height: AppSpacing.xl),
          
          CustomElevatedButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                // Procesar formulario
              }
            },
            label: 'Enviar',
          ),
        ],
      ),
    );
  }
}
```

## Mejores Prácticas

### 1. Usa Siempre el Sistema de Colores
```dart
// ✅ Correcto
color: AppColors.of(context).primary

// ❌ Incorrecto
color: Colors.blue
color: Color(0xFF2196F3)
```

### 2. Utiliza los Componentes del Sistema
```dart
// ✅ Correcto
CustomElevatedButton(
  onPressed: onPressed,
  label: 'Guardar',
)

// ❌ Incorrecto
ElevatedButton(
  onPressed: onPressed,
  child: Text('Guardar'),
)
```

### 3. Respeta el Espaciado Definido
```dart
// ✅ Correcto
const SizedBox(height: AppSpacing.md)

// ❌ Incorrecto
const SizedBox(height: 15.0)
```

### 4. Usa la Tipografía del Sistema
```dart
// ✅ Correcto
style: AppTextStyles.bodyLarge.copyWith(
  color: AppColors.of(context).specificContentHigh,
)

// ❌ Incorrecto
style: TextStyle(
  fontSize: 16,
  fontWeight: FontWeight.normal,
)
```

## Checklist del Sistema de Diseño

Al implementar UI, verifica:

- [ ] Usar colores del sistema (AppColors)
- [ ] Aplicar tipografía consistente (AppTextStyles)
- [ ] Utilizar componentes predefinidos
- [ ] Respetar espaciado establecido
- [ ] Verificar adaptabilidad a tema oscuro
- [ ] Usar iconos del sistema cuando sea posible
- [ ] Mantener consistencia visual
- [ ] Verificar accesibilidad y contraste
