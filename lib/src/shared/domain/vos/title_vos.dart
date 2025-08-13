import '../../helpers/either.dart';
import '../../helpers/value_object.dart';
import '../failures/fullname_failure.dart';

class TitleVos extends ValueObject<FullnameFailure, String> {
  @override
  final Either<FullnameFailure, String> value;

  factory TitleVos(String input) {
    return TitleVos._(
      _validate(input.trim()),
    );
  }
  const TitleVos._(this.value);

  static Either<FullnameFailure, String> _validate(String input) {
    if (input.isEmpty) {
      return left(const FullnameFailure.empty());
    }

    if (input.length > 50) {
      return left(const FullnameFailure.tooLong(length: 50));
    }

    return right(input);
  }
}
