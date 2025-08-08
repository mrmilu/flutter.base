# Internacionalización (i18n)

## Introducción

Flutter Base implementa un **sistema dual de internacionalización** combinando **flutter_intl** para mensajes generados automáticamente y **un sistema personalizado basado en JSON** para contenido dinámico y estructurado. Este enfoque híbrido permite máxima flexibilidad para diferentes tipos de traducciones.

## Tabla de Contenidos

- [Configuración](#configuración)
- [Sistema Dual de Traducciones](#sistema-dual-de-traducciones)
- [Estructura de Archivos](#estructura-de-archivos)
- [Flutter Intl (Mensajes Automáticos)](#flutter-intl-mensajes-automáticos)
- [Sistema JSON Personalizado](#sistema-json-personalizado)
- [Uso en Widgets](#uso-en-widgets)
- [Idiomas Soportados](#idiomas-soportados)
- [Mejores Prácticas](#mejores-prácticas)

## Configuración

### Dependencias

```yaml
# pubspec.yaml
dependencies:
  flutter:
    sdk: flutter
  flutter_localizations:
    sdk: flutter
  intl: ^0.20.2

dev_dependencies:
  intl_utils: ^2.8.11

flutter:
  assets:
    - assets/lang/
    - assets/lang/countries/

flutter_intl:
  enabled: true
  main_locale: es
  arb_dir: lib/src/shared/presentation/l10n
  output_dir: lib/src/shared/presentation/l10n/generated
```

## Sistema Dual de Traducciones

### 1. Flutter Intl (S.of(context))
- **Uso**: Mensajes de error, validaciones, textos técnicos
- **Generación**: Automática desde archivos `.arb`
- **Acceso**: `S.of(context).nombreMensaje` o `context.l10n.nombreMensaje`

### 2. Sistema JSON Personalizado (context.cl)
- **Uso**: Contenido de páginas, navegación, URLs, configuraciones
- **Estructura**: JSON jerárquico organizado por contexto
- **Acceso**: `context.cl.translate('clave.nested.path')`

## Estructura de Archivos

```
lib/src/shared/presentation/l10n/
├── intl_es.arb                 # Mensajes automáticos (español)
├── intl_en.arb                 # Mensajes automáticos (inglés)
├── generated/
│   ├── l10n.dart              # Clase S generada
│   └── intl/                  # Mensajes compilados

assets/lang/
├── es.json                    # Traducciones personalizadas (español)
├── en.json                    # Traducciones personalizadas (inglés)
├── ca.json                    # Traducciones personalizadas (catalán)
├── eu.json                    # Traducciones personalizadas (euskera)
├── gl.json                    # Traducciones personalizadas (gallego)
└── countries/                 # Datos específicos de países
    ├── countries_es.json
    ├── countries_en.json
    ├── countries_ca.json
    ├── countries_eu.json
    └── countries_gl.json
```

## Flutter Intl (Mensajes Automáticos)

### Archivo Principal (intl_es.arb)

```json
{
  "@@locale": "es",
  "extensions": "--------Extensions--------",
  "empty": "Vacío",
  "invalidCups": "CUPS inválido",
  "invalidEmail": "Correo electrónico inválido",
  "invalidPhone": "Teléfono inválido",
  "tooLong": "Demasiado largo",
  "invalidName": "Nombre inválido",
  "tooShort": "Demasiado corto",
  "serverError": "Error del servidor",
  "internalError": "Error interno",
  "unauthorized": "No autorizado",
  "sesionExpired": "Sesión expirada",
  "passwordRequired": "La contraseña debe tener al menos un número y al menos una letra mayúscula y una minúscula.",
  "mismatchedPasswords": "Las contraseñas no coinciden",
  "unknownError": "Error desconocido",
  "cancel": "Cancelar",
  
  "minLength": "Debe contener al menos {minLength} caracteres",
  "@minLength": {
    "placeholders": {
      "minLength": {
        "type": "Object"
      }
    }
  },

  "time_minutes": "{value} minutos",
  "@time_minutes": {
    "placeholders": {
      "value": {
        "type": "Object"
      }
    }
  }
}
```

### Generación de Archivos

```bash
# Generar traducciones desde archivos .arb
flutter packages pub run intl_utils:generate
# Otra forma
just locales
```

## Sistema JSON Personalizado

### Estructura del JSON (es.json)

```json
{
  "languages": {
    "en": "Inglés",
    "es": "Español",
    "ca": "Català",
    "eu": "Euskera",
    "gl": "Galego"
  },
  "urls": {
    "privacyPolicy": "https://niba.es/politica-de-privacidad",
    "termsAndConditions": "https://niba.es/condiciones-legales-de-acceso-y-uso"
  },
  "phones": {
    "support": "900926161"
  },
  "change": "Cambiar",
  "navigation": {
    "home": "Mi Hogar",
    "invoices": "Facturas",
    "efforts": "Gestiones",
    "ente": "Asesor"
  },
  "pages": {
    "auth": {
      "initial": {
        "title": "niba"
      },
      "signIn": {
        "contentEmail": {
          "title": "¡Hola de nuevo!",
          "subtitle": "Accede y sigue disfrutando de todas tus ventajas.",
          "form": {
            "email": "Email",
            "button": "Continuar"
          },
          "socials": {
            "apple": "Iniciar sesión con Apple",
            "google": "Iniciar sesión con Google"
          }
        }
      },
      "forgotPassword": {
        "title": "Recuperar contraseña",
        "subtitle": "Introduce tu email para enviar las instrucciones"
      }
    },
    "mainHome": {
      "title": "¡Hola, {name}!"
    },
    "profileInfoPersonalData": {
      "title": "Datos personales",
      "form": {
        "name": "Nombre",
        "surnames": "Apellidos",
        "phone": "Teléfono"
      }
    }
  },
  "modals": {
    "selectImage": {
      "title": "Seleccionar imagen",
      "gallery": "Galería",
      "camera": "Cámara"
    }
  }
}
```

### CustomLocalization Implementation

```dart
// lib/src/locale/presentation/utils/custom_localization_delegate.dart
class CustomLocalization {
  final Map<String, dynamic> _localizedStrings;

  CustomLocalization(this._localizedStrings);

  /// Traduce una clave a su texto correspondiente.
  /// 
  /// [key] es la clave de la traducción usando notación de punto.
  /// [args] son los argumentos opcionales para interpolar valores.
  ///
  /// Ejemplo:
  /// - translate('pages.mainHome.title', {'name': 'Daniel'}) → '¡Hola, Daniel!'
  /// - translate('navigation.home') → 'Mi Hogar'
  dynamic translate(String key, [Map<String, dynamic>? args]) {
    List<String> keys = key.split('.');
    dynamic value = _localizedStrings;

    for (String k in keys) {
      if (value is Map && value.containsKey(k)) {
        value = value[k];
      } else {
        return key; // Fallback al key original
      }
    }

    if (value is String) {
      if (args != null) {
        args.forEach((argKey, argValue) {
          value = value.replaceAll('{$argKey}', argValue.toString());
        });
      }
      return value;
    }
    return key;
  }

  static Future<CustomLocalization> load(String locale) async {
    late String assetPath;
    late String countryAssetPath;
    
    switch (locale) {
      case 'es':
        assetPath = 'assets/lang/es.json';
        countryAssetPath = 'assets/lang/countries/countries_es.json';
        break;
      case 'en':
        assetPath = 'assets/lang/en.json';
        countryAssetPath = 'assets/lang/countries/countries_en.json';
        break;
      case 'ca':
        assetPath = 'assets/lang/ca.json';
        countryAssetPath = 'assets/lang/countries/countries_ca.json';
        break;
      case 'eu':
        assetPath = 'assets/lang/eu.json';
        countryAssetPath = 'assets/lang/countries/countries_eu.json';
        break;
      case 'gl':
        assetPath = 'assets/lang/gl.json';
        countryAssetPath = 'assets/lang/countries/countries_gl.json';
        break;
      default:
        assetPath = 'assets/lang/es.json';
        countryAssetPath = 'assets/lang/countries/countries_es.json';
    }

    final jsonString = await rootBundle.loadString(assetPath);
    final Map<String, dynamic> jsonMap = json.decode(jsonString);

    final countryJsonString = await rootBundle.loadString(countryAssetPath);
    final Map<String, dynamic> countryJsonMap = json.decode(countryJsonString);

    // Combinar datos de países
    final Map<String, dynamic> countries = jsonMap['countries'] ?? {};
    countries.addAll(countryJsonMap);
    jsonMap['countries'] = countries;

    return CustomLocalization(jsonMap);
  }
}
```

## Uso en Widgets

### Extension Methods para Acceso Rápido

```dart
// lib/src/shared/presentation/utils/extensions/buildcontext_extensions.dart
extension ContextExtension on BuildContext {
  // Acceso a traducciones automáticas
  S get l10n => S.of(this);
  
  // Acceso a traducciones personalizadas
  CustomLocalization get cl => CustomLocalization.of(this);
}
```

### Ejemplo de Uso Dual

```dart
class AuthPageExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Usando sistema personalizado para títulos de página
        title: Text(context.cl.translate('pages.auth.signIn.contentEmail.title')),
      ),
      body: Column(
        children: [
          // Usando sistema personalizado para contenido
          Text(context.cl.translate('pages.auth.signIn.contentEmail.subtitle')),
          
          TextFormField(
            decoration: InputDecoration(
              // Usando sistema personalizado para labels de formulario
              labelText: context.cl.translate('pages.auth.signIn.contentEmail.form.email'),
            ),
            validator: (value) {
              if (value?.isEmpty ?? true) {
                // Usando flutter_intl para mensajes de error
                return context.l10n.empty;
              }
              if (!isValidEmail(value!)) {
                // Usando flutter_intl para validaciones
                return context.l10n.invalidEmail;
              }
              return null;
            },
          ),
          
          ElevatedButton(
            // Usando sistema personalizado para botones
            child: Text(context.cl.translate('pages.auth.signIn.contentEmail.form.button')),
            onPressed: () {
              // Error con flutter_intl
              if (hasError) {
                showToast(context.l10n.serverError);
              }
            },
          ),
        ],
      ),
    );
  }
}
```

### Ejemplo con Interpolación

```dart
class WelcomeWidget extends StatelessWidget {
  final String userName;
  
  const WelcomeWidget({required this.userName, super.key});
  
  @override
  Widget build(BuildContext context) {
    return Text(
      // Interpolación con sistema personalizado
      context.cl.translate('pages.mainHome.title', {'name': userName}),
      style: Theme.of(context).textTheme.headlineMedium,
    );
  }
}
```

### Widget Selector de Idioma

```dart
class LanguageSelector extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DropdownButton<AppLanguageType>(
      items: AppLanguageType.values.map((language) {
        return DropdownMenuItem(
          value: language,
          child: Text(
            // Usando sistema personalizado para nombres de idiomas
            context.cl.translate('languages.${language.name}'),
          ),
        );
      }).toList(),
      onChanged: (language) {
        if (language != null) {
          context.read<LocaleCubit>().changeLanguage(language.name);
        }
      },
    );
  }
}
```

## Idiomas Soportados

### Configuración de Locales

```dart
// Idiomas soportados por flutter_intl
const supportedLocales = [
  Locale('es'), // Español
  Locale('en'), // Inglés  
  Locale('ca'), // Catalán
  Locale('eu'), // Euskera
  Locale('gl'), // Gallego
];

// Enum para manejo de idiomas
enum AppLanguageType {
  es, en, ca, eu, gl;

  String toTranslate(BuildContext context) {
    return context.cl.translate('languages.$name');
  }
}
```

### Configuración en MaterialApp

```dart
class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LocaleCubit, LocaleState>(
      builder: (context, localeState) {
        return MaterialApp.router(
          localizationsDelegates: [
            S.delegate,                                    // Flutter Intl
            CustomLocalizationDelegate(localeState.languageCode), // Sistema personalizado
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          
          supportedLocales: const [
            Locale('es'),
            Locale('en'), 
            Locale('ca'),
            Locale('eu'),
            Locale('gl'),
          ],
          
          locale: Locale(localeState.languageCode),
          
          routerConfig: routerApp,
        );
      },
    );
  }
}
```

## Mejores Prácticas

### 1. Cuándo Usar Cada Sistema

```dart
// ✅ Flutter Intl (S.of / context.l10n) para:
// - Mensajes de error y validación
// - Textos técnicos del sistema
// - Mensajes con pluralización
context.l10n.invalidEmail
context.l10n.serverError
context.l10n.time_minutes(5)

// ✅ Sistema JSON (context.cl) para:
// - Contenido de páginas
// - Navegación y menús
// - URLs y configuraciones
// - Textos con interpolación compleja
context.cl.translate('pages.auth.signIn.title')
context.cl.translate('navigation.home')
context.cl.translate('urls.privacyPolicy')
```

### 2. Organización de Claves JSON

```dart
// ✅ Correcto - Estructura jerárquica
{
  "pages": {
    "auth": {
      "signIn": {
        "title": "Iniciar Sesión",
        "form": {
          "email": "Email",
          "password": "Contraseña"
        }
      }
    }
  }
}

// ❌ Incorrecto - Claves planas
{
  "authSignInTitle": "Iniciar Sesión",
  "authSignInFormEmail": "Email"
}
```

### 3. Manejo de Valores por Defecto

```dart
// ✅ Sistema con fallback robusto
String getTranslation(String key, [Map<String, dynamic>? args]) {
  try {
    return context.cl.translate(key, args);
  } catch (e) {
    // Fallback a la clave original
    return key.split('.').last;
  }
}
```

### 4. Testing de Traducciones

```dart
void main() {
  group('Internationalization Tests', () {
    testWidgets('should load custom translations correctly', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          localizationsDelegates: [
            S.delegate,
            CustomLocalizationDelegate('es'),
            GlobalMaterialLocalizations.delegate,
          ],
          supportedLocales: [Locale('es')],
          home: Builder(
            builder: (context) => Text(
              context.cl.translate('navigation.home'),
            ),
          ),
        ),
      );
      
      expect(find.text('Mi Hogar'), findsOneWidget);
    });

    testWidgets('should handle interpolation correctly', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          localizationsDelegates: [
            CustomLocalizationDelegate('es'),
            GlobalMaterialLocalizations.delegate,
          ],
          home: Builder(
            builder: (context) => Text(
              context.cl.translate('pages.mainHome.title', {'name': 'Juan'}),
            ),
          ),
        ),
      );
      
      expect(find.text('¡Hola, Juan!'), findsOneWidget);
    });
  });
}
```

## Checklist de Internacionalización

### Sistema Flutter Intl:
- [ ] Definir mensajes en `intl_es.arb` (idioma principal)
- [ ] Traducir a todos los idiomas en archivos `.arb` correspondientes
- [ ] Ejecutar `flutter packages pub run intl_utils:generate`
- [ ] Usar `context.l10n.mensaje` para acceder

### Sistema JSON Personalizado:
- [ ] Organizar contenido en estructura jerárquica en `assets/lang/`
- [ ] Mantener consistencia entre todos los archivos de idioma
- [ ] Usar `context.cl.translate('clave.nested')` para acceder
- [ ] Implementar interpolación para valores dinámicos
- [ ] Incluir datos específicos de países cuando sea necesario

### General:
- [ ] Probar todas las traducciones en diferentes idiomas
- [ ] Verificar que no hay claves huérfanas
- [ ] Documentar nuevas claves agregadas
- [ ] Mantener fallbacks apropiados
- [ ] Validar interpolación de variables

- [ ] Definir todas las claves en el archivo principal (intl_es.arb)
- [ ] Agregar descripciones para cada clave
- [ ] Traducir a todos los idiomas soportados
- [ ] Usar pluralización cuando sea necesario
- [ ] Implementar formateo adecuado para fechas y números
- [ ] Probar todas las traducciones en diferentes idiomas
- [ ] Usar extension methods para acceso simplificado
- [ ] Organizar claves por contexto/módulo
- [ ] Documentar nuevas claves agregadas
- [ ] Validar que no hay claves huérfanas
