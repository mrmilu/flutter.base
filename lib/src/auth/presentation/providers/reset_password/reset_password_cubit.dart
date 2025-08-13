import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../shared/domain/failures/general_base_failure.dart';
import '../../../../shared/domain/vos/password_vos.dart';
import '../../../../shared/helpers/result_or.dart';
import '../../../../shared/helpers/value_object.dart';
import '../../../../shared/presentation/providers/base_cubit.dart';
import '../../../../shared/presentation/providers/global_loader/global_loader_cubit.dart';
import '../../../../shared/presentation/utils/extensions/buildcontext_extensions.dart';
import '../../../domain/interfaces/i_auth_repository.dart';

part 'reset_password_cubit.freezed.dart';
part 'reset_password_state.dart';

class ResetPasswordCubit extends BaseCubit<ResetPasswordState> {
  ResetPasswordCubit({
    required this.authRepository,
    required this.globalLoaderCubit,
  }) : super(ResetPasswordState.initial());
  final IAuthRepository authRepository;
  final GlobalLoaderCubit globalLoaderCubit;

  void changePassword(String value) {
    emit(state.copyWith(password: value));
  }

  void changeRepeatPassword(String value) {
    emit(state.copyWith(repeatPassword: value));
  }

  void changeShowErrors(bool value) {
    emit(state.copyWith(showErrors: value));
  }

  bool _allFieldsAreValid() =>
      <ValueObject>[
        state.passwordVos,
      ].areValid &&
      state.password == state.repeatPassword;

  Future<void> resetPassword(String token) async {
    if (!_allFieldsAreValid()) {
      emit(state.copyWith(showErrors: true));
      return;
    }
    if (_allFieldsAreValid()) {
      emit(state.copyWith(resultOr: ResultOr.loading()));
      globalLoaderCubit.show();
      final result = await authRepository.resetPassword(
        tokenKey: token,
        newPassword: state.password,
      );
      globalLoaderCubit.hide();
      emit(state.copyWith(resultOr: result, showErrors: true));
    }
    emit(state.copyWith(resultOr: ResultOr.none()));
  }
}
