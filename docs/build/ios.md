# Build iOS application

- When build to iOS,
  follow [this steps](https://docs.flutter.dev/get-started/install/macos#install-xcode)

## App sign 

We use [`match`](https://docs.fastlane.tools/actions/match/) generate and store iOS certificates and provision profiles.

## Exporting `ExportOptions.plist`

In order to export the `ExportOptions.plist` to manually sign app through flutter cli in Fastlane archive and export using Xcode.

1 - Select your desired schema (live or beta) and go to "Product > Archive"
2 - Once archiving is finished a window will popup with the created archive. If the window does not open you can access it manually going to "Window > Organizer".
3 - Select archive and select "Distribute App".
4 - A new window will pop up. Select "Custom" and click "Next".
5 - Select the option "App Store Connect" and click "Next".
6 - *Important* in next step select *Export* and wait a couple of seconds and then click again "Next" on the options step (here you can check the desired ones, by default
we will choose all except the one regarding TestFlight internal testing only).
7 - In this step you must select the correct distribution certificate (if you are using match to handle this the default selected one should be ok) and also
the correct provisioning profile (you should have one per flavor). Once selected click "Next" and wait.
8 - Finally hit "Export", select a location (it won't matter much because we only need one file of all the generated ones) and take only the `ExportOptions.plist`
file from the exported directory and put it in `ios/ExportOptions[Flavor].plist`.

*Avoid committing to the repository all the generated files*, the only needed one is the `ExportOptions.plist`.

> *IMPORTANT*: If for some reason you change your certificate or provision profiles (because you add more capabilities or they expire) remember to generate again
> this `ExportOptions.plist` file so your Fastlane scripts keep on working