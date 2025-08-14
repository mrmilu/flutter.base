import '../../presentation/helpers/either.dart';
import '../../presentation/helpers/value_object.dart';
import '../failures/email_failure.dart';

class EmailVos extends ValueObject<EmailFailure, String> {
  @override
  final Either<EmailFailure, String> value;

  factory EmailVos(String input) {
    return EmailVos._(
      _validate(input.trim()),
    );
  }
  const EmailVos._(this.value);

  static Either<EmailFailure, String> _validate(String input) {
    const emailRegex =
        r"""^[a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]([a-zA-Z0-9.-]*[a-zA-Z0-9])?(\.[a-zA-Z0-9]([a-zA-Z0-9-]*[a-zA-Z0-9])?)*\.[a-zA-Z]{2,}$""";

    if (input.isEmpty) {
      return left(const EmailFailure.empty());
    }

    if (!RegExp(emailRegex).hasMatch(input)) {
      return left(const EmailFailure.invalid());
    }

    return right(input);
  }
}
