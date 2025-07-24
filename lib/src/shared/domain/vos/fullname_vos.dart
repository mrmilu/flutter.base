import '../../helpers/either.dart';
import '../../helpers/value_object.dart';
import '../failures/fullname_failure.dart';

class FullnameVos extends ValueObject<FullnameFailure, String> {
  @override
  final Either<FullnameFailure, String> value;

  factory FullnameVos(String input) {
    return FullnameVos._(
      _validate(input.trim()),
    );
  }
  const FullnameVos._(this.value);

  static Either<FullnameFailure, String> _validate(String input) {
    const userNameRegex = r'^[ña-zÑA-ZÀ-ÿ]{2,}(?: [ña-zÑA-ZÀ-ÿ]+){0,3}$';

    if (input.isEmpty) {
      return left(FullnameFailure.empty());
    }

    if (!RegExp(userNameRegex).hasMatch(input)) {
      return left(FullnameFailure.invalid());
    }

    if (input.length > 30) {
      return left(FullnameFailure.tooLong(30));
    }

    return right(input);
  }
}
