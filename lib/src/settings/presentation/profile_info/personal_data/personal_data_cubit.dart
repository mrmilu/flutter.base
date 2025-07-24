import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../shared/domain/models/user_model.dart';
import '../../../../shared/domain/vos/fullname_vos.dart';
import '../../../../shared/helpers/extensions.dart';
import '../../../../shared/helpers/result_or.dart';
import '../../../../shared/helpers/value_object.dart';
import '../../../../shared/presentation/providers/global_loader/global_loader_cubit.dart';
import '../../../domain/failures/personal_data_failure.dart';
import '../../../domain/interfaces/i_personal_info_repository.dart';

part 'personal_data_cubit.freezed.dart';
part 'personal_data_state.dart';

class PersonalDataCubit extends Cubit<PersonalDataState> {
  PersonalDataCubit({required this.repository, required this.globalLoaderCubit})
    : super(PersonalDataState.initial());
  final IPersonalInfoRepository repository;
  final GlobalLoaderCubit globalLoaderCubit;

  String beforeName = '';
  String beforeLastName = '';

  void init(UserModel? user) {
    beforeName = user?.name ?? '';
    beforeLastName = user?.lastName ?? '';

    emit(
      state.copyWith(
        name: FullnameVos(beforeName),
        lastName: FullnameVos(beforeLastName),
      ),
    );
  }

  bool isChanged() {
    return state.name.getOrElse('') != beforeName ||
        state.lastName.getOrElse('') != beforeLastName;
  }

  void changeName(String value) {
    emit(state.copyWith(name: FullnameVos(value)));
  }

  void changeLastName(String value) {
    emit(state.copyWith(lastName: FullnameVos(value)));
  }

  bool _allFieldsAreValid() => <ValueObject>[
    state.name,
    state.lastName,
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
        name: state.name.getOrCrash(),
        lastName: state.lastName.getOrCrash(),
        phone: '',
      );
      globalLoaderCubit.hide();
      emit(state.copyWith(resultOrPersonalData: result, showError: true));
    }
    emit(state.copyWith(resultOrPersonalData: ResultOr.none()));
  }
}
