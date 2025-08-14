import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../../shared/domain/vos/password_vos.dart';
import '../../../../../shared/presentation/extensions/buildcontext_extensions.dart';
import '../../../../../shared/presentation/helpers/result_or.dart';
import '../../../../../shared/presentation/helpers/value_object.dart';
import '../../../../../shared/presentation/providers/global_loader/global_loader_cubit.dart';
import '../../../../domain/failures/change_password_failure.dart';
import '../../../../domain/interfaces/i_personal_info_repository.dart';

part 'change_password_cubit.freezed.dart';
part 'change_password_state.dart';

class ChangePasswordCubit extends Cubit<ChangePasswordState> {
  ChangePasswordCubit({
    required this.repository,
    required this.globalLoaderCubit,
  }) : super(ChangePasswordState.initial());
  final IPersonalInfoRepository repository;
  final GlobalLoaderCubit globalLoaderCubit;

  void changeOldPassword(String value) {
    emit(state.copyWith(oldPassword: value));
  }

  void changePassword(String value) {
    emit(state.copyWith(password: value));
  }

  void changePasswordRepeat(String value) {
    emit(state.copyWith(passwordRepeat: value));
  }

  bool _allFieldsAreValid() =>
      <ValueObject>[
        PasswordVos(state.oldPassword),
        PasswordVos(state.password),
      ].areValid &&
      state.password == state.passwordRepeat;

  Future<void> save() async {
    if (!_allFieldsAreValid()) {
      emit(state.copyWith(showError: true));
      return;
    }
    if (_allFieldsAreValid()) {
      emit(state.copyWith(resultOr: ResultOr.loading(), showError: false));
      globalLoaderCubit.show();
      final result = await repository.changePassword(
        oldPassword: state.oldPassword,
        newPassword: state.password,
      );
      globalLoaderCubit.hide();
      emit(state.copyWith(resultOr: result, showError: true));
    }
    emit(state.copyWith(resultOr: ResultOr.none()));
  }
}
