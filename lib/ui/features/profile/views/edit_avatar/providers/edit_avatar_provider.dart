import 'dart:async';
import 'dart:typed_data';

import 'package:extended_image/extended_image.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_base/common/interfaces/edit_image_service.dart';
import 'package:flutter_base/core/app/domain/use_cases/image_from_camera_use_case.dart';
import 'package:flutter_base/core/app/domain/use_cases/image_from_gallery_use_case.dart';
import 'package:flutter_base/core/user/domain/interfaces/user_repository.dart';
import 'package:flutter_base/ui/features/profile/views/edit_avatar/edit_avatar_page.dart';
import 'package:flutter_base/ui/providers/ui_provider.dart';
import 'package:flutter_base/ui/providers/user_provider.dart';
import 'package:flutter_base/ui/router/app_router.dart';
import 'package:flutter_base/ui/view_models/user_view_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';

class EditAvatarProvider
    extends AutoDisposeNotifier<GlobalKey<ExtendedImageEditorState>> {
  final _imageFromGalleryUseCase = GetIt.I.get<ImageFromGalleryUseCase>();
  final _imageFromCameraUseCase = GetIt.I.get<ImageFromCameraUseCase>();
  final _userRepository = GetIt.I.get<IUserRepository>();
  final _editImageService = GetIt.I.get<IEditImageService>();
  final _appRouter = GetIt.I.get<GoRouter>();

  @override
  GlobalKey<ExtendedImageEditorState> build() {
    return GlobalKey<ExtendedImageEditorState>();
  }

  Future<void> chosePhotoFromGallery() async {
    final uiNotifier = ref.watch(uiProvider.notifier);
    uiNotifier.showGlobalLoader();
    final avatar = await _imageFromGalleryUseCase();
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
    final avatar = await _imageFromCameraUseCase();
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

  Future<void> cropAvatarPhotoAndSave() async {
    final userNotifier = ref.watch(userProvider.notifier);
    final uiNotifier = ref.watch(uiProvider.notifier);
    uiNotifier.showGlobalLoader();
    uiNotifier
        .tryAction(() async {
          final editorState = state.currentState;
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
            state.currentState?.reset();
          });
        });
  }
}

final editAvatarProvider = AutoDisposeNotifierProvider<EditAvatarProvider,
    GlobalKey<ExtendedImageEditorState>>(
  EditAvatarProvider.new,
);
