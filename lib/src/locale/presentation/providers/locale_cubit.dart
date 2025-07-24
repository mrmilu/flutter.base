import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/i_locale_repository.dart';

part 'locale_cubit.freezed.dart';
part 'locale_state.dart';

String appLocaleCode = 'es';

class LocaleCubit extends Cubit<LocaleState> {
  final ILocaleRepository localeRepository;

  LocaleCubit({required this.localeRepository}) : super(LocaleState.initial());

  Future<void> changeLanguage(String languageCode) async {
    await localeRepository.changeLanguageCode(languageCode);
    appLocaleCode = languageCode;
    emit(state.copyWith(languageCode: languageCode));
  }

  void loadLocale(String languageCode) async {
    final localeLoad = await localeRepository.findLanguageCode();

    if (localeLoad != null) {
      emit(state.copyWith(languageCode: localeLoad));
    } else {
      emit(state.copyWith(languageCode: languageCode));
    }
  }
}
