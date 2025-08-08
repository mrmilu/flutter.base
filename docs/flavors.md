# Flavors

## Introducción

Flutter Base implementa un sistema de **flavors** (sabores) que permite tener múltiples configuraciones de la aplicación desde un mismo código base. Los flavors permiten tener diferentes configuraciones para desarrollo, testing, staging y producción, cada uno con sus propias configuraciones de API, iconos, nombres de aplicación y configuraciones específicas.

## Tabla de Contenidos

- [Flavors Disponibles](#flavors-disponibles)
- [Configuración de Flavors](#configuración-de-flavors)
- [Archivos de Configuración](#archivos-de-configuración)
- [Build y Deployment](#build-y-deployment)
- [Variables de Entorno](#variables-de-entorno)
- [Iconos y Assets](#iconos-y-assets)

## Flavors Disponibles

Flutter Base incluye los siguientes flavors configurados:

### 1. Beta (Desarrollo/Testing)
- **Propósito**: Desarrollo, testing interno y QA
- **API**: Entorno de desarrollo/staging
- **Firebase**: Proyecto Firebase de desarrollo
- **Icono**: Versión beta con badge distintivo
- **Nombre**: Flutter Base Beta

### 2. Live (Producción)
- **Propósito**: Aplicación en producción para usuarios finales
- **API**: Entorno de producción
- **Firebase**: Proyecto Firebase de producción
- **Icono**: Icono oficial de la aplicación
- **Nombre**: Flutter Base

## Configuración de Flavors

### Archivo Principal de Flavors

```dart
// lib/flavors.dart
enum Flavor {
  beta,
  live,
}

class F {
  static late final Flavor appFlavor;

  static String get name => appFlavor.name;

  static String get title {
    switch (appFlavor) {
      case Flavor.beta:
        return 'FlutterBase (Beta)';
      case Flavor.live:
        return 'FlutterBase';
    }
  }
}
```

### Punto de Entrada Principal

```dart
// lib/main.dart
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

import 'app.dart';
import 'flavors.dart';
import 'src/shared/helpers/analytics_helper.dart';

Future<void> main() async {
  // Configurar flavor desde variable de entorno
  F.appFlavor = Flavor.values.firstWhere(
    (element) => element.name == appFlavor,
  );

  // Cargar variables de entorno específicas del flavor
  await dotenv.load(fileName: '.env.${F.name}');
  final env = EnvVars();

  await SentryFlutter.init(
    (options) {
      options.dsn = kReleaseMode ? env.sentryDSN : '';
      options.environment = env.environment;
      options.debug = false;
    },
    appRunner: () async {
      WidgetsFlutterBinding.ensureInitialized();

      await Firebase.initializeApp();

      // Inicializar servicios
      await Future.wait([
        appFlyerService!.init(),
        PushNotificationService.initialize(),
        MyAnalyticsHelper.initialize(enableInDebug: !kReleaseMode),
      ]);

      runApp(const App());
    },
  );
}
```


## Archivos de Configuración

### Configuración Android

El proyecto utiliza **flutter_flavorizr** para generar automáticamente las configuraciones de flavors:

```kotlin
// android/app/flavorizr.gradle.kts
import com.android.build.gradle.AppExtension

val android = project.extensions.getByType(AppExtension::class.java)

android.apply {
    flavorDimensions("flavor-type")

    productFlavors {
        create("beta") {
            dimension = "flavor-type"
            applicationId = "com.flutterbase.beta"
            signingConfig = signingConfigs.getByName("release_beta")
            resValue(type = "string", name = "app_name", value = "FlutterBase (Beta)")
        }
        create("live") {
            dimension = "flavor-type"
            applicationId = "com.flutterbase.live"
            signingConfig = signingConfigs.getByName("release_live")
            resValue(type = "string", name = "app_name", value = "FlutterBase")
        }
    }
}
```

```kotlin
// android/app/build.gradle.kts
android {
    signingConfigs {
        create("release_beta") {
            keyAlias = betaKeystoreProperties["keyAlias"] as String?
            keyPassword = betaKeystoreProperties["keyPassword"] as String?
            storeFile = betaKeystoreProperties["storeFile"]?.let { file(it as String) }
            storePassword = betaKeystoreProperties["storePassword"] as String?
        }
        create("release_live") {
            keyAlias = liveKeystoreProperties["keyAlias"] as String?
            keyPassword = liveKeystoreProperties["keyPassword"] as String?
            storeFile = liveKeystoreProperties["storeFile"]?.let { file(it as String) }
            storePassword = liveKeystoreProperties["storePassword"] as String?
        }
    }

    defaultConfig {
        applicationId = "com.flutterbase.live.flutter_base"
        minSdk = 24
        targetSdk = 35
        versionCode = flutter.versionCode
        versionName = flutter.versionName
        resourceConfigurations.addAll(listOf("es", "en", "ca", "eu", "gl"))
    }

    // Aplicar configuración de flavors generada
    apply { from("flavorizr.gradle.kts") }
}
}
```

### Configuración iOS

```ruby
# ios/fastlane/Fastfile
platform :ios do
  desc "Build Beta"
  lane :build_beta do
    gym(
      scheme: "Runner",
      configuration: "Release-beta",
      export_method: "development",
      output_directory: "./build/ios"
    )
  end

  desc "Build Live"
  lane :build_live do
    gym(
      scheme: "Runner",
      configuration: "Release-live",
      export_method: "app-store",
      output_directory: "./build/ios"
    )
  end
end
```

## Build y Deployment

### Justfile (Herramienta de Build)

El proyecto utiliza **just** como herramienta de automatización de builds:

```makefile
# justfile
default: 
  just --list

# Show all commands and info
help: 
  just --list

# Runs app
run flavor: 
  fvm flutter run lib/main.dart --flavor {{flavor}}

# Runs app release
run-release flavor:
  fvm flutter run lib/main.dart --flavor {{flavor}} --release

# Build ios
build-ios flavor: 
  fvm flutter build ipa lib/main.dart --flavor {{flavor}}

# Build android
build-android flavor:
  fvm flutter build appbundle lib/main.dart --flavor {{flavor}}

# Build APK
build-apk flavor:
  fvm flutter build apk lib/main.dart --flavor {{flavor}}
```

### Comandos de Ejecución

```bash
# Desarrollo
just run beta          # Ejecutar flavor Beta
just run live           # Ejecutar flavor Live

# Release
just run-release beta   # Ejecutar Beta en modo release
just run-release live   # Ejecutar Live en modo release

# Builds
just build-android beta # Build AAB para Beta
just build-android live # Build AAB para Live
just build-ios beta     # Build IPA para Beta
just build-ios live     # Build IPA para Live
just build-apk beta     # Build APK para Beta
just build-apk live     # Build APK para Live
```

### Configuración VS Code

```json
// .vscode/launch.json
{
  "version": "0.2.0",
  "configurations": [
    {
      "name": "Beta Debug",
      "request": "launch",
      "type": "dart",
      "flutterMode": "debug",
      "args": ["--flavor", "beta"],
      "program": "lib/main.dart"
    },
    {
      "name": "Live Debug",
      "request": "launch",
      "type": "dart",
      "flutterMode": "debug",
      "args": ["--flavor", "live"],
      "program": "lib/main.dart"
    },
    {
      "name": "Beta Release",
      "request": "launch",
      "type": "dart",
      "flutterMode": "release",
      "args": ["--flavor", "beta"],
      "program": "lib/main.dart"
    },
    {
      "name": "Live Release",
      "request": "launch",
      "type": "dart",
      "flutterMode": "release",
      "args": ["--flavor", "live"],
      "program": "lib/main.dart"
    }
  ]
}
```

## Variables de Entorno

### Variables de Entorno Específicas por Flavor

```env
# .env.beta
ENVIRONMENT="beta"
APP_ID="com.flutterbase.beta"
APP_NAME="Flutterbase (beta)"
API_URL_RELEASE="https://api-staging.flutterbase.me"
API_URL_DEBUG="https://api-staging.flutterbase.me"
SENTRY_DSN="https://********@apm.mrmilu.com/65"
DYNAMIC_LINK_HOST="flutterbase-beta.onelink.me"
DYNAMIC_LINKS_URL_TYPE_SCHEMA="com.flutterbase.beta"
FIREBASE_CLIENT_ID_IOS=426720039629-53dtb81m2jij0kp9c96idol3ss7fcn1s.apps.googleusercontent.com
FIREBASE_CLIENT_ID_ANDROID=207594948627-92u3japjs3v36j7tc9870tgu4ikkjab8.apps.googleusercontent.com
AF_DEV_KEY=U8NspWEUmXq2gyooKmCKAi
APP_ID_ANDROID=com.flutterbase.beta
APP_ID_IOS=6743158965
```

```env
# .env.live
ENVIRONMENT="live"
APP_ID="com.flutterbase.live"
APP_NAME="Flutterbase (live)"
API_URL_RELEASE="https://api-staging.flutterbase.me"
API_URL_DEBUG="https://api-staging.flutterbase.me"
SENTRY_DSN="https://********@apm.mrmilu.com/65"
DYNAMIC_LINK_HOST="flutterbase-live.onelink.me"
DYNAMIC_LINKS_URL_TYPE_SCHEMA="com.flutterbase.live"
FIREBASE_CLIENT_ID_IOS=795134483527-ip95dpf1p3580e5sb8putaa479qrpugj.apps.googleusercontent.com
FIREBASE_CLIENT_ID_ANDROID=1023902896915-92ve4o59uhtofb12a9h5f60jnc596v2i.apps.googleusercontent.com
AF_DEV_KEY=U8NspWEUmXq2gyooKmCKAi
APP_ID_ANDROID=com.flutterbase.live
APP_ID_IOS=6743159220
```

### Uso en HTTP Client

```dart
// lib/src/shared/data/services/http_client.dart
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

// Configuración base del cliente HTTP
final baseOptions = BaseOptions(
  baseUrl: (kReleaseMode
          ? dotenv.env['API_URL_RELEASE']
          : dotenv.env['API_URL_DEBUG']) ??
      'https://flutterbase.com',
  headers: {
    'Content-Type': 'application/json; charset=utf-8',
  },
);

class AuthInterceptor extends Interceptor {
  final ITokenRepository tokenRepository;
  
  AuthInterceptor({required this.tokenRepository});

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final userToken = await tokenRepository.getToken();

    if (userToken != null) {
      final version = appVersion;
      final appLanguage = appLocaleCode;
      
      options.headers.addAll(<String, String>{
        'Authorization': 'token $userToken',
        'Accept-Language': appLanguage,
        'App-Version': version,
        'App-Language': appLanguage,
      });
    }

    return super.onRequest(options, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    // Manejo de errores 401 y refresh token
    if (err.response?.statusCode == 401 && !request.extra.containsKey('retry')) {
      try {
        final newToken = await tokenRepository.refreshToken();
        if (newToken != null) {
          request.extra['retry'] = true;
          request.headers['Authorization'] = 'token $newToken';
          final clonedRequest = await Dio().fetch(request);
          return handler.resolve(clonedRequest);
        }
      } catch (e) {
        // Limpiar token y redirigir al login
        await tokenRepository.clear();
        // Navegar a login
      }
    }
    super.onError(err, handler);
  }
}

// Factory para crear el cliente HTTP
Dio getMyHttpClient(ITokenRepository tokenRepository) {
  final httpClient = Dio(baseOptions)
    ..interceptors.add(
      AuthInterceptor(tokenRepository: tokenRepository),
    );

  return httpClient;
}
```

## Iconos y Assets

### Configuración de Iconos

```yaml
# flutter_launcher_icons-beta.yaml
flutter_icons:
  android: "launcher_icon"
  ios: true
  image_path: "assets/launcher_icon/icon-beta.png"
  min_sdk_android: 21
  web:
    generate: true
    image_path: "assets/launcher_icon/icon-beta.png"
    background_color: "#hexcode"
    theme_color: "#hexcode"
  windows:
    generate: true
    image_path: "assets/launcher_icon/icon-beta.png"
    icon_size: 48
  macos:
    generate: true
    image_path: "assets/launcher_icon/icon-beta.png"
```

```yaml
# flutter_launcher_icons-live.yaml
flutter_icons:
  android: "launcher_icon"
  ios: true
  image_path: "assets/launcher_icon/icon-live.png"
  min_sdk_android: 21
  web:
    generate: true
    image_path: "assets/launcher_icon/icon-live.png"
    background_color: "#hexcode"
    theme_color: "#hexcode"
  windows:
    generate: true
    image_path: "assets/launcher_icon/icon-live.png"
    icon_size: 48
  macos:
    generate: true
    image_path: "assets/launcher_icon/icon-live.png"
```

### Comandos para Generar Iconos

```bash
# Generar iconos para Beta
flutter packages pub run flutter_launcher_icons:main -f flutter_launcher_icons-beta.yaml

# Generar iconos para Live
flutter packages pub run flutter_launcher_icons:main -f flutter_launcher_icons-live.yaml
```

### Assets Específicos por Flavor

```
assets/
├── images/
│   ├── beta/               # Imágenes específicas para Beta
│   │   ├── splash_logo.png
│   │   └── beta_badge.png
│   └── live/               # Imágenes específicas para Live
│       ├── splash_logo.png
│       └── promo_banner.png
├── launcher_icon/
    ├── icon-beta.png       # Icono para Beta
    └── icon-live.png       # Icono para Live

```

## Checklist de Flavors

Al configurar flavors:

- [ ] Definir flavors en `flavors.dart`
- [ ] Crear puntos de entrada separados (`main_beta.dart`, `main_live.dart`)
- [ ] Configurar flavors en Android (`build.gradle.kts`)
- [ ] Configurar schemes en iOS
- [ ] Crear archivos Firebase Options separados
- [ ] Configurar iconos específicos por flavor
- [ ] Definir variables de entorno por flavor
- [ ] Implementar feature flags
- [ ] Configurar scripts de build
- [ ] Documentar comandos de ejecución
- [ ] Probar builds en todas las plataformas
