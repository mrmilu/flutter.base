import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../shared/helpers/result_or.dart';
import '../../../../shared/presentation/providers/base_cubit.dart';
import '../../../domain/failures/oauth_sign_in_failure.dart';
import '../../../domain/interfaces/i_auth_repository.dart';

part 'signin_social_cubit.freezed.dart';
part 'signin_social_state.dart';

class SigninSocialCubit extends BaseCubit<SigninSocialState> {
  SigninSocialCubit({required this.authRepository})
    : super(SigninSocialState.initial());
  final IAuthRepository authRepository;

  Future<void> signInWithFacebook() async {
    emit(state.copyWith(resultOr: ResultOr.loading()));
    final result = await authRepository.signInWithFacebook();
    emitIfNotDisposed(state.copyWith(resultOr: result));
  }

  Future<void> signInWithGoogle() async {
    emit(state.copyWith(resultOr: ResultOr.loading()));
    final result = await authRepository.signInWithGoogle();
    emitIfNotDisposed(state.copyWith(resultOr: result));
  }

  Future<void> signInWithApple() async {
    emit(state.copyWith(resultOr: ResultOr.loading()));
    final result = await authRepository.signInWithApple();
    emitIfNotDisposed(state.copyWith(resultOr: result));
  }
}
