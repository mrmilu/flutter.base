import '../../presentation/helpers/either.dart';
import '../../presentation/helpers/value_object.dart';
import '../failures/fullname_failure.dart';

class DescriptionVos extends ValueObject<FullnameFailure, String> {
  @override
  final Either<FullnameFailure, String> value;

  factory DescriptionVos(String input) {
    return DescriptionVos._(
      _validate(input.trim()),
    );
  }
  const DescriptionVos._(this.value);

  static Either<FullnameFailure, String> _validate(String input) {
    if (input.isEmpty) {
      return left(const FullnameFailure.empty());
    }

    if (input.length > 320) {
      return left(const FullnameFailure.tooLong(length: 320));
    }

    return right(input);
  }
}
