import 'package:flutter_jungle_core/flutter_jungle_core.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../shared/presentation/providers/base_cubit.dart';
import '../../../shared/presentation/providers/global_loader/global_loader_cubit.dart';
import '../../domain/failures/signin_failure.dart';
import '../../domain/interfaces/i_auth_repository.dart';

part 'forgot_password_cubit.freezed.dart';
part 'forgot_password_state.dart';

class ForgotPasswordCubit extends BaseCubit<ForgotPasswordState> {
  ForgotPasswordCubit({
    required this.authRepository,
    required this.globalLoaderCubit,
  }) : super(ForgotPasswordState.initial());
  final IAuthRepository authRepository;
  final GlobalLoaderCubit globalLoaderCubit;

  void changeEmail(String value) {
    emit(state.copyWith(email: value));
  }

  void changeShowErrors(bool value) {
    emit(state.copyWith(showErrors: value));
  }

  bool _allFieldsAreValid() => state.emailVos.isValid();

  Future<void> forgotPassword() async {
    if (_allFieldsAreValid()) {
      emit(state.copyWith(resultOr: const ResultOr.loading()));
      globalLoaderCubit.show();
      final result = await authRepository.forgotPassword(
        email: state.email,
      );
      globalLoaderCubit.hide();
      emit(state.copyWith(resultOr: result, showErrors: true));
    } else {
      emit(state.copyWith(showErrors: true));
    }
  }
}
