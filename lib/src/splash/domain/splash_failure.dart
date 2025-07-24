abstract class SplashFailure {
  const SplashFailure();
  factory SplashFailure.internetConextion() = SplashFailureInternetConextion;
  factory SplashFailure.appSettings() = SplashFailureAppSettings;
  factory SplashFailure.internalError() = SplashFailureInternalError;

  void when({
    required void Function(SplashFailureInternetConextion) internetConextion,
    required void Function(SplashFailureAppSettings) appSettings,
    required void Function(SplashFailureInternalError) internalError,
  }) {
    if (this is SplashFailureInternetConextion) {
      internetConextion.call(this as SplashFailureInternetConextion);
    }

    if (this is SplashFailureAppSettings) {
      appSettings.call(this as SplashFailureAppSettings);
    }

    if (this is SplashFailureInternalError) {
      internalError.call(this as SplashFailureInternalError);
    }

    internetConextion.call(this as SplashFailureInternetConextion);
  }

  R map<R>({
    required R Function(SplashFailureInternetConextion) internetConextion,
    required R Function(SplashFailureAppSettings) appSettings,
    required R Function(SplashFailureInternalError) internalError,
  }) {
    if (this is SplashFailureInternetConextion) {
      return internetConextion.call(this as SplashFailureInternetConextion);
    }

    if (this is SplashFailureAppSettings) {
      return appSettings.call(this as SplashFailureAppSettings);
    }

    if (this is SplashFailureInternalError) {
      return internalError.call(this as SplashFailureInternalError);
    }

    return internetConextion.call(this as SplashFailureInternetConextion);
  }

  void maybeWhen({
    void Function(SplashFailureInternetConextion)? internetConextion,
    void Function(SplashFailureAppSettings)? appSettings,
    void Function(SplashFailureInternalError)? internalError,
    required void Function() orElse,
  }) {
    if (this is SplashFailureInternetConextion && internetConextion != null) {
      internetConextion.call(this as SplashFailureInternetConextion);
    }

    if (this is SplashFailureAppSettings && appSettings != null) {
      appSettings.call(this as SplashFailureAppSettings);
    }

    if (this is SplashFailureInternalError && internalError != null) {
      internalError.call(this as SplashFailureInternalError);
    }

    orElse.call();
  }

  R maybeMap<R>({
    R Function(SplashFailureInternetConextion)? internetConextion,
    R Function(SplashFailureAppSettings)? appSettings,
    R Function(SplashFailureInternalError)? internalError,
    required R Function() orElse,
  }) {
    if (this is SplashFailureInternetConextion && internetConextion != null) {
      return internetConextion.call(this as SplashFailureInternetConextion);
    }

    if (this is SplashFailureAppSettings && appSettings != null) {
      return appSettings.call(this as SplashFailureAppSettings);
    }

    if (this is SplashFailureInternalError && internalError != null) {
      return internalError.call(this as SplashFailureInternalError);
    }

    return orElse.call();
  }

  factory SplashFailure.fromString(String value) {
    if (value == 'internetConextion') {
      return SplashFailure.internetConextion();
    }

    if (value == 'appSettings') {
      return SplashFailure.appSettings();
    }

    if (value == 'internalError') {
      return SplashFailure.internalError();
    }

    return SplashFailure.internetConextion();
  }

  @override
  String toString() {
    if (this is SplashFailureInternetConextion) {
      return 'internetConextion';
    }

    if (this is SplashFailureAppSettings) {
      return 'appSettings';
    }

    if (this is SplashFailureInternalError) {
      return 'internalError';
    }

    return 'internetConextion';
  }
}

class SplashFailureInternetConextion extends SplashFailure {}

class SplashFailureAppSettings extends SplashFailure {}

class SplashFailureInternalError extends SplashFailure {}
