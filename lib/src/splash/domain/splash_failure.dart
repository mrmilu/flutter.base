import 'package:freezed_annotation/freezed_annotation.dart';

import '../../shared/domain/failures/endpoints/general_base_failure.dart';

part 'splash_failure.freezed.dart';

@freezed
abstract class SplashFailure with _$SplashFailure {
  const factory SplashFailure.appSettings({
    @Default('appSettings') String code,
    @Default('Configuración de la aplicación.') String msg,
  }) = SplashFailureAppSettings;

  const factory SplashFailure.general(
    GeneralBaseFailure error,
  ) = SplashFailureGeneral;

  const SplashFailure._();

  String get message => when(
    appSettings: (code, msg) => msg,
    general: (appError) => appError.message,
  );

  dynamic get typeError => when(
    appSettings: (code, msg) => SplashFailure.appSettings(code: code, msg: msg),
    general: (appError) =>
        GeneralBaseFailure.fromString(appError.code, appError.message),
  );

  static SplashFailure fromString(
    String code, [
    String? message,
  ]) {
    return switch (code) {
      'appSettings' => SplashFailure.appSettings(
        msg: message ?? 'Configuración de la aplicación.',
      ),
      _ => SplashFailure.general(
        GeneralBaseFailure.fromString(code, message),
      ),
    };
  }
}
