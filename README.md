# flutter_base

### Requirements

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

### Features

This project is a starting point for a Flutter application with the following features:

- Clean Architecture
- Flavors (beta, live)
- Firebase integration (Notifications, Social Auth)
- REST ([Dio](https://pub.dev/packages/dio))
- Native launch screen
- App icons configured
- Routing (Go Router)
- State management with [Bloc](https://bloclibrary.dev/)
- DotEnv and Flutter Config (for env variables on native code)

The following index has a summary of configuration, common errors and how to solve them for each of the features this base project has:

- [flutter_flavorizr](docs/flutter_flavorizr.md)
- [flutter_native_splash](docs/flutter_native_splash.md)
- [flutter_launcher_icons](docs/flutter_launcher_icons.md)
- [firebase](docs/firebase.md)

For create unions type use this extension from vscode

- Dart Union Class Generator


###  Config new project

1. Edit pubspec.yaml for flavors.
2. Replace Firebase's files in .firebase
3. Run "flutter pub run flutter_flavorizr"
4. Restore files app.dart and main.dart and app/flavorizr.gradle.kts
5. Run "dart run flutter_launcher_icons -f flutter_launcher_icons-beta.yaml"
6. Run "dart run flutter_launcher_icons -f flutter_launcher_icons-live.yaml"
7. Replace package name in fastlane (android and ios)
8. Replace values in IOS-Build Settings to "DYNAMIC_LINKS_URL_TYPE_SCHEMA", "DYNAMIC_LINK_HOST" and "FIREBASE_REVERSED_CLIENT_ID"
9. Replace values in .env.beta and .env.live
10. Ready to start, run "just setup".
