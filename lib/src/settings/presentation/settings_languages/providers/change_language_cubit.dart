import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../locale/presentation/providers/locale_cubit.dart';
import '../../../../shared/helpers/result_or.dart';
import '../../../../shared/presentation/providers/global_loader/global_loader_cubit.dart';
import '../../../domain/failures/change_language_failure.dart';
import '../../../domain/interfaces/i_change_language_repository.dart';

part 'change_language_state.dart';

class ChangeLanguageCubit extends Cubit<ChangeLanguageState> {
  ChangeLanguageCubit({
    required this.repository,
    required this.globalLoaderCubit,
    required this.localeCubit,
  }) : super(ChangeLanguageState.initial());
  final IChangeLanguageRepository repository;
  final GlobalLoaderCubit globalLoaderCubit;
  final LocaleCubit localeCubit;

  void changeLanguage(String languageCode) async {
    emit(state.copyWith(resultOr: ResultOr.loading()));
    globalLoaderCubit.show();
    final result = await repository.changeLanguage(languageCode.toUpperCase());

    if (result.isSuccess) {
      await localeCubit.changeLanguage(languageCode);
    }
    globalLoaderCubit.hide();
    emit(state.copyWith(resultOr: result));
  }
}
