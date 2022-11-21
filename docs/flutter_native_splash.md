# flutter_native_splash

## Second splash screen inside flutter

To make a clean transition between the image in the native splash screen (which
waits to flutter initialization) and the second splash screen inside flutter (shown while making application related stuff in background)
we must add our native image as a [resolution aware asset](https://flutter.dev/docs/development/ui/assets-and-images#resolution-aware).

For this we must do the following:

### Android

In your `android/app/src/main/res/drawable-mdpi` folder, you will have a `splash.png`.
This is your 1x image. [reference](https://developer.android.com/training/multiscreen/screendensities)
Copy that to your app's assets folder.
Then copy the `splash.png` in `android/app/src/main/res/drawable-hdpi` to a subfolder in your app's assets folder named `1.5x`.
Do the same for the rest of the folders. The mapping should be:

- `mdpi` → `assets`
- `hdpi` → `assets/1.5x`
- `xhdpi` → `assets/2.0x`
- `xxhdpi` → `assets/3.0x`
- `xxxhdpi` → `assets/4.0x`

### iOS

If you have followed previous android steps that's enough because iOS app will only
use `splash.png`, `splash@2x.png` and `splash@3x.png`.

Also if you have already set up flavors make sure that the contents from
`ios/Runner/Base.Iproj/LaunchScreen.storyboard` are the same from those flavor launch screens:

- `ios/Runner/devLaunchScreen.storyboard`
- `ios/Runner/betaLaunchScreen.storyboard`
- `ios/Runner/liveLaunchScreen.storyboard`

## Caveat

There is a fade transition between the native splash and the secondary splash screen
that up to day there is not a good solution to disable it, neither for android nor for iOS.
This fade transition can create a slight flicker between the native splash and second splash screen
(more perceptible in simulators). One way to camouflage this is to add a custom background to
the secondary splash screen to make the fade transition fancier.
