# New project checklist

When creating a new project, you need complete the following check-list

- [ ] Rename project and identifier id. To rename from flutter_base to another package name, change
      the pubspec.yml file and all the imports. Also if using Idea IDE's delete the .idea folder and in
      Project Structure... add a new root module to the project root so the IDE can detect the actual
      project.
- [ ] Search for all TODO comments and review and modify if necessary
- [ ] For Dart compile-time variables create `env.[flavor].json` per flavor with the following
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