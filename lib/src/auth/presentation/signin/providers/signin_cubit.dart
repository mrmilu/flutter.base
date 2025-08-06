import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../shared/domain/vos/email_vos.dart';
import '../../../../shared/domain/vos/password_vos.dart';
import '../../../../shared/helpers/result_or.dart';
import '../../../../shared/helpers/value_object.dart';
import '../../../../shared/presentation/providers/base_cubit.dart';
import '../../../../shared/presentation/providers/global_loader/global_loader_cubit.dart';
import '../../../../shared/presentation/utils/extensions/buildcontext_extensions.dart';
import '../../../domain/failures/signin_failure.dart';
import '../../../domain/interfaces/i_auth_repository.dart';

part 'signin_cubit.freezed.dart';
part 'signin_state.dart';

class SigninCubit extends BaseCubit<SigninState> {
  SigninCubit({required this.authRepository, required this.globalLoaderCubit})
    : super(SigninState.initial());
  final IAuthRepository authRepository;
  final GlobalLoaderCubit globalLoaderCubit;

  void reset() {
    emit(SigninState.initial());
  }

  void changeEmail(String value) {
    emit(state.copyWith(email: value));
  }

  void changePassword(String value) {
    emit(state.copyWith(password: value));
  }

  void changeShowErrors(bool value) {
    emit(state.copyWith(showErrors: value));
  }

  bool _allFieldsAreValid() => <ValueObject>[
    state.emailVos,
    // state.passwordVos,
  ].areValid;

  void validateEmail() {
    if (state.emailVos.isInvalid()) {
      emit(state.copyWith(showErrors: true));
    } else {
      emit(state.copyWith(showErrors: false));
    }
  }

  Future<void> signin() async {
    if (_allFieldsAreValid()) {
      emitIfNotDisposed(state.copyWith(resultOr: ResultOr.loading()));
      globalLoaderCubit.show();
      final result = await authRepository.signInWithEmailAndPassword(
        email: state.email,
        password: state.password,
      );
      globalLoaderCubit.hide();
      emitIfNotDisposed(state.copyWith(resultOr: result, showErrors: true));
    } else {
      emitIfNotDisposed(state.copyWith(showErrors: true));
    }
    emitIfNotDisposed(state.copyWith(resultOr: ResultOr.none()));
  }
}
