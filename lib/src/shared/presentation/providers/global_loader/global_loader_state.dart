part of 'global_loader_cubit.dart';

@freezed
abstract class GlobalLoaderState with _$GlobalLoaderState {
  factory GlobalLoaderState({
    required OverlayEntry? globalLoaderEntry,
    required bool hideLoaderOverlayEntry,
  }) = _GlobalLoaderState;

  factory GlobalLoaderState.initial() => _GlobalLoaderState(
    globalLoaderEntry: null,
    hideLoaderOverlayEntry: false,
  );
}
