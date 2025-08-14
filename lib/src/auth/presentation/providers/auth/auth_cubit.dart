import 'dart:async';
import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

import '../../../../shared/data/services/simple_notifications_push_service.dart';
import '../../../../shared/domain/models/user_model.dart';
import '../../../../shared/presentation/helpers/analytics_helper.dart';
import '../../../../shared/presentation/providers/global_loader/global_loader_cubit.dart';
import '../../../domain/interfaces/i_auth_repository.dart';

part 'auth_cubit.freezed.dart';
part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final IAuthRepository authRepository;
  final GlobalLoaderCubit globalLoaderCubit;
  AuthCubit({required this.authRepository, required this.globalLoaderCubit})
    : super(AuthState.initial());

  Future<void> initUser() async {
    final user = await authRepository.getUser();
    if (user != null) {
      log('User $user');
      if (user.document != null) {
        createTokenDevice();
      }

      await Sentry.configureScope(
        (scope) => scope.setUser(
          SentryUser(
            id: user.email,
            email: user.email,
          ),
        ),
      );
      await MyAnalyticsHelper.setUserId(user.email);
    }
    emit(state.copyWith(user: user));
  }

  Future<void> loginUser() async {
    globalLoaderCubit.show();
    initUser();
    globalLoaderCubit.hide();
  }

  Future<void> reloadUser() async {
    final user = await authRepository.getUser();
    emit(state.copyWith(user: user));
  }

  Future<void> createTokenDevice() async {
    final tokenDevice = PushNotificationService.token;
    if (tokenDevice != null) {
      await authRepository.createUserDevice(token: tokenDevice);
    }
  }

  Future<void> logout() async {
    globalLoaderCubit.show();
    await authRepository.logout();
    globalLoaderCubit.hide();
    emit(state.copyWith(user: null));
  }
}
