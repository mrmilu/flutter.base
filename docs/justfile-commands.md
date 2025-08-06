# Flutter Base Justfile Commands 🦀 🚀

Run `just` to display the list of available commands.

## What is just?

`just` is a handy way to save and run project-specific commands. Commands, called recipes, are stored in a file called `justfile` with syntax inspired by `make`.

## Commands List

- `just build-android {{flavor}}`: Build android with the specified flavor (environment).
- `just build-ios {{flavor}}`: Build ios with the specified flavor (environment).
- `just clean`: Cleans the flutter cache.
- `just clean-and-get:`: Performs a clean install.
- `just codegen`: Codgen build.
- `just codegen-watch`: Codegen watch.
- `just e2e-test {{flavor}} {{file}} {{deviceId}}`: Runs the e2e tests.
- `just help`: Show all commands and info.
- `just install-deps`: Installs the dependencies defined in `pubspec.yaml`.
- `just locales`: Generates the locale files.
- `just run {{flavor}}`: Runs app with the specified flavor (environment).
- `just run-release {{flavor}}`: Runs app in release mode with the specified flavor.
- `just setup`: Initial project setup.
- `just test`: Runs the tests.