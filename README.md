# flutter_base

## Requirements

- Flutter (see version in ./fvm/fvm_config.json). Use [FVM](https://fvm.app/docs/getting_started/installation) to install Flutter versions
- [Just](https://github.com/casey/just) to commands
- When build to iOS, follow [this steps](https://docs.flutter.dev/get-started/install/macos#install-xcode)
- When build to Android, follow [this steps](https://docs.flutter.dev/get-started/install/macos#install-android-studio)

### Commit tools

For this project to work correctly `lefthook` and `commitlint` must be installed in
your computer. We use lefthook to run git hooks and commitlint to lint commit messages.

```bash
# installs lefthook
brew install lefthook

# add needed hooks
lefthook install

# install commitlint
# node needed in system
npm install -g @commitlint/cli @commitlint/config-conventional
```

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
- Routing (Go Router)
- State management with [Riverpod](https://riverpod.dev/)
- DotEnv and Flutter Config (for env variables on native code)

## Setup

The following index has a summary of configuration, common errors and how to solve them for each of the features this base project has:

### Docs

- [flutter_flavorizr](docs/flutter_flavorizr.md)
- [flutter_native_splash](docs/flutter_native_splash.md)
- [flutter_launcher_icons](docs/flutter_launcher_icons.md)
- [firebase](docs/firebase.md)
- [sign apps](docs/sign_apps.md)

### To do

When create a new project, need complete this checklist

- [ ] Rename project and identifier id. To rename from flutter_base to another package name, change the pubspec.yml file and all the imports. Also if using Idea IDE's delete the .idea folder and in Project Structure... add a new root module to the project root so the IDE can detect the actual project.
- [ ] Search for all TODO comments and review and modify if necessary

## Run

For almost of actions, can be use the setup commands in `justfile`

Initial setup `just setup` and then `just run {flavor}`

### iOS

First time to run on physical iOS device, need download Apple certificates. To acomplish this, please follow this steps

- Navigate to ios folder: `cd /ios`
- Execute `fastlane match development --read-only`

More details on [this documentation](https://www.notion.so/mrmilu/Fastlane-y-Match-0be41150a6fe411cabd60b7d783c80b1#d6069bd171b6451497077e258d5c656f)

## Testing

### Integration Testing - e2e

- We can define e2e test for every flavor. 
- All integration tests must be organized in the folder `/integration_test/{flavor}/`

For run test
```bash
 fvm flutter test integration_test/{flavor}/{test_file}.dart --flavor {flavor} -d {deviceId}
```