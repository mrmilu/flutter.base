# flutter_base

### Requirements
For this project to work correctly `lefthook` and `commitlint` must be installed in
your computer. We use lefthook to run git hooks and commitlint to lint commit messages.

```bash
# installs lefthook
brew install lefthook

# add needed hooks
lefthook add commit-msg

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
- Flavors (beta, dev, live)
- Firebase integration (Notifications, Dynamic Links, Social Auth)
- REST ([Dio](https://pub.dev/packages/dio))
- Native launch screen
- App icons configured
- Easy localization
- Routing (Go Router)
- State management with [Riverpod](https://riverpod.dev/)
- DotEnv and Flutter Config (for env variables on native code)

The following index has a summary of configuration, common errors and how to solve them for each of the features this base project has:

- [flutter_flavorizr](docs/flutter_flavorizr.md)
- [flutter_native_splash](docs/flutter_native_splash.md)
- [flutter_launcher_icons](docs/flutter_launcher_icons.md)
- [firebase](docs/firebase.md)

> To rename from flutter_base to another package name, change the pubspec.yml file and all the imports. Also if using Idea IDE's delete the .idea folder
> and in Project Structure... add a new root module to the project root so the IDE can detect the actual project.