import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../shared/domain/failures/endpoints/general_base_failure.dart';
import '../../../shared/domain/vos/password_vos.dart';
import '../../../shared/presentation/extensions/iterable_extension.dart';
import '../../../shared/presentation/helpers/result_or.dart';
import '../../../shared/presentation/helpers/value_object.dart';
import '../../../shared/presentation/providers/global_loader/global_loader_cubit.dart';
import '../../domain/interfaces/i_auth_repository.dart';

part 'reset_password_cubit.freezed.dart';
part 'reset_password_state.dart';

class ResetPasswordCubit extends Cubit<ResetPasswordState> {
  ResetPasswordCubit({
    required this.authRepository,
    required this.globalLoaderCubit,
  }) : super(ResetPasswordState.initial());
  final IAuthRepository authRepository;
  final GlobalLoaderCubit globalLoaderCubit;

  void changePassword(String value) {
    emit(state.copyWith(password: value));
  }

  void changePasswordRepeat(String value) {
    emit(state.copyWith(passwordRepeat: value));
  }

  bool _allFieldsAreValid() =>
      <ValueObject>[
        PasswordVos(state.password),
      ].areValid &&
      state.password == state.passwordRepeat;

  Future<void> save(String tokenKey) async {
    if (!_allFieldsAreValid()) {
      emit(state.copyWith(showError: true));
      return;
    }
    if (_allFieldsAreValid()) {
      emit(state.copyWith(resultOr: ResultOr.loading(), showError: false));
      globalLoaderCubit.show();
      final result = await authRepository.resetPassword(
        tokenKey: tokenKey,
        newPassword: state.password,
      );
      globalLoaderCubit.hide();
      emit(state.copyWith(resultOr: result, showError: true));
    }
    emit(state.copyWith(resultOr: ResultOr.none()));
  }
}
