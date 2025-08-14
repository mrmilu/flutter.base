import 'package:freezed_annotation/freezed_annotation.dart';

part 'power_failure.freezed.dart';

@freezed
abstract class PowerFailure with _$PowerFailure {
  const factory PowerFailure.empty({
    @Default('empty') String code,
  }) = PowerFailureEmpty;

  const factory PowerFailure.invalid({
    @Default('invalid') String code,
  }) = PowerFailureInvalid;

  const factory PowerFailure.less({
    @Default('less') String code,
  }) = PowerFailureLess;

  const factory PowerFailure.more({
    @Default('more') String code,
  }) = PowerFailureMore;

  const PowerFailure._();
}
