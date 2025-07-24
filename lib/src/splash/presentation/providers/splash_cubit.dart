import 'dart:io';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:package_info_plus/package_info_plus.dart';

import '../../../auth/domain/interfaces/i_token_repository.dart';
import '../../../auth/presentation/providers/auth/auth_cubit.dart';
import '../../../shared/helpers/result_or.dart';
import '../../../shared/presentation/providers/base_cubit.dart';
import '../../domain/splash_failure.dart';
import 'app_settings_cubit.dart';

part 'splash_cubit.freezed.dart';
part 'splash_state.dart';

String appVersion = '';

class SplashCubit extends BaseCubit<SplashState> {
  SplashCubit({
    required this.settingsCubit,
    required this.authCubit,
    required this.tokenRepository,
  }) : super(SplashState.initial());
  final AppSettingsCubit settingsCubit;
  final AuthCubit authCubit;
  final ITokenRepository tokenRepository;

  void changeCanUpdate(bool value) {
    emitIfNotDisposed(state.copyWith(canUpdate: value));
  }

  void changeProgressText(String value) {
    emitIfNotDisposed(state.copyWith(progressText: value));
  }

  void changeProgressValue(double value) {
    emitIfNotDisposed(state.copyWith(progressValue: value));
  }

  void changeSplashIsLoaded(bool value) {
    emitIfNotDisposed(state.copyWith(splashIsLoaded: value));
  }

  void changeReadyToNavigate(bool value) {
    emitIfNotDisposed(state.copyWith(readyToNavigate: value));
  }

  void changeErrorLoading(bool value) {
    emitIfNotDisposed(state.copyWith(errorLoading: value));
  }

  void changeToken(String? value) {
    emitIfNotDisposed(state.copyWith(token: value));
  }

  void onTapUpdateApp() async {
    if (Platform.isAndroid) {
      // await InAppUpdate.performImmediateUpdate().catchError((e) async {
      //   return e;
      // });
    } else {
      // LaunchReview.launch(
      //     writeReview: false,
      //     androidAppId: "es.anullos.lapared",
      //     iOSAppId: "1577900535");
    }
  }

  void check() async {
    bool needUpdate = false;
    try {
      // await preLoadImages(context);
      // await Future.delayed(const Duration(milliseconds: 400));
      changeProgressValue(1 / 4);

      if (Platform.isAndroid) {
        // final info = await InAppUpdate.checkForUpdate();
        // AppUpdateInfo updateInfo = info;
        // needUpdate = (updateInfo.updateAvailability ==
        //     UpdateAvailability.updateAvailable);
      } else {
        // final newVersion = NewVersionPlus();
        // final status = await newVersion.getVersionStatus();
        // int storeVersion = int.parse(status!.storeVersion);
        // if (1 < storeVersion) {
        //   needUpdate = true;
        // } else {
        //   needUpdate = false;
        // }
        needUpdate = false;
      }
    } catch (e) {
      needUpdate = false;
    }
    if (needUpdate) {
      changeCanUpdate(true);
    } else {
      loadData();
    }
  }

  Future<void> loadData() async {
    try {
      changeErrorLoading(false);
      final appVersionData = await PackageInfo.fromPlatform();
      appVersion = '${appVersionData.version}+${appVersionData.buildNumber}';
      changeProgressValue(2 / 4);
      changeProgressValue(3 / 4);
      // await settingsCubit.getAppSettings();
      // final appSettings = settingsCubit.state.resource;
      // if (appSettings.isFailure) {
      //   changeErrorLoading(true);
      //   return;
      // }

      changeProgressText('Cargando datos de usuario');
      await loadDataUser();

      changeProgressValue(4 / 4);
      await Future.delayed(const Duration(milliseconds: 1500));
      changeSplashIsLoaded(true);
    } catch (e) {
      changeErrorLoading(true);
    }
  }

  Future<void> loadDataUser() async {
    final token = await tokenRepository.getToken();
    changeToken(token);
    if (token != null) {
      await authCubit.initUser();
    }
  }
}
