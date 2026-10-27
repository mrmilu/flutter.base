import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_jungle_core/flutter_jungle_core.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../shared/domain/interfaces/i_settings_repository.dart';
import '../../../shared/domain/models/app_settings_model.dart';

part 'app_settings_cubit.freezed.dart';
part 'app_settings_state.dart';

class AppSettingsCubit extends Cubit<AppSettingsState> {
  AppSettingsCubit({required this.repository})
    : super(AppSettingsState.initial());
  final ISettingsRepository repository;

  Future<void> getAppSettings() async {
    emit(state.copyWith(resource: const Resource.loading()));
    final appSetting = await repository.getAppSettings();
    emit(state.copyWith(resource: appSetting));
  }
}
