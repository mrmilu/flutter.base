part of 'change_language_cubit.dart';

class ChangeLanguageState {
  final ResultOr<ChangeLanguageFailure> resultOr;

  ChangeLanguageState({
    required this.resultOr,
  });

  factory ChangeLanguageState.initial() => ChangeLanguageState(
    resultOr: ResultOr.none(),
  );

  ChangeLanguageState copyWith({
    ResultOr<ChangeLanguageFailure>? resultOr,
  }) {
    return ChangeLanguageState(
      resultOr: resultOr ?? this.resultOr,
    );
  }

  @override
  String toString() => 'ChangeLanguageState(resultOr: $resultOr)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ChangeLanguageState && other.resultOr == resultOr;
  }

  @override
  int get hashCode => resultOr.hashCode;
}
