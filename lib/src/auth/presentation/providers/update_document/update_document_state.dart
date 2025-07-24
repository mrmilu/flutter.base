part of 'update_document_cubit.dart';

@freezed
abstract class UpdateDocumentState with _$UpdateDocumentState {
  factory UpdateDocumentState({
    required String firstName,
    required String lastName,
    required DocumentType documentType,
    required String documentValue,
    required bool showErrors,
    required ResultOr<UpdateDocumentFailure> resultOr,
  }) = _UpdateDocumentState;

  factory UpdateDocumentState.initial() => _UpdateDocumentState(
    firstName: '',
    lastName: '',
    documentType: DocumentType.nif,
    documentValue: '',
    showErrors: false,
    resultOr: ResultOr.none(),
  );

  UpdateDocumentState._();

  FullnameVos get firstNameVos => FullnameVos(firstName);

  FullnameVos get lastNameVos => FullnameVos(lastName);
}
