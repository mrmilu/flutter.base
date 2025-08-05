# Development environmnet setup

## Requirements

- [FVM](https://fvm.app/docs/getting_started/installation) to install Flutter versions
- [rbenv](https://github.com/rbenv/rbenv)
- [Just](https://github.com/casey/just) to commands

## Install Ruby

```bash
$ RUBY_VERSION=$(cat .ruby-version)
$ rbenv install $RUBY_VERSION
$ rbenv use $RUBY_VERSION
$ gem intall bundle
```

## Commit tools

For this project to work correctly `lefthook` and `node` must be installed in
your computer. We use lefthook to run git hooks and commitlint to lint commit messages.

```bash
# installs lefthook
brew install lefthook

# add needed hooks
lefthook install
```

First time committing node will ask you to install `commitlit`, allow it.

For more info:

- [lefthook](https://github.com/evilmartians/lefthook)
- [commitlint](https://commitlint.js.org/#/)

## Initial setup

Initial setup can be triggered with the following command:

```shell
`just setup`
```

## Physical devices setup

### iOS

First time to run on physical iOS device, you need download Apple certificates and provision
profiles. To accomplish this, please follow this steps

- Navigate to ios folder: `cd /ios`
- Execute `fastlane match development --read-only`

### Android

- Request sign files or generate new ones (`upload-keystore-*.jks` and `*.key.properties`) and copy
  them to `android` dir.

## Additional setup steps

- Make sure that you add the folder dev inside the ios/Runner folder and inside this brand new folder add the GoogleService-Info.plist that you can find [here]:(https://drive.google.com/drive/u/1/folders/1BoN9jnQgtPYzm3G7h7Jby3T8x3MV3hXG)
- Also make sure that you are using the flutter version from the `.fvm` folder instead of your default one.
- If you are using `vscode` as your editor, feel free to use the configuration from [here](https://drive.google.com/drive/u/1/folders/1GoSIafuhzFpkcYl0fttr77VyYmyfI34S). These configuration files includes a `settings.json` that sets up some useful `fvm` configuration to pull from the correct flutter sdk and exclude some files from the watch list and a `launch.json` file that provides some launch options for different flavors.