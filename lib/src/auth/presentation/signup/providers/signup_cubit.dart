import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../shared/domain/vos/email_vos.dart';
import '../../../../shared/domain/vos/fullname_vos.dart';
import '../../../../shared/domain/vos/password_vos.dart';
import '../../../../shared/presentation/extensions/iterable_extension.dart';
import '../../../../shared/presentation/helpers/result_or.dart';
import '../../../../shared/presentation/helpers/value_object.dart';
import '../../../../shared/presentation/providers/global_loader/global_loader_cubit.dart';
import '../../../domain/failures/signup_failure.dart';
import '../../../domain/interfaces/i_auth_repository.dart';
import '../../providers/auth/auth_cubit.dart';

part 'signup_cubit.freezed.dart';
part 'signup_state.dart';

class SignupCubit extends Cubit<SignupState> {
  SignupCubit({
    required this.authRepository,
    required this.authCubit,
    required this.globalLoaderCubit,
  }) : super(SignupState.initial());
  final IAuthRepository authRepository;
  final AuthCubit authCubit;
  final GlobalLoaderCubit globalLoaderCubit;

  void reset() {
    emit(SignupState.initial());
  }

  void changeName(String value) {
    emit(state.copyWith(name: value));
  }

  void changeLastName(String value) {
    emit(state.copyWith(lastName: value));
  }

  void changeEmail(String value) {
    emit(state.copyWith(email: value));
  }

  void changePassword(String value) {
    emit(state.copyWith(password: value));
  }

  void changeRepeatPassword(String value) {
    emit(state.copyWith(repeatPassword: value));
  }

  void changeAgreeTerms(bool value) {
    emit(state.copyWith(agreeTerms: value));
  }

  void changeShowErrors(bool value) {
    emit(state.copyWith(showErrors: value));
  }

  bool _allFieldsAreValid() =>
      <ValueObject>[
        state.emailVos,
        state.passwordVos,
      ].areValid &&
      state.password == state.repeatPassword;

  void validateEmail() {
    if (state.emailVos.isInvalid()) {
      emit(state.copyWith(showErrors: true));
    } else {
      emit(state.copyWith(showErrors: false));
    }
  }

  Future<void> signUp() async {
    if (!_allFieldsAreValid()) {
      emit(state.copyWith(showErrors: true));
      return;
    }
    if (_allFieldsAreValid()) {
      emit(state.copyWith(resultOr: ResultOr.loading(), showErrors: false));
      globalLoaderCubit.show();
      final result = await authRepository.signUp(
        email: state.email,
        password: state.password,
      );
      globalLoaderCubit.hide();
      emit(state.copyWith(resultOr: result, showErrors: true));
    }
    emit(state.copyWith(resultOr: ResultOr.none()));
  }
}
