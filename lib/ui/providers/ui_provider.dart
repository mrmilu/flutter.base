import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_base/core/app/domain/models/app_error.dart';
import 'package:flutter_base/ui/components/global_circular_progress.dart';
import 'package:flutter_base/ui/components/styled_snackbar.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_base/ui/i18n/locale_keys.g.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

part 'ui_provider.freezed.dart';

@freezed
class UiState with _$UiState {
  factory UiState({
    OverlayEntry? globalLoaderEntry,
    @Default(false) bool hideOverlay,
  }) = _UiState;
}

class UiProvider extends StateNotifier<UiState> {
  UiProvider() : super(UiState());
  final _appRouter = GetIt.I.get<GoRouter>();
  final _snackBarKey = GetIt.I.get<GlobalKey<ScaffoldMessengerState>>();
  bool _entryAdded = false;

  void showGlobalLoader() {
    if (_entryAdded) return;
    final context = _appRouter.navigator?.overlay?.context;
    if (context == null) return;
    OverlayEntry overlayEntry = GlobalCircularProgress.build(context);
    if (_appRouter.navigator?.overlay == null) return;
    _appRouter.navigator?.overlay?.insert(overlayEntry);
    _entryAdded = true;
    state = state.copyWith(globalLoaderEntry: overlayEntry);
  }

  void hideGlobalLoader() {
    state = state.copyWith(hideOverlay: true);
    Future.delayed(const Duration(milliseconds: 400), () {
      state.globalLoaderEntry?.remove();
      _entryAdded = false;
      state = state.copyWith(hideOverlay: false, globalLoaderEntry: null);
    });
  }

  void showSnackBar(
    String message, {
    SnackBarStyle style = SnackBarStyle.error,
  }) {
    if (_snackBarKey.currentState != null) {
      SnackBar snackBar = styledSnackBar(
        _snackBarKey.currentState!.context,
        message,
        style: style,
      );
      _snackBarKey.currentState!.showSnackBar(snackBar);
    }
  }

  tryAction<T>(
    Future<T> Function() action, {
    bool rethrowError = false,
  }) async {
    showGlobalLoader();
    try {
      await action();
    } on AppError catch (e, stackTrace) {
      Sentry.captureException(e, stackTrace: stackTrace);
      log('$runtimeType/${e.toString()}');

      if (rethrowError) rethrow;

      final defaultMessage = LocaleKeys.errorsMessages_global.tr();
      if (e.code == AppErrorCode.unAuthorized ||
          e.code == AppErrorCode.wrongCredentials) {
        showSnackBar(e.message ?? defaultMessage);
      } else {
        showSnackBar(defaultMessage);
      }
    } catch (e) {
      rethrow;
    } finally {
      hideGlobalLoader();
    }
  }
}

final uiProvider =
    StateNotifierProvider<UiProvider, UiState>((_) => UiProvider());

final hideOverlayProvider = Provider(
    (ref) => ref.watch(uiProvider.select((state) => state.hideOverlay)));
