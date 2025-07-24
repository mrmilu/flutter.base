part of 'locale_cubit.dart';

@freezed
abstract class LocaleState with _$LocaleState {
  factory LocaleState({
    required String languageCode,
  }) = _LocaleState;

  factory LocaleState.initial() => _LocaleState(
    languageCode: 'es',
  );

  LocaleState._();

  Locale get locale => Locale.fromSubtags(languageCode: languageCode);
}
