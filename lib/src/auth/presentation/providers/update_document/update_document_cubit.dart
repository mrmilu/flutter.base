import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../shared/domain/types/document_type.dart';
import '../../../../shared/domain/vos/fullname_vos.dart';
import '../../../../shared/domain/vos/nie_vos.dart';
import '../../../../shared/domain/vos/nif_vos.dart';
import '../../../../shared/helpers/result_or.dart';
import '../../../../shared/helpers/value_object.dart';
import '../../../../shared/presentation/providers/global_loader/global_loader_cubit.dart';
import '../../../../shared/presentation/utils/extensions/buildcontext_extensions.dart';
import '../../../domain/failures/update_document_failure.dart';
import '../../../domain/interfaces/i_auth_repository.dart';
import '../../providers/auth/auth_cubit.dart';

part 'update_document_cubit.freezed.dart';
part 'update_document_state.dart';

class UpdateDocumentCubit extends Cubit<UpdateDocumentState> {
  UpdateDocumentCubit({
    required this.authRepository,
    required this.authCubit,
    required this.globalLoaderCubit,
  }) : super(UpdateDocumentState.initial());
  final IAuthRepository authRepository;
  final AuthCubit authCubit;
  final GlobalLoaderCubit globalLoaderCubit;

  void changeFirstName(String value) {
    emit(state.copyWith(firstName: value));
  }

  void changeLastName(String value) {
    emit(state.copyWith(lastName: value));
  }

  void changeDocumentType(DocumentType value) {
    emit(state.copyWith(documentType: value));
  }

  void changeDocumentValue(String value) {
    emit(state.copyWith(documentValue: value));
  }

  void changeShowErrors(bool value) {
    emit(state.copyWith(showErrors: value));
  }

  bool _documentValueIsValid() {
    if (state.documentType == DocumentType.nie) {
      return NieVos(state.documentValue).isValid();
    } else if (state.documentType == DocumentType.nif) {
      return NifVos(state.documentValue).isValid();
    }
    return false;
  }

  bool _allFieldsAreValid() =>
      <ValueObject>[
        state.firstNameVos,
        state.lastNameVos,
      ].areValid &&
      _documentValueIsValid();

  Future<void> updateDocument() async {
    if (!_allFieldsAreValid()) {
      emit(state.copyWith(showErrors: true));
      return;
    }
    if (_allFieldsAreValid()) {
      emit(state.copyWith(resultOr: ResultOr.loading(), showErrors: false));
      globalLoaderCubit.show();
      final result = await authRepository.updateDocument(
        firstName: state.firstName,
        lastName: state.lastName,
        documentType: state.documentType.toString(),
        documentValue: state.documentValue,
      );
      if (result.isSuccess) {
        await authCubit.reloadUser();
      }
      globalLoaderCubit.hide();
      emit(state.copyWith(resultOr: result, showErrors: true));
    }
    emit(state.copyWith(resultOr: ResultOr.none()));
  }
}
