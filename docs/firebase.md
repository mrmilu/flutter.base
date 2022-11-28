# Firebase iOS and Android

Follow the following steps for firebase manual installation:

- Required: [Firebase project](https://console.firebase.google.com/) created for each enviroment
- **Android**: Follow the steps [here](https://firebase.flutter.dev/docs/manual-installation/android) but **don't add yet the
  `google-services.json` file**, just download it.
  - Add SHA:1 and SHA:256 certificates fingerprints to [firebase configuration](https://console.firebase.google.com/project/flutterbase-beta/settings/general/android:com.flutterbase.beta)
- **iOS**: just add your app to your firebase project and download
the `GoogleService-Info.plist` file.

Then configure the `pubspec.yaml` flavor like this creating the corresponding folders:

```yaml
flavorizr:
  app:
    android:
      flavorDimensions: "flavor-type"
    ios:

  flavors:
    apple:
      app:
        name: "Apple App"

      android:
        applicationId: "com.example.apple"
        firebase:
          config: ".firebase/apple/google-services.json"

      ios:
        bundleId: "com.example.apple"
        firebase:
          config: ".firebase/apple/GoogleService-Info.plist"

    banana:
      app:
        name: "Banana App"
        
      android:
        applicationId: "com.example.banana"
        firebase:
          config: ".firebase/banana/google-services.json"
      ios:
        bundleId: "com.example.banana"
        firebase:
          config: ".firebase/banana/GoogleService-Info.plist"
```

After this run the following command:

```bash
flutter pub run flutter_flavorizr -p google:firebase
```

If this command fails to work run:

```bash
flutter pub run flutter_flavorizr
```

This will execute all the `flavorizr` process. So be sure to have a clean git commit
and once command finishes just leave the changes made in:

- `ios/Runner.xcodeproj/project.pbxproj`
- `android/app/src/{flavor}/google-services.json`
