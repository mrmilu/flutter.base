default:
    just --list

# Show all commands and info
help:
    just --list

# Runs app
run flavor:
    fvm flutter run lib/main_{{flavor}}.dart --flavor {{flavor}}

# Build ios
build-ios flavor:
    fvm flutter build ipa lib/main_{{flavor}}.dart --flavor {{flavor}}

# Build android
build-android flavor:
    fvm flutter build appbundle lib/main_{{flavor}}.dart --flavor {{flavor}}

# Codgen build
codegen:
    fvm flutter pub run build_runner build --delete-conflicting-outputs

# Codegen watch
codegen-watch:
    fvm flutter pub run build_runner watch --delete-conflicting-outputs

# Clean project
clean:
    fvm flutter clean

# Install deps
install-deps:
    fvm flutter pub get
    cd ios/ && pod install

# Clean and get
clean-and-get:
    just clean
    just install-deps

# Generate locales
locales:
    fvm flutter pub run easy_localization:generate -S assets/translations -f keys -O lib/ui/i18n -o locale_keys.g.dart

# Initial project setup
setup:
    fvm flutter precache --ios
    just clean-and-get
    just locales
    just codegen
