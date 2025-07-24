part of 'delete_account_cubit.dart';

class DeleteAccountState {
  final ResultOr<DeleteAccountFailure> resultOr;

  DeleteAccountState({
    required this.resultOr,
  });

  factory DeleteAccountState.initial() => DeleteAccountState(
    resultOr: ResultOr.none(),
  );

  DeleteAccountState copyWith({
    ResultOr<DeleteAccountFailure>? resultOr,
  }) {
    return DeleteAccountState(
      resultOr: resultOr ?? this.resultOr,
    );
  }

  @override
  String toString() => 'DeleteAccountState(resultOr: $resultOr)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is DeleteAccountState && other.resultOr == resultOr;
  }

  @override
  int get hashCode => resultOr.hashCode;
}
