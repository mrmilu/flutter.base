import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../shared/presentation/helpers/result_or.dart';
import '../../../../shared/presentation/providers/global_loader/global_loader_cubit.dart';
import '../../../domain/failures/delete_account_failure.dart';
import '../../../domain/interfaces/i_delete_account_repository.dart';

part 'delete_account_state.dart';

class DeleteAccountCubit extends Cubit<DeleteAccountState> {
  DeleteAccountCubit({
    required this.repository,
    required this.globalLoaderCubit,
  }) : super(DeleteAccountState.initial());
  final IDeleteAccountRepository repository;
  final GlobalLoaderCubit globalLoaderCubit;

  void deleteAccount() async {
    globalLoaderCubit.show();
    emit(state.copyWith(resultOr: ResultOr.loading()));
    final result = await repository.deleteAccount();
    globalLoaderCubit.hide();
    emit(state.copyWith(resultOr: result));
  }
}
