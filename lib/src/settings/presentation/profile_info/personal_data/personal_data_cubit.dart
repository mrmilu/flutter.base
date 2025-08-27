import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../shared/domain/models/user_model.dart';
import '../../../../shared/domain/vos/fullname_vos.dart';
import '../../../../shared/presentation/extensions/iterable_extension.dart';
import '../../../../shared/presentation/helpers/result_or.dart';
import '../../../../shared/presentation/helpers/value_object.dart';
import '../../../../shared/presentation/providers/global_loader/global_loader_cubit.dart';
import '../../../domain/failures/change_user_info_failure.dart';
import '../../../domain/interfaces/i_personal_info_repository.dart';

part 'personal_data_cubit.freezed.dart';
part 'personal_data_state.dart';

class PersonalDataCubit extends Cubit<PersonalDataState> {
  PersonalDataCubit({required this.repository, required this.globalLoaderCubit})
    : super(PersonalDataState.initial());
  final IPersonalInfoRepository repository;
  final GlobalLoaderCubit globalLoaderCubit;

  String beforeImageUrl = '';
  String beforeName = '';
  String beforeLastName = '';

  void init(UserModel? user) {
    beforeImageUrl = user?.imageUrl ?? '';
    beforeName = user?.name ?? '';
    beforeLastName = user?.lastName ?? '';

    emit(
      state.copyWith(
        imageUrl: beforeImageUrl,
        name: beforeName,
        lastName: beforeLastName,
      ),
    );
  }

  bool isChanged() {
    return state.name != beforeName ||
        state.lastName != beforeLastName ||
        state.imageUrl != beforeImageUrl;
  }

  void changeImage(XFile? image) {
    emit(state.copyWith(imageSelected: image, imageUrl: image?.path ?? ''));
  }

  void changeName(String value) {
    emit(state.copyWith(name: value));
  }

  void changeLastName(String value) {
    emit(state.copyWith(lastName: value));
  }

  bool _allFieldsAreValid() => <ValueObject>[
    state.nameVos,
    state.lastNameVos,
  ].areValid;

  Future<void> save() async {
    if (!_allFieldsAreValid()) {
      emit(state.copyWith(showError: true));
      return;
    }
    if (_allFieldsAreValid()) {
      emit(
        state.copyWith(
          resultOrPersonalData: ResultOr.loading(),
          showError: false,
        ),
      );
      globalLoaderCubit.show();
      final result = await repository.setPersonalData(
        name: state.name,
        lastName: state.lastName,
        phone: '',
      );
      globalLoaderCubit.hide();
      emit(state.copyWith(resultOrPersonalData: result, showError: true));
    }
    emit(state.copyWith(resultOrPersonalData: ResultOr.none()));
  }
}
