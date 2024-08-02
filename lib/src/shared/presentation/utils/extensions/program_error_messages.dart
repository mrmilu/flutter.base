import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_base/src/shared/presentation/i18n/locale_keys.g.dart';

extension ProgramErrorMessages on Error {
  /// References: https://api.flutter.dev/flutter/dart-core/dart-core-library.html#exceptions
  String getMessage() {
    if (_verifyErrorTypes(ArgumentError)) {
      return LocaleKeys.errors_exceptions_internal_program_argument.tr();
    }
    if (_verifyErrorTypes(RangeError)) {
      return LocaleKeys.errors_exceptions_internal_program_range.tr();
    }
    if (_verifyErrorTypes(StateError)) {
      return LocaleKeys.errors_exceptions_internal_program_state.tr();
    }
    if (_verifyErrorTypes(TypeError)) {
      return LocaleKeys.errors_exceptions_internal_program_type.tr();
    }
    return LocaleKeys.errors_exceptions_internal_program_unknown.tr();
  }

  bool _verifyErrorTypes(Type errorType) =>
      runtimeType.toString() == '${errorType.toString()}Impl' ||
      runtimeType == errorType;
}
