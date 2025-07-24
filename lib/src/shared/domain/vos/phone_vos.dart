import '../../helpers/either.dart';
import '../../helpers/value_object.dart';
import '../failures/phone_failure.dart';

class PhoneVos extends ValueObject<PhoneFailure, String> {
  @override
  final Either<PhoneFailure, String> value;

  factory PhoneVos(String input, int maxLength) {
    return PhoneVos._(
      _validate(input.trim(), maxLength),
    );
  }
  const PhoneVos._(this.value);

  static Either<PhoneFailure, String> _validate(String input, int maxLength) {
    const phoneRegex = r'^[0-9\s]+$';

    if (input.isEmpty) {
      return left(PhoneFailure.empty());
    }

    if (!RegExp(phoneRegex).hasMatch(input) || input.length < maxLength) {
      return left(PhoneFailure.invalid());
    }

    if (input.length > maxLength) {
      return left(PhoneFailure.tooLong(11));
    }

    return right(input);
  }
}
