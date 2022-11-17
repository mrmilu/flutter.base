import 'dart:async';
import 'dart:typed_data';

import 'package:easy_localization/easy_localization.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_base/common/interfaces/asset_picker_service.dart';
import 'package:flutter_base/common/interfaces/edit_image_service.dart';
import 'package:flutter_base/core/app/domain/models/app_error.dart';
import 'package:flutter_base/core/user/domain/interfaces/user_repository.dart';
import 'package:flutter_base/core/user/domain/models/update_user_input_model.dart';
import 'package:flutter_base/ui/i18n/locale_keys.g.dart';
import 'package:flutter_base/ui/pages/profile/pages/edit_avatar_page.dart';
import 'package:flutter_base/ui/pages/profile/view_models/edit_profile_view_model.dart';
import 'package:flutter_base/ui/providers/ui_provider.dart';
import 'package:flutter_base/ui/providers/user_provider.dart';
import 'package:flutter_base/ui/view_models/user_view_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';

part 'profile_provider.freezed.dart';

@freezed
class ProfileState with _$ProfileState {
  factory ProfileState({
    GlobalKey<ExtendedImageEditorState>? avatarEditorKey,
  }) = _ProfileState;
}

class ProfileProvider extends StateNotifier<ProfileState> {
  final IAssetPickerService _assetPickerService =
      GetIt.I.get<IAssetPickerService>();
  final _userRepository = GetIt.I.get<IUserRepository>();
  final _editImageService = GetIt.I.get<IEditImageService>();
  final _appRouter = GetIt.I.get<GoRouter>();
  late final UserProvider _userProvider;
  late final UiProvider _uiProvider;

  ProfileProvider(AutoDisposeStateNotifierProviderRef ref)
      : super(
          ProfileState(
            avatarEditorKey: GlobalKey<ExtendedImageEditorState>(),
          ),
        ) {
    _userProvider = ref.watch(userProvider.notifier);
    _uiProvider = ref.watch(uiProvider.notifier);
  }

  Future<void> chosePhotoFromGallery() async {
    _uiProvider.showGlobalLoader();
    final avatar = await _assetPickerService.imageFromGallery();
    if (avatar != null) {
      _appRouter.push(
        '/profile/avatar',
        extra: EditAvatarPageData(avatar: avatar),
      );
    }
    _uiProvider.hideGlobalLoader();
  }

  Future<void> takePhoto() async {
    _uiProvider.showGlobalLoader();
    final avatar = await _assetPickerService.imageFromCamera();
    if (avatar != null) {
      _appRouter.push(
        '/profile/avatar',
        extra: EditAvatarPageData(avatar: avatar),
      );
    }
    _uiProvider.hideGlobalLoader();
  }

  Future<void> deleteAvatar() async {
    try {
      _uiProvider.showGlobalLoader();
      final user = await _userRepository.deleteAvatar();
      _userProvider.setUserData(user.toViewModel());
    } finally {
      _uiProvider.hideGlobalLoader();
    }
  }

  Future<void> updateProfile(EditProfileModelForm formModel) async {
    formModel.form.markAllAsTouched();
    if (formModel.form.valid) {
      _uiProvider.showGlobalLoader();
      final input = UpdateUserInputModel(
        name: formModel.model.name.trim(),
      );
      try {
        FocusManager.instance.primaryFocus?.unfocus();
        final user = await _userRepository.update(input);
        _userProvider.setUserData(user.toViewModel());
        _appRouter.pop();
      } on AppError {
        _uiProvider.showSnackBar(LocaleKeys.errorsMessages_global.tr());
      } finally {
        _uiProvider.hideGlobalLoader();
      }
    }
  }

  Future<void> cropAvatarPhotoAndSave() async {
    _uiProvider.showGlobalLoader();
    try {
      final editorState = state.avatarEditorKey!.currentState;
      if (editorState == null) {
        return;
      }
      final Rect? rect = editorState.getCropRect();
      final Uint8List rawImage = editorState.rawImageData;

      if (rect == null) return;

      final editedAvatar = await _editImageService.crop(rect, rawImage);
      if (editedAvatar != null) {
        final user = await _userRepository.avatar(editedAvatar);
        _userProvider.setUserData(user.toViewModel());
      }
      _uiProvider.hideGlobalLoader();
      _appRouter.navigator?.pop();
    } finally {
      Timer(const Duration(milliseconds: 300), () {
        state.avatarEditorKey?.currentState?.reset();
      });
    }
  }
}

final profileProvider =
    AutoDisposeStateNotifierProvider<ProfileProvider, ProfileState>(
  (ref) => ProfileProvider(ref),
);
