import '../../presentation/helpers/either.dart';
import '../../presentation/helpers/value_object.dart';
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
    const userNameRegex = r'^[ña-zÑA-ZÀ-ÿ]{2,}(?: [ña-zÑA-ZÀ-ÿ]{2,}){0,3}$';

    if (input.isEmpty) {
      return left(const FullnameFailure.empty());
    }

    if (!RegExp(userNameRegex).hasMatch(input)) {
      return left(const FullnameFailure.invalid());
    }

    if (input.length > 30) {
      return left(const FullnameFailure.tooLong(length: 30));
    }

    return right(input);
  }
}
