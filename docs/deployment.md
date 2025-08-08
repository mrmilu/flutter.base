# Deployment

## Introducción

Este documento describe los procesos de deployment y distribución de Flutter Base para diferentes plataformas y flavors. Incluye configuraciones para desarrollo, testing, staging y producción, así como pipelines de CI/CD y mejores prácticas para releases.

## Tabla de Contenidos

- [Ambientes de Deployment](#ambientes-de-deployment)
- [Android Deployment](#android-deployment)
- [iOS Deployment](#ios-deployment)
- [Web Deployment](#web-deployment)
- [CI/CD Pipeline](#cicd-pipeline)
- [Fastlane Configuration](#fastlane-configuration)
- [Release Management](#release-management)
- [Monitoreo y Analytics](#monitoreo-y-analytics)

## Ambientes de Deployment

### Estructura de Ambientes

```
Development → Testing → Staging → Production
     ↓           ↓         ↓          ↓
   Local      Internal   Beta      Live
  (Debug)     (QA)    (TestFlight) (Stores)
```

### Configuración por Ambiente

| Ambiente | Flavor | Firebase Project | API Endpoint | Purpose |
|----------|--------|-----------------|--------------|---------|
| Development | beta | flutter-base-dev | api-dev.flutterbase.com | Local development |
| Testing | beta | flutter-base-test | api-test.flutterbase.com | Internal QA |
| Staging | beta | flutter-base-staging | api-staging.flutterbase.com | Pre-production testing |
| Production | live | flutter-base-prod | api.flutterbase.com | Public release |

## Android Deployment

### Configuración de Signing

```kotlin
// android/app/build.gradle.kts
android {
    signingConfigs {
        create("release") {
            storeFile = file("../keystore/flutter-base-release.jks")
            storePassword = System.getenv("FLUTTER_BASE_STORE_PASSWORD")
            keyAlias = System.getenv("FLUTTER_BASE_KEY_ALIAS")
            keyPassword = System.getenv("FLUTTER_BASE_KEY_PASSWORD")
        }
        
        create("beta") {
            storeFile = file("../keystore/flutter-base-beta.jks")
            storePassword = System.getenv("FLUTTER_BASE_BETA_STORE_PASSWORD")
            keyAlias = System.getenv("FLUTTER_BASE_BETA_KEY_ALIAS")
            keyPassword = System.getenv("FLUTTER_BASE_BETA_KEY_PASSWORD")
        }
    }

    buildTypes {
        release {
            signingConfig = signingConfigs.getByName("release")
            isMinifyEnabled = true
            isShrinkResources = true
            proguardFiles(
                getDefaultProguardFile("proguard-android-optimize.txt"),
                "proguard-rules.pro"
            )
        }
    }

    productFlavors {
        create("beta") {
            dimension = "version"
            applicationIdSuffix = ".beta"
            versionNameSuffix = "-beta"
            signingConfig = signingConfigs.getByName("beta")
        }
        
        create("live") {
            dimension = "version"
            signingConfig = signingConfigs.getByName("release")
        }
    }
}
```

### Scripts de Build Android

```bash
#!/bin/bash
# scripts/android/build_beta.sh

echo "🤖 Building Android Beta..."

# Clean previous builds
flutter clean
flutter pub get

# Build Beta APK
flutter build apk \
  --flavor beta \
  --target lib/main_beta.dart \
  --release \
  --build-name=$(cat pubspec.yaml | grep version | cut -d ' ' -f 2 | cut -d '+' -f 1) \
  --build-number=$(cat pubspec.yaml | grep version | cut -d ' ' -f 2 | cut -d '+' -f 2)

# Build Beta App Bundle
flutter build appbundle \
  --flavor beta \
  --target lib/main_beta.dart \
  --release \
  --build-name=$(cat pubspec.yaml | grep version | cut -d ' ' -f 2 | cut -d '+' -f 1) \
  --build-number=$(cat pubspec.yaml | grep version | cut -d ' ' -f 2 | cut -d '+' -f 2)

echo "✅ Android Beta build completed!"
echo "📱 APK: build/app/outputs/flutter-apk/app-beta-release.apk"
echo "📦 AAB: build/app/outputs/bundle/betaRelease/app-beta-release.aab"
```

```bash
#!/bin/bash
# scripts/android/build_live.sh

echo "🤖 Building Android Live..."

# Clean previous builds
flutter clean
flutter pub get

# Build Live App Bundle (required for Play Store)
flutter build appbundle \
  --flavor live \
  --target lib/main_live.dart \
  --release \
  --build-name=$(cat pubspec.yaml | grep version | cut -d ' ' -f 2 | cut -d '+' -f 1) \
  --build-number=$(cat pubspec.yaml | grep version | cut -d ' ' -f 2 | cut -d '+' -f 2)

echo "✅ Android Live build completed!"
echo "📦 AAB: build/app/outputs/bundle/liveRelease/app-live-release.aab"
```

### Google Play Console Deployment

```bash
#!/bin/bash
# scripts/android/deploy_play_console.sh

FLAVOR=$1
TRACK=$2  # internal, alpha, beta, production

if [ -z "$FLAVOR" ] || [ -z "$TRACK" ]; then
    echo "Usage: ./deploy_play_console.sh [beta|live] [internal|alpha|beta|production]"
    exit 1
fi

# Upload to Play Console using Fastlane
cd android
bundle exec fastlane deploy_android flavor:$FLAVOR track:$TRACK
cd ..

echo "✅ Deployed to Google Play Console - Track: $TRACK"
```

## iOS Deployment

### Configuración de Signing

```ruby
# ios/fastlane/Fastfile
platform :ios do
  desc "Setup certificates and provisioning profiles"
  lane :setup_signing do |options|
    flavor = options[:flavor] || "beta"
    
    # Match certificates
    match(
      type: "appstore",
      app_identifier: "com.example.flutterbase#{flavor == 'beta' ? '.beta' : ''}",
      force_for_new_devices: true
    )
  end

  desc "Build iOS app"
  lane :build_ios do |options|
    flavor = options[:flavor] || "beta"
    export_method = options[:export_method] || "app-store"
    
    # Setup signing
    setup_signing(flavor: flavor)
    
    # Build the app
    gym(
      scheme: "Runner",
      configuration: "Release-#{flavor}",
      export_method: export_method,
      output_directory: "./build/ios/#{flavor}",
      output_name: "FlutterBase-#{flavor}.ipa"
    )
  end

  desc "Deploy to TestFlight"
  lane :deploy_testflight do |options|
    flavor = options[:flavor] || "beta"
    
    # Build the app
    build_ios(flavor: flavor, export_method: "app-store")
    
    # Upload to TestFlight
    upload_to_testflight(
      ipa: "./build/ios/#{flavor}/FlutterBase-#{flavor}.ipa",
      skip_waiting_for_build_processing: true,
      groups: ["Beta Testers", "Internal Team"]
    )
  end

  desc "Deploy to App Store"
  lane :deploy_appstore do
    # Build live version
    build_ios(flavor: "live", export_method: "app-store")
    
    # Upload to App Store
    upload_to_app_store(
      ipa: "./build/ios/live/FlutterBase-live.ipa",
      force: true,
      submit_for_review: false,
      automatic_release: false
    )
  end
end
```

### Scripts de Build iOS

```bash
#!/bin/bash
# scripts/ios/build_beta.sh

echo "🍎 Building iOS Beta..."

# Clean previous builds
flutter clean
flutter pub get

# Build iOS Beta
flutter build ios \
  --flavor beta \
  --target lib/main_beta.dart \
  --release \
  --build-name=$(cat pubspec.yaml | grep version | cut -d ' ' -f 2 | cut -d '+' -f 1) \
  --build-number=$(cat pubspec.yaml | grep version | cut -d ' ' -f 2 | cut -d '+' -f 2)

# Archive with Fastlane
cd ios
bundle exec fastlane build_ios flavor:beta
cd ..

echo "✅ iOS Beta build completed!"
echo "📱 IPA: ios/build/ios/beta/FlutterBase-beta.ipa"
```

### TestFlight Deployment

```bash
#!/bin/bash
# scripts/ios/deploy_testflight.sh

FLAVOR=$1

if [ -z "$FLAVOR" ]; then
    echo "Usage: ./deploy_testflight.sh [beta|live]"
    exit 1
fi

echo "🚀 Deploying to TestFlight - Flavor: $FLAVOR"

cd ios
bundle exec fastlane deploy_testflight flavor:$FLAVOR
cd ..

echo "✅ Deployed to TestFlight!"
```

## Web Deployment

### Configuración de Build Web

```bash
#!/bin/bash
# scripts/web/build.sh

FLAVOR=$1

if [ -z "$FLAVOR" ]; then
    echo "Usage: ./build.sh [beta|live]"
    exit 1
fi

echo "🌐 Building Web - Flavor: $FLAVOR"

# Build web version
flutter build web \
  --target lib/main_$FLAVOR.dart \
  --release \
  --web-renderer html \
  --base-href "/"

# Create deployment package
mkdir -p dist/$FLAVOR
cp -r build/web/* dist/$FLAVOR/

echo "✅ Web build completed!"
echo "📂 Output: dist/$FLAVOR/"
```

### Firebase Hosting Deployment

```json
# firebase.json
{
  "hosting": [
    {
      "target": "beta",
      "public": "dist/beta",
      "ignore": ["firebase.json", "**/.*", "**/node_modules/**"],
      "rewrites": [
        {
          "source": "**",
          "destination": "/index.html"
        }
      ],
      "headers": [
        {
          "source": "**/*.js",
          "headers": [
            {
              "key": "Cache-Control",
              "value": "max-age=604800"
            }
          ]
        }
      ]
    },
    {
      "target": "live",
      "public": "dist/live",
      "ignore": ["firebase.json", "**/.*", "**/node_modules/**"],
      "rewrites": [
        {
          "source": "**",
          "destination": "/index.html"
        }
      ],
      "headers": [
        {
          "source": "**/*.js",
          "headers": [
            {
              "key": "Cache-Control",
              "value": "max-age=604800"
            }
          ]
        }
      ]
    }
  ]
}
```

```bash
#!/bin/bash
# scripts/web/deploy_firebase.sh

FLAVOR=$1

if [ -z "$FLAVOR" ]; then
    echo "Usage: ./deploy_firebase.sh [beta|live]"
    exit 1
fi

echo "🔥 Deploying to Firebase Hosting - Flavor: $FLAVOR"

# Build web version
./scripts/web/build.sh $FLAVOR

# Deploy to Firebase
firebase deploy --only hosting:$FLAVOR

echo "✅ Deployed to Firebase Hosting!"
echo "🌍 URL: https://flutter-base-$FLAVOR.web.app"
```

## CI/CD Pipeline

### GitHub Actions Configuration

```yaml
# .github/workflows/deploy.yml
name: Deploy Flutter Base

on:
  push:
    branches: [main, develop]
    tags: ['v*']
  pull_request:
    branches: [main, develop]

env:
  FLUTTER_VERSION: '3.19.0'
  JAVA_VERSION: '17'

jobs:
  test:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      
      - name: Setup Flutter
        uses: subosito/flutter-action@v2
        with:
          flutter-version: ${{ env.FLUTTER_VERSION }}
          
      - name: Install dependencies
        run: flutter pub get
        
      - name: Run tests
        run: flutter test --coverage
        
      - name: Upload coverage
        uses: codecov/codecov-action@v3
        with:
          file: coverage/lcov.info

  build_android_beta:
    needs: test
    runs-on: ubuntu-latest
    if: github.ref == 'refs/heads/develop'
    steps:
      - uses: actions/checkout@v4
      
      - name: Setup Flutter
        uses: subosito/flutter-action@v2
        with:
          flutter-version: ${{ env.FLUTTER_VERSION }}
          
      - name: Setup Java
        uses: actions/setup-java@v3
        with:
          distribution: 'zulu'
          java-version: ${{ env.JAVA_VERSION }}
          
      - name: Install dependencies
        run: flutter pub get
        
      - name: Build Android Beta
        run: |
          flutter build appbundle \
            --flavor beta \
            --target lib/main_beta.dart \
            --release
            
      - name: Upload artifacts
        uses: actions/upload-artifact@v3
        with:
          name: android-beta-aab
          path: build/app/outputs/bundle/betaRelease/

  build_ios_beta:
    needs: test
    runs-on: macos-latest
    if: github.ref == 'refs/heads/develop'
    steps:
      - uses: actions/checkout@v4
      
      - name: Setup Flutter
        uses: subosito/flutter-action@v2
        with:
          flutter-version: ${{ env.FLUTTER_VERSION }}
          
      - name: Install dependencies
        run: flutter pub get
        
      - name: Build iOS Beta
        run: |
          flutter build ios \
            --flavor beta \
            --target lib/main_beta.dart \
            --release \
            --no-codesign
            
      - name: Archive iOS app
        run: |
          cd ios
          bundle install
          bundle exec fastlane build_ios flavor:beta
          
      - name: Upload to TestFlight
        env:
          MATCH_PASSWORD: ${{ secrets.MATCH_PASSWORD }}
          FASTLANE_APPLE_APPLICATION_SPECIFIC_PASSWORD: ${{ secrets.FASTLANE_APPLE_APPLICATION_SPECIFIC_PASSWORD }}
        run: |
          cd ios
          bundle exec fastlane deploy_testflight flavor:beta

  deploy_production:
    needs: [test]
    runs-on: ubuntu-latest
    if: startsWith(github.ref, 'refs/tags/v')
    steps:
      - uses: actions/checkout@v4
      
      - name: Setup Flutter
        uses: subosito/flutter-action@v2
        with:
          flutter-version: ${{ env.FLUTTER_VERSION }}
          
      - name: Build Android Live
        run: |
          flutter build appbundle \
            --flavor live \
            --target lib/main_live.dart \
            --release
            
      - name: Deploy to Google Play
        env:
          PLAY_STORE_UPLOAD_KEY: ${{ secrets.PLAY_STORE_UPLOAD_KEY }}
        run: |
          cd android
          bundle exec fastlane deploy_android flavor:live track:production
```

### Bitrise Configuration

```yaml
# bitrise.yml
format_version: '11'
default_step_lib_source: https://github.com/bitrise-io/bitrise-steplib.git

project_type: flutter

workflows:
  deploy_beta:
    description: Deploy Beta version
    steps:
      - activate-ssh-key@4: {}
      - git-clone@6: {}
      - flutter-installer@0:
          inputs:
          - version: 3.19.0
      - cache-pull@2: {}
      - flutter-analyze@0: {}
      - flutter-test@1: {}
      - flutter-build@0:
          inputs:
          - project_location: $BITRISE_FLUTTER_PROJECT_LOCATION
          - platform: android
          - android_additional_params: |
              --flavor beta 
              --target lib/main_beta.dart
      - sign-apk@1:
          inputs:
          - android_app: $BITRISE_APK_PATH
      - google-play-deploy@3:
          inputs:
          - service_account_json_key_path: $BITRISEIO_SERVICE_ACCOUNT_JSON_KEY_URL
          - package_name: com.example.flutterbase.beta
          - track: internal
      - cache-push@2: {}

  deploy_production:
    description: Deploy Production version
    steps:
      - activate-ssh-key@4: {}
      - git-clone@6: {}
      - flutter-installer@0:
          inputs:
          - version: 3.19.0
      - flutter-build@0:
          inputs:
          - platform: android
          - android_additional_params: |
              --flavor live 
              --target lib/main_live.dart
      - sign-apk@1: {}
      - google-play-deploy@3:
          inputs:
          - track: production
          - user_fraction: 0.1
```

## Fastlane Configuration

### Android Fastlane

```ruby
# android/fastlane/Fastfile
platform :android do
  desc "Deploy to Google Play Console"
  lane :deploy_android do |options|
    flavor = options[:flavor] || "beta"
    track = options[:track] || "internal"
    
    # Upload to Google Play
    upload_to_play_store(
      package_name: "com.example.flutterbase#{flavor == 'beta' ? '.beta' : ''}",
      aab: "../build/app/outputs/bundle/#{flavor}Release/app-#{flavor}-release.aab",
      track: track,
      release_status: "draft",
      skip_upload_metadata: true,
      skip_upload_images: true,
      skip_upload_screenshots: true
    )
  end

  desc "Upload to Firebase App Distribution"
  lane :distribute_firebase do |options|
    flavor = options[:flavor] || "beta"
    
    firebase_app_distribution(
      app: "1:123456789:android:#{flavor}appid",
      apk_path: "../build/app/outputs/flutter-apk/app-#{flavor}-release.apk",
      groups: "beta-testers, internal-team",
      release_notes: "Nueva versión beta disponible"
    )
  end
end
```

### iOS Fastlane

```ruby
# ios/fastlane/Fastfile
platform :ios do
  desc "Setup match signing"
  lane :setup_match do |options|
    flavor = options[:flavor] || "beta"
    
    match(
      type: "appstore",
      app_identifier: "com.example.flutterbase#{flavor == 'beta' ? '.beta' : ''}",
      git_url: "https://github.com/yourorg/certificates",
      force_for_new_devices: true
    )
  end

  desc "Build and deploy to TestFlight"
  lane :deploy_testflight do |options|
    flavor = options[:flavor] || "beta"
    
    setup_match(flavor: flavor)
    
    gym(
      scheme: "Runner",
      configuration: "Release-#{flavor}",
      export_method: "app-store"
    )
    
    upload_to_testflight(
      skip_waiting_for_build_processing: true,
      groups: ["Beta Testers"],
      changelog: "Nueva versión beta disponible"
    )
  end

  desc "Deploy to App Store"
  lane :deploy_appstore do
    setup_match(flavor: "live")
    
    gym(
      scheme: "Runner",
      configuration: "Release-live",
      export_method: "app-store"
    )
    
    upload_to_app_store(
      force: true,
      submit_for_review: true,
      automatic_release: false,
      submission_information: {
        add_id_info_limits_tracking: true,
        add_id_info_serves_ads: false,
        add_id_info_tracks_action: true,
        add_id_info_tracks_install: true,
        add_id_info_uses_idfa: true,
        content_rights_has_rights: true,
        content_rights_contains_third_party_content: true,
        export_compliance_platform: 'ios',
        export_compliance_compliance_required: false,
        export_compliance_encryption_updated: false,
        export_compliance_app_type: nil,
        export_compliance_uses_encryption: false,
        export_compliance_is_exempt: false,
        export_compliance_contains_third_party_cryptography: false,
        export_compliance_contains_proprietary_cryptography: false
      }
    )
  end
end
```

## Release Management

### Versioning Strategy

```bash
# Semantic Versioning: MAJOR.MINOR.PATCH+BUILD_NUMBER
# Example: 1.2.3+42

# scripts/version_bump.sh
#!/bin/bash

BUMP_TYPE=$1  # major, minor, patch

if [ -z "$BUMP_TYPE" ]; then
    echo "Usage: ./version_bump.sh [major|minor|patch]"
    exit 1
fi

# Get current version
CURRENT_VERSION=$(grep 'version:' pubspec.yaml | cut -d ' ' -f 2 | cut -d '+' -f 1)
CURRENT_BUILD=$(grep 'version:' pubspec.yaml | cut -d ' ' -f 2 | cut -d '+' -f 2)

# Calculate new version
IFS='.' read -ra VERSION_PARTS <<< "$CURRENT_VERSION"
MAJOR=${VERSION_PARTS[0]}
MINOR=${VERSION_PARTS[1]}
PATCH=${VERSION_PARTS[2]}

case $BUMP_TYPE in
    major)
        MAJOR=$((MAJOR + 1))
        MINOR=0
        PATCH=0
        ;;
    minor)
        MINOR=$((MINOR + 1))
        PATCH=0
        ;;
    patch)
        PATCH=$((PATCH + 1))
        ;;
esac

NEW_VERSION="$MAJOR.$MINOR.$PATCH"
NEW_BUILD=$((CURRENT_BUILD + 1))

# Update pubspec.yaml
sed -i '' "s/version: .*/version: $NEW_VERSION+$NEW_BUILD/" pubspec.yaml

echo "Version updated: $CURRENT_VERSION+$CURRENT_BUILD → $NEW_VERSION+$NEW_BUILD"

# Create git tag
git add pubspec.yaml
git commit -m "Bump version to $NEW_VERSION+$NEW_BUILD"
git tag "v$NEW_VERSION"

echo "Git tag created: v$NEW_VERSION"
```

### Release Notes Generation

```bash
#!/bin/bash
# scripts/generate_release_notes.sh

TAG=$1

if [ -z "$TAG" ]; then
    LATEST_TAG=$(git describe --tags --abbrev=0)
    PREVIOUS_TAG=$(git describe --tags --abbrev=0 $LATEST_TAG^)
else
    LATEST_TAG=$TAG
    PREVIOUS_TAG=$(git describe --tags --abbrev=0 $TAG^)
fi

echo "# Release Notes - $LATEST_TAG"
echo ""
echo "## Changes since $PREVIOUS_TAG"
echo ""

# Generate changelog
git log --pretty=format:"- %s (%an)" $PREVIOUS_TAG..$LATEST_TAG

echo ""
echo ""
echo "## Download"
echo ""
echo "- [Android APK](link-to-apk)"
echo "- [iOS TestFlight](link-to-testflight)"
echo ""
echo "---"
echo "Generated on $(date)"
```

## Monitoreo y Analytics

### Error Monitoring con Sentry

El proyecto integra Sentry directamente en `main.dart` para captura automática de errores y un helper para manejo manual:

```dart
// main.dart - Inicialización de Sentry
await SentryFlutter.init(
  (options) {
    options.dsn = kReleaseMode ? env.sentryDSN : '';
    options.debug = kDebugMode;
    options.tracesSampleRate = 0.1;
    options.environment = F.name;
    options.release = 'flutter-base@${env.appVersion}';
    options.enableAutoSessionTracking = true;
    options.attachStacktrace = true;
    options.enableAutoNativeBreadcrumbs = true;
  },
  appRunner: () => runApp(MyApp()),
);

// lib/src/shared/helpers/error_monitoring.dart
import 'package:sentry_flutter/sentry_flutter.dart';

class ErrorMonitoring {
  /// Capturar excepción con contexto adicional
  static void captureException(
    Object error,
    StackTrace trace, {
    Map<String, Object?>? extra,
  }) {
    addBreadcrumb(error, extra: extra);
    Sentry.captureException(error, stackTrace: trace);
  }

  /// Agregar breadcrumb para debugging
  static void addBreadcrumb(Object error, {Map<String, Object?>? extra}) {
    Sentry.addBreadcrumb(
      Breadcrumb(
        message: error.toString(),
        data: {'error-code': 'no error code'}..addAll(extra ?? {}),
        level: SentryLevel.error,
      ),
    );
  }
}
```

**Navegación con observadores de Sentry:**
```dart
// lib/src/shared/presentation/router/app_router.dart
GoRouter _router = GoRouter(
  observers: [
    SentryNavigatorObserver(), // Tracking automático de navegación
  ],
  // ... resto de configuración
);
```

### Firebase Analytics con MyAnalyticsHelper

Wrapper personalizado con soporte para App Tracking Transparency y eventos de ecommerce:

```dart
// lib/src/shared/helpers/analytics_helper.dart
import 'package:app_tracking_transparency/app_tracking_transparency.dart';
import 'package:firebase_analytics/firebase_analytics.dart';

class MyAnalyticsHelper {
  static FirebaseAnalytics get _analytics => FirebaseAnalytics.instance;
  static bool _isInitialized = false;
  
  /// Inicializar con App Tracking Transparency (iOS)
  static Future<void> initialize({bool enableInDebug = false}) async {
    try {
      // Solicitar autorización de tracking en iOS
      final status = await AppTrackingTransparency.requestTrackingAuthorization();
      bool appTrackingEnabled = status == TrackingStatus.authorized;
      
      // Habilitar analytics solo en release con autorización o en debug si se especifica
      bool enableAnalytics = (kReleaseMode && appTrackingEnabled) || enableInDebug;
      await _analytics.setAnalyticsCollectionEnabled(enableAnalytics);
      
      _isInitialized = true;
    } catch (e) {
      // Error handling con logging
    }
  }
  
  /// Gestión de usuario
  static Future<void> setUserId(String? userId) async {
    if (!_isInitialized) return;
    await _analytics.setUserId(id: userId);
  }
  
  static Future<void> clearUserId() async {
    await setUserId(null);
  }
  
  /// Tracking de pantallas
  static Future<void> logScreenView({
    required String screenName,
    String? screenClass,
  }) async {
    await _analytics.logScreenView(
      screenName: screenName,
      screenClass: screenClass,
    );
  }
  
  /// Eventos de ecommerce predefinidos
  static Future<void> logEvent({required CheckoutEvent name}) async {
    if (!_isInitialized) return;
    
    switch (name) {
      case CheckoutEvent.viewItemList:
        await _analytics.logViewItemList();
      case CheckoutEvent.addToCart:
        await _analytics.logAddToCart();
      case CheckoutEvent.beginCheckout:
        await _analytics.logBeginCheckout();
      case CheckoutEvent.addShippingInfo:
        await _analytics.logAddShippingInfo();
      case CheckoutEvent.addPaymentInfo:
        await _analytics.logAddPaymentInfo();
      case CheckoutEvent.purchase:
        await _analytics.logPurchase();
    }
  }
  
  /// Métodos de conveniencia para eventos específicos
  static Future<void> logViewItemList() async {
    await logEvent(name: CheckoutEvent.viewItemList);
  }
  
  static Future<void> logAddToCart() async {
    await logEvent(name: CheckoutEvent.addToCart);
  }
  
  static Future<void> logBeginCheckout() async {
    await logEvent(name: CheckoutEvent.beginCheckout);
  }
  
  static Future<void> logAddShippingInfo() async {
    await logEvent(name: CheckoutEvent.addShippingInfo);
  }
  
  static Future<void> logAddPaymentInfo() async {
    await logEvent(name: CheckoutEvent.addPaymentInfo);
  }
  
  static Future<void> logPurchase() async {
    await logEvent(name: CheckoutEvent.purchase);
  }
}

/// Enum para eventos de checkout predefinidos
enum CheckoutEvent {
  viewItemList,    // Llegada a página de productos
  addToCart,       // Selección de producto
  beginCheckout,   // Continuar tras datos personales
  addShippingInfo, // Continuar tras CUPS + dirección
  addPaymentInfo,  // Continuar tras DNI + IBAN
  purchase,        // Después de firmar contrato
}
```

**Configuración de usuario en Auth:**
```dart
// lib/src/auth/presentation/providers/auth/auth_cubit.dart
// Al hacer login exitoso
await MyAnalyticsHelper.setUserId(user.id);
await Sentry.configureScope((scope) => scope.setUser(
  SentryUser(id: user.id, email: user.email),
));

// Al hacer logout
await MyAnalyticsHelper.clearUserId();
await Sentry.configureScope((scope) => scope.setUser(null));
```

## Checklist de Deployment

### Pre-deployment

- [ ] Ejecutar todos los tests
- [ ] Verificar coverage de tests
- [ ] Actualizar version en pubspec.yaml
- [ ] Generar release notes
- [ ] Verificar configuraciones por flavor
- [ ] Validar signing certificates
- [ ] Probar build en dispositivos locales

### Android Deployment

- [ ] Build APK/AAB sin errores
- [ ] Verificar signing configuration
- [ ] Probar instalación en dispositivos
- [ ] Upload a Play Console
- [ ] Configurar release notes
- [ ] Definir porcentaje de rollout

### iOS Deployment

- [ ] Build IPA sin errores
- [ ] Verificar provisioning profiles
- [ ] Upload a TestFlight
- [ ] Configurar grupos de beta testing
- [ ] Enviar para App Store review (si es producción)

### Post-deployment

- [ ] Monitorear crash reports
- [ ] Verificar analytics
- [ ] Revisar logs de error
- [ ] Validar métricas de performance
- [ ] Recolectar feedback de usuarios
- [ ] Documentar issues conocidos
