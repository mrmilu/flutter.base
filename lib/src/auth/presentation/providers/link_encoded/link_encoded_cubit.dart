import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../shared/helpers/result_or.dart';
import '../../../../shared/presentation/providers/base_cubit.dart';
import '../../../../shared/presentation/providers/global_loader/global_loader_cubit.dart';
import '../../../domain/failures/validate_email_failure.dart';
import '../../../domain/interfaces/i_auth_repository.dart';

part 'link_encoded_cubit.freezed.dart';
part 'link_encoded_state.dart';

class LinkEncodedCubit extends BaseCubit<LinkEncodedState> {
  LinkEncodedCubit({
    required this.authRepository,
    required this.globalLoaderCubit,
  }) : super(LinkEncodedState.initial());
  final IAuthRepository authRepository;
  final GlobalLoaderCubit globalLoaderCubit;

  Future<void> linkEncoded(String encodedIdentifier) async {
    emitIfNotDisposed(state.copyWith(resultOr: ResultOr.loading()));
    globalLoaderCubit.show();
    final result = await authRepository.linkEncoded(
      encodedIdentifier: encodedIdentifier,
    );
    globalLoaderCubit.hide();
    emitIfNotDisposed(state.copyWith(resultOr: result));
  }
}
