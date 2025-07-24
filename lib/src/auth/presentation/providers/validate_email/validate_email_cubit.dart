import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../shared/helpers/result_or.dart';
import '../../../../shared/presentation/providers/base_cubit.dart';
import '../../../../shared/presentation/providers/global_loader/global_loader_cubit.dart';
import '../../../domain/failures/validate_email_failure.dart';
import '../../../domain/interfaces/i_auth_repository.dart';

part 'validate_email_cubit.freezed.dart';
part 'validate_email_state.dart';

class ValidateEmailCubit extends BaseCubit<ValidateEmailState> {
  ValidateEmailCubit({
    required this.authRepository,
    required this.globalLoaderCubit,
  }) : super(ValidateEmailState.initial());
  final IAuthRepository authRepository;
  final GlobalLoaderCubit globalLoaderCubit;

  Future<void> validateEmail(String token) async {
    emitIfNotDisposed(state.copyWith(resultOr: ResultOr.loading()));
    globalLoaderCubit.show();
    final result = await authRepository.validateEmail(
      token: token,
    );
    globalLoaderCubit.hide();
    emitIfNotDisposed(state.copyWith(resultOr: result));
  }

  Future<void> resendEmail() async {
    await authRepository.resendVerificationEmail();
  }
}
