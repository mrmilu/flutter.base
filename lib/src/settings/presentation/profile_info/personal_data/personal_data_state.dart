part of 'personal_data_cubit.dart';

@freezed
abstract class PersonalDataState with _$PersonalDataState {
  factory PersonalDataState({
    required FullnameVos name,
    required FullnameVos lastName,
    required bool showError,
    required ResultOr<PersonalDataFailure> resultOrPersonalData,
  }) = _PersonalDataState;

  factory PersonalDataState.initial() => _PersonalDataState(
    name: FullnameVos(''),
    lastName: FullnameVos(''),
    showError: false,
    resultOrPersonalData: ResultOr.none(),
  );
}
