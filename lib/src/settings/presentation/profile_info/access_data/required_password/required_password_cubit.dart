import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../../shared/presentation/helpers/result_or.dart';
import '../../../../../shared/presentation/providers/global_loader/global_loader_cubit.dart';
import '../../../../domain/failures/required_password_failure.dart';
import '../../../../domain/interfaces/i_personal_info_repository.dart';

part 'required_password_cubit.freezed.dart';
part 'required_password_state.dart';

class RequiredPasswordCubit extends Cubit<RequiredPasswordState> {
  RequiredPasswordCubit({
    required this.repository,
    required this.globalLoaderCubit,
  }) : super(RequiredPasswordState.initial());
  final IPersonalInfoRepository repository;
  final GlobalLoaderCubit globalLoaderCubit;

  void changePassword(String value) {
    emit(state.copyWith(password: value));
  }

  Future<void> save() async {
    emit(state.copyWith(resultOr: ResultOr.loading()));
    globalLoaderCubit.show();
    final result = await repository.checkPassword(
      password: state.password,
    );
    globalLoaderCubit.hide();
    emit(state.copyWith(resultOr: result));
  }
}
