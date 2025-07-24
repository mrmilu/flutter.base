part of 'link_encoded_cubit.dart';

@freezed
abstract class LinkEncodedState with _$LinkEncodedState {
  factory LinkEncodedState({
    required ResultOr<ValidateEmailFailure> resultOr,
  }) = _LinkEncodedState;

  factory LinkEncodedState.initial() => _LinkEncodedState(
    resultOr: ResultOr.none(),
  );
}
