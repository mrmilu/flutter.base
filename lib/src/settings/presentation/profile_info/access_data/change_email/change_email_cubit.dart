import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../../shared/domain/vos/email_vos.dart';
import '../../../../../shared/helpers/extensions.dart';
import '../../../../../shared/helpers/result_or.dart';
import '../../../../../shared/helpers/value_object.dart';
import '../../../../../shared/presentation/providers/global_loader/global_loader_cubit.dart';
import '../../../../domain/failures/change_email_failure.dart';
import '../../../../domain/interfaces/i_personal_info_repository.dart';

part 'change_email_cubit.freezed.dart';
part 'change_email_state.dart';

class ChangeEmailCubit extends Cubit<ChangeEmailState> {
  ChangeEmailCubit({required this.repository, required this.globalLoaderCubit})
    : super(ChangeEmailState.initial());
  final IPersonalInfoRepository repository;
  final GlobalLoaderCubit globalLoaderCubit;

  void changeEmail(String value) {
    emit(
      state.copyWith(
        email: EmailVos(value),
      ),
    );
  }

  void changeEmailRepeat(String value) {
    emit(state.copyWith(emailRepeat: value));
  }

  bool _allFieldsAreValid() =>
      <ValueObject>[
        state.email,
      ].areValid &&
      state.email.value.right == state.emailRepeat;

  Future<void> save() async {
    if (!_allFieldsAreValid()) {
      emit(state.copyWith(showError: true));
      return;
    }
    if (_allFieldsAreValid()) {
      emit(state.copyWith(resultOr: ResultOr.loading(), showError: false));
      globalLoaderCubit.show();
      final result = await repository.changeEmail(
        email: state.email.getOrCrash(),
      );
      globalLoaderCubit.hide();
      emit(state.copyWith(resultOr: result, showError: true));
    }
    emit(state.copyWith(resultOr: ResultOr.none()));
  }
}
