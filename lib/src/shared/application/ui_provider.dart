// ignore_for_file: avoid-non-null-assertion

import 'package:flutter/material.dart';
import 'package:flutter_base/src/shared/domain/models/app_error.dart';
import 'package:flutter_base/src/shared/presentation/router/app_router.dart';
import 'package:flutter_base/src/shared/presentation/utils/extensions/app_error_code_messages.dart';
import 'package:flutter_base/src/shared/presentation/utils/extensions/program_error_messages.dart';
import 'package:flutter_base/src/shared/presentation/widgets/components/loaders/global_circular_progress.dart';
import 'package:flutter_base/src/shared/presentation/widgets/components/styled_snackbar.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:get_it/get_it.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

part 'ui_provider.freezed.dart';

@freezed
class UiState with _$UiState {
  factory UiState({
    OverlayEntry? globalLoaderEntry,
    @Default(false) bool hideOverlay,
  }) = _UiState;
}

class UiNotifier extends StateNotifier<UiState> {
  final _snackBarKey = GetIt.I.get<GlobalKey<ScaffoldMessengerState>>();
  bool _entryAdded = false;
  UiNotifier() : super(UiState());

  void showGlobalLoader() {
    if (_entryAdded) return;
    final context = rootNavigatorKey.currentState?.overlay?.context;
    if (context == null) return;
    final OverlayEntry overlayEntry = GlobalCircularProgress.build();
    if (rootNavigatorKey.currentState?.overlay == null) return;
    rootNavigatorKey.currentState?.overlay!.insert(overlayEntry);
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
      final SnackBar snackBar = StyledSnackBar.styledSnackBar(
        _snackBarKey.currentState!.context,
        message,
        style: style,
      );
      _snackBarKey.currentState!.showSnackBar(snackBar);
    }
  }

  Future<void> tryAction<T>(
    Future<T> Function() action, {
    bool rethrowError = false,
  }) async {
    showGlobalLoader();
    try {
      await action();
    } on AppError catch (e, stackTrace) {
      Sentry.captureException(e, stackTrace: stackTrace);

      debugPrintStack(
        label: e.code?.toString() ?? e.message,
        stackTrace: stackTrace,
      );

      if (rethrowError) rethrow;

      showSnackBar(e.code?.getMessage() ?? e.message ?? '');
    } on Error catch (e, stackTrace) {
      debugPrintStack(
        label: e.getMessage(),
        stackTrace: stackTrace,
      );
      Sentry.captureException(e, stackTrace: stackTrace);

      if (rethrowError) rethrow;

      showSnackBar(e.getMessage());
    } catch (e, stackTrace) {
      debugPrintStack(
        label: e.toString(),
        stackTrace: stackTrace,
      );
      rethrow;
    } finally {
      hideGlobalLoader();
    }
  }
}

final uiProvider =
    StateNotifierProvider<UiNotifier, UiState>((_) => UiNotifier());

final hideOverlayProvider = Provider(
  (ref) => ref.watch(uiProvider.select((state) => state.hideOverlay)),
);
