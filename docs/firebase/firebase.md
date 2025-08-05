# Firebase iOS and Android

Follow next steps for firebase manual installation:

## Requirements

- Create [Firebase project](https://console.firebase.google.com/) for each enviroment
- **Android**: Follow the steps [here](https://firebase.flutter.dev/docs/manual-installation/android) but **don't add yet the
  `google-services.json` file**, download it.
  - Add SHA:1 certificates fingerprints to firebase configuration
  - Add SHA:1 from Google Play too.
- **iOS**: add your app to your firebase project and download
the `GoogleService-Info.plist` file.

## Config

- Copy config files on each flavor folder.
- Config with Xcode to add this files
- So be sure to have a clean git commit
and once command finishes leave the changes made in:

- `ios/Runner.xcodeproj/project.pbxproj`
- `android/app/src/{flavor}/google-services.json`

## Other features

- [authentication](firebase_authentication.md)
- [dynamic links](firebase_dynamic_links.md)
