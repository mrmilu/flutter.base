import '../../presentation/helpers/either.dart';
import '../../presentation/helpers/value_object.dart';
import '../failures/power_failure.dart';

class PowerVos extends ValueObject<PowerFailure, String> {
  final double min;
  final double max;

  @override
  final Either<PowerFailure, String> value;

  factory PowerVos(String input, {required double min, required double max}) {
    return PowerVos._(
      _validate(input.trim(), min, max),
      min,
      max,
    );
  }
  const PowerVos._(this.value, this.min, this.max);

  static Either<PowerFailure, String> _validate(
    String input,
    double min,
    double max,
  ) {
    if (input.isEmpty) {
      return left(const PowerFailure.empty());
    }

    final value = double.tryParse(input.replaceAll(',', '.'));

    if (value == null) {
      return left(const PowerFailure.invalid());
    }

    if (value < min) {
      return left(const PowerFailure.less());
    }

    if (value > max) {
      return left(const PowerFailure.more());
    }

    return right(input);
  }
}
