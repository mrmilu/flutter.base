import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../router/app_router.dart';
import '../../widgets/global_circular_progress.dart';

part 'global_loader_cubit.freezed.dart';
part 'global_loader_state.dart';

class GlobalLoaderCubit extends Cubit<GlobalLoaderState> {
  GlobalLoaderCubit() : super(GlobalLoaderState.initial());
  bool _globalEntryAdded = false;

  void show() {
    if (_globalEntryAdded) return;
    final context = rootNavigatorKey.currentState?.overlay?.context;
    if (context == null) return;
    OverlayEntry overlayEntry = GlobalCircularProgress.build(context);
    if (rootNavigatorKey.currentState?.overlay == null) return;
    rootNavigatorKey.currentState?.overlay?.insert(overlayEntry);
    _globalEntryAdded = true;
    emit(state.copyWith(globalLoaderEntry: overlayEntry));
  }

  void hide() {
    emit(state.copyWith(hideLoaderOverlayEntry: true));
    Future.delayed(const Duration(milliseconds: 400), () {
      state.globalLoaderEntry?.remove();
      _globalEntryAdded = false;
      emit(
        state.copyWith(
          hideLoaderOverlayEntry: false,
          globalLoaderEntry: null,
        ),
      );
    });
  }

  (String, int) hideImmediately() {
    return ('dani', 19);
  }
}
