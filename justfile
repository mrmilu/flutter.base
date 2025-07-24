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

# Clean and get
clean-and-get: 
  just clean
  just install-deps

# Generate locales
locales: 
  fvm flutter pub run intl_utils:generate

# Test
# Note: on macOS you need to have lcov installed on your system (`brew install lcov`) to use this:
test: 
  fvm flutter test --coverage --test-randomize-ordering-seed random
  genhtml coverage/lcov.info -o coverage/html
  open coverage/html/index.html

# e2e test
e2e-test flavor file deviceId: 
  fvm flutter test integration_test/{{flavor}}/{{file}}.dart --flavor {{flavor}} -d {{deviceId}}

# Initial project setup
setup: 
  just clean-and-get
  just locales
  just codegen

generate_openapi:
  openapi-generator generate \
  -i "../fastlight-clientes.api/openapi.yml" \
  -g dart \
  -o ./lib/src/api