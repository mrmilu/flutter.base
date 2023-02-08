import 'dart:async';
import 'dart:typed_data';

import 'package:extended_image/extended_image.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_base/common/interfaces/asset_picker_service.dart';
import 'package:flutter_base/common/interfaces/edit_image_service.dart';
import 'package:flutter_base/core/user/domain/interfaces/user_repository.dart';
import 'package:flutter_base/core/user/domain/models/update_user_input_model.dart';
import 'package:flutter_base/ui/features/profile/pages/edit_avatar_page.dart';
import 'package:flutter_base/ui/features/profile/view_models/edit_profile_view_model.dart';
import 'package:flutter_base/ui/providers/ui_provider.dart';
import 'package:flutter_base/ui/providers/user_provider.dart';
import 'package:flutter_base/ui/router/app_router.dart';
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
    EditProfileModelForm? editProfileFormModel,
  }) = _ProfileState;
}

class ProfileProvider extends AutoDisposeNotifier<ProfileState> {
  final IAssetPickerService _assetPickerService =
      GetIt.I.get<IAssetPickerService>();
  final _userRepository = GetIt.I.get<IUserRepository>();
  final _editImageService = GetIt.I.get<IEditImageService>();
  final _appRouter = GetIt.I.get<GoRouter>();

  @override
  ProfileState build() {
    final user = ref.watch(userProvider.select((state) => state.userData));
    return ProfileState(
      avatarEditorKey: GlobalKey<ExtendedImageEditorState>(),
      editProfileFormModel:
          EditProfileViewModel(name: user!.name).generateFormModel(),
    );
  }

  Future<void> chosePhotoFromGallery() async {
    final uiNotifier = ref.watch(uiProvider.notifier);
    uiNotifier.showGlobalLoader();
    final avatar = await _assetPickerService.imageFromGallery();
    if (avatar != null) {
      _appRouter.push(
        '/profile/avatar',
        extra: EditAvatarPageData(avatar: avatar),
      );
    }
    uiNotifier.hideGlobalLoader();
  }

  Future<void> takePhoto() async {
    final uiNotifier = ref.watch(uiProvider.notifier);
    uiNotifier.showGlobalLoader();
    final avatar = await _assetPickerService.imageFromCamera();
    if (avatar != null) {
      _appRouter.push(
        '/profile/avatar',
        extra: EditAvatarPageData(avatar: avatar),
      );
    }
    uiNotifier.hideGlobalLoader();
  }

  Future<void> deleteAvatar() async {
    final userNotifier = ref.watch(userProvider.notifier);
    final uiNotifier = ref.watch(uiProvider.notifier);
    uiNotifier.tryAction(() async {
      uiNotifier.showGlobalLoader();
      final user = await _userRepository.deleteAvatar();
      userNotifier.setUserData(user.toViewModel());
    });
  }

  Future<void> updateProfile() async {
    final userNotifier = ref.watch(userProvider.notifier);
    final uiNotifier = ref.watch(uiProvider.notifier);
    final formModel = state.editProfileFormModel!;
    formModel.form.markAllAsTouched();
    if (formModel.form.valid) {
      uiNotifier.tryAction(() async {
        FocusManager.instance.primaryFocus?.unfocus();
        final input = UpdateUserInputModel(
          name: formModel.model.name.trim(),
        );
        final user = await _userRepository.update(input);
        userNotifier.setUserData(user.toViewModel());
        _appRouter.pop();
      });
    }
  }

  Future<void> cropAvatarPhotoAndSave() async {
    final userNotifier = ref.watch(userProvider.notifier);
    final uiNotifier = ref.watch(uiProvider.notifier);
    uiNotifier.showGlobalLoader();
    uiNotifier
        .tryAction(() async {
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
            userNotifier.setUserData(user.toViewModel());
          }
        })
        .then((value) => rootNavigatorKey.currentState?.pop())
        .whenComplete(() {
          Timer(const Duration(milliseconds: 300), () {
            state.avatarEditorKey?.currentState?.reset();
          });
        });
  }
}

final profileProvider =
    AutoDisposeNotifierProvider<ProfileProvider, ProfileState>(
  ProfileProvider.new,
);
