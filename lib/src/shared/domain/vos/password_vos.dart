import '../../presentation/helpers/either.dart';
import '../../presentation/helpers/value_object.dart';
import '../failures/password_failure.dart';

class PasswordVos extends ValueObject<PasswordFailure, String> {
  @override
  final Either<PasswordFailure, String> value;
  factory PasswordVos(String input) {
    return PasswordVos._(
      _validate(input.trim()),
    );
  }
  const PasswordVos._(this.value);

  static Either<PasswordFailure, String> _validate(String input) {
    // if (!RegExp(r'^(?=.*[A-Z])(?=.*[a-z])(?=.*[0-9]).*').hasMatch(input)) {
    //   return left(PasswordFailure.required());
    // }

    if (input.length < 8) {
      return left(const PasswordFailure.minLength(length: 8));
    }

    if (!RegExp(r'^(?=.*[A-Z])').hasMatch(input)) {
      return left(const PasswordFailure.includeUppercase());
    }

    if (!RegExp(r'^(?=.*[a-z])').hasMatch(input)) {
      return left(const PasswordFailure.includeLowercase());
    }

    if (!RegExp(r'^(?=.*[!@#$%^&*])').hasMatch(input)) {
      return left(const PasswordFailure.includeDigit());
    }

    return right(input);
  }
}
