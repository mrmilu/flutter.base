part of 'personal_data_cubit.dart';

@freezed
abstract class PersonalDataState with _$PersonalDataState {
  factory PersonalDataState({
    required XFile? imageSelected,
    required String imageUrl,
    required String name,
    required String lastName,
    required bool showError,
    required ResultOr<ChangeUserInfoFailure> resultOrPersonalData,
  }) = _PersonalDataState;

  factory PersonalDataState.initial() => _PersonalDataState(
    imageSelected: null,
    imageUrl: '',
    name: '',
    lastName: '',
    showError: false,
    resultOrPersonalData: ResultOr.none(),
  );

  PersonalDataState._();

  FullnameVos get nameVos => FullnameVos(name);
  FullnameVos get lastNameVos => FullnameVos(lastName);
}
