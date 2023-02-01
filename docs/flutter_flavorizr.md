# flutter_flavorizr

## iOS issues

If you get any error or something like the following:

```bash
    diff: /Podfile.lock: No such file or directory
    diff: /Manifest.lock: No such file or directory
    error: The sandbox is not in sync with the Podfile.lock. Run 'pod install' or update your CocoaPods installation.
    note: Using new build system
    note: Planning build
    note: Constructing build description
```

Make sure that the configuration is correct following the next steps:

## `***.xcconfig` files

- Files must have the following include at the top

```shell
#include "Pods/Target Support Files/Pods-Runner/Pods-Runner.<destination>.xcconfig"
```

Guarantee that each *debug* and *release* flavor file has it. For example: `betaDebug.xxconfig`
and `betaRelease.xxconfig` should have in the top the import replacing the `<destination>` tag with
either *release-beta* or *debug-beta*.

- Also, they must have the correct `FLUTTER_TARGET` as the name of your main files for each flavor.
  For example:

```shell
FLUTTER_TARGET=lib/main.beta.dart
```

### XCode config

For some reason in some flutter projects the plugin might change the Base SDK in Xcode for your *Runner* project to `iphoneos`. This is wrong and must be changed to iOS like the following image:

![Build settings](https://github.com/mrmilu/flutter_base/blob/master/docs/flutter_flavorizr_1.png)

Also, inside the tabs info in the *Runner* project (not target) the flavor configuration is wrong.

It should *NOT* look like the following image:

![Wrong info tab Runner project config](https://github.com/mrmilu/flutter_base/blob/master/docs/flutter_flavorizr_2.png)

It *SHOULD* look like this one:

![Right info tab Runner project config](https://github.com/mrmilu/flutter_base/blob/master/docs/flutter_flavorizr_3.png)

Basically the new config must be set to the *Runner* *target* and not the project.

> **Note**:
> If you intend on modifying your flavor configs make sure to first have a clean commit
> so when you run the flutter_flavorizr script you can easily detect which files changed
