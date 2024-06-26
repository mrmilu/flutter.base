# flutter_base

## Requirements

- Flutter (see version in ./fvm/fvm_config.json).
  Use [FVM](https://fvm.app/docs/getting_started/installation) to install Flutter versions
- ruby: see [docs](docs/ruby.md)
- [Just](https://github.com/casey/just) to commands
- When build to iOS,
  follow [this steps](https://docs.flutter.dev/get-started/install/macos#install-xcode)
- When build to Android,
  follow [this steps](https://docs.flutter.dev/get-started/install/macos#install-android-studio)

### Commit tools

For this project to work correctly `lefthook` and `node` must be installed in
your computer. We use lefthook to run git hooks and commitlint to lint commit messages.

```bash
# installs lefthook
brew install lefthook

# add needed hooks
lefthook install
```

First time committing node will ask you to install `commitlit`, allow it.

For more info:

- [lefthook](https://github.com/evilmartians/lefthook)
- [commitlint](https://commitlint.js.org/#/)

## Features

This project is a starting point for a Flutter application with the following features:

- Clean Architecture
- Flavors (beta, dev, live)
- Firebase integration (Notifications, Dynamic Links, Social Auth)
- REST ([Dio](https://pub.dev/packages/dio))
- Native launch screen
- App icons configured
- Easy localization
- Routing ([Go Router](https://pub.dev/packages/go_router))
- Forms ([Reactive forms](https://pub.dev/packages/reactive_forms))
- State management with [Riverpod](https://riverpod.dev/)
- Dart define from json file (for env variables on both dart and native code)
- Report bugs service ([Sentry](https://pub.dev/packages/sentry))

## Setup

The following index has a summary of configuration, common errors and how to solve them for each of
the features this base project has:

## Versions

This project uses the following versions and has been tested in this context
(please check if that works with yours):

| Dependency | Version        | Usage                               |
| ---------- | -------------- | ----------------------------------- |
| `flutter`  | `3.19.0`       | `.fmv/fvm_config.json`              |
| `ruby`     | `3.2.4`        | `.ruby-version`                     |
| `fastlane` | `"~> 2.221.1"` | `ios/Gemfile` and `android/Gemfile` |

### Docs

- [flutter_native_splash](docs/flutter_native_splash.md)
- [flutter_launcher_icons](docs/flutter_launcher_icons.md)
- [firebase](docs/firebase.md)
- [sign apps](docs/sign_apps.md)

### TODO Check list

When creating a new project, you need complete the following check-list

- [ ] Rename project and identifier id. To rename from flutter_base to another package name, change
      the pubspec.yml file and all the imports. Also if using Idea IDE's delete the .idea folder and in
      Project Structure... add a new root module to the project root so the IDE can detect the actual
      project.
- [ ] Search for all TODO comments and review and modify if necessary
- [ ] For Dart compile-time variables create `env.flavor.json` per flavor with the following
      structure:
- [ ] ~For iOS to work in CI/CD with Fastlane it's _necessary_ to first manually sign and extract
      the `ExportOptions.plist` file and rename it per flavor in the ios
      folder with the following names: _ios/ExportOptionsLive.plist_ and _ios/ExportOptionsBeta.plist_.
      This is because flutter CLI _can not_ build and manually sign
      iOS apps for now ([flutter issue](https://github.com/flutter/flutter/issues/106612)).
      Follow [this guide](docs/ios_export_options.md) to extract the `ExportOptionsBeta.plist` file.~
      Rolled back to [flutter_config](https://pub.dev/packages/flutter_config) due
      to the removal of `--dart-define-from-file` from Flutter team because it was considered
      a [bug](https://github.com/flutter/flutter/issues/136444)

```.env
APP_NAME="Flutter Base (beta)"
APP_ID="com.flutterbasemrmilu.beta"
API_URL="https://api-staging.flutterbase.me"
SENTRY_DSN="https://xxxxxxxxx@apm.mrmilu.com/xx"
ENVIRONMENT="beta"
FIREBASE_REVERSED_CLIENT_ID="com.googleusercontent.apps.xxxx-xxxxxxxxx"
DYNAMIC_LINK_HOST="flutterbase.page.link"
DYNAMIC_LINKS_URL_TYPE_SCHEMA="com.flutterbasemrmilu.beta"
```

## Run

For almost every action needed in the project there is a command in the `justfile`.

Initial setup can be triggered with the following command `just setup` and then run app
with `just run {flavor}`

### iOS

First time to run on physical iOS device, you need download Apple certificates and provision
profiles. To accomplish this, please follow this steps

- Navigate to ios folder: `cd /ios`
- Execute `fastlane match development --read-only`

### Android

- Request sign files or generate new ones (`upload-keystore-*.jks` and `*.key.properties`) and copy
  them to `android` dir.

## Testing

### Integration Testing - e2e

- We can define e2e test for every flavor.
- All integration tests must be organized in the folder `/integration_test/{flavor}/`

For run test

```bash
 fvm flutter test integration_test/{flavor}/{test_file}.dart --flavor {flavor} -d {deviceId}
```

## Configuration

- Make sure that you add the folder dev inside the ios/Runner folder and inside this brand new folder add the GoogleService-Info.plist that you can find [here]:(https://drive.google.com/drive/u/1/folders/1BoN9jnQgtPYzm3G7h7Jby3T8x3MV3hXG)
- Also make sure that you are using the flutter version from the .fvm folder instead of your default one.
- If you are using vscode as ide feel free to use the configuration from [here](https://drive.google.com/drive/u/1/folders/1GoSIafuhzFpkcYl0fttr77VyYmyfI34S)
