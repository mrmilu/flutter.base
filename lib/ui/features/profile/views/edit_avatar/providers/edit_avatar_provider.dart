import 'dart:async';

import 'package:extended_image/extended_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_base/common/interfaces/edit_image_service.dart';
import 'package:flutter_base/core/app/domain/use_cases/image_from_camera_use_case.dart';
import 'package:flutter_base/core/app/domain/use_cases/image_from_gallery_use_case.dart';
import 'package:flutter_base/core/user/domain/interfaces/user_repository.dart';
import 'package:flutter_base/ui/features/profile/crop_editor_helper.dart';
import 'package:flutter_base/ui/features/profile/views/edit_avatar/edit_avatar_page.dart';
import 'package:flutter_base/ui/providers/ui_provider.dart';
import 'package:flutter_base/ui/providers/user_provider.dart';
import 'package:flutter_base/ui/router/app_router.dart';
import 'package:flutter_base/ui/view_models/user_view_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';

class EditAvatarProvider
    extends AutoDisposeNotifier<GlobalKey<ExtendedImageEditorState>?> {
  final _imageFromGalleryUseCase = GetIt.I.get<ImageFromGalleryUseCase>();
  final _imageFromCameraUseCase = GetIt.I.get<ImageFromCameraUseCase>();
  final _userRepository = GetIt.I.get<IUserRepository>();
  final _editImageService = GetIt.I.get<IEditImageService>();
  final _appRouter = GetIt.I.get<GoRouter>();

  @override
  GlobalKey<ExtendedImageEditorState>? build() {
    return GlobalKey<ExtendedImageEditorState>();
  }

  Future<void> chosePhotoFromGallery() async {
    final uiNotifier = ref.watch(uiProvider.notifier);
    uiNotifier.tryAction(() async {
      final avatar = await _imageFromGalleryUseCase();
      if (avatar != null) {
        _appRouter.push(
          '/profile/avatar',
          extra: EditAvatarPageData(avatar: avatar),
        );
      }
    });
  }

  Future<void> takePhoto() async {
    final uiNotifier = ref.watch(uiProvider.notifier);
    uiNotifier.tryAction(() async {
      final avatar = await _imageFromCameraUseCase();
      if (avatar != null) {
        _appRouter.push(
          '/profile/avatar',
          extra: EditAvatarPageData(avatar: avatar),
        );
      }
    });
  }

  Future<void> deleteAvatar() async {
    final userNotifier = ref.watch(userProvider.notifier);
    final uiNotifier = ref.watch(uiProvider.notifier);
    uiNotifier.tryAction(() async {
      final user = await _userRepository.deleteAvatar();
      userNotifier.setUserData(user.toViewModel());
    });
  }

  Future<void> cropAvatarPhotoAndSave() async {
    final userNotifier = ref.watch(userProvider.notifier);
    final uiNotifier = ref.watch(uiProvider.notifier);
    uiNotifier
        .tryAction(() async {
          final editorState = state!.currentState;
          if (editorState == null) {
            return;
          }
          final Rect? rect = editorState.getCropRect();

          if (rect == null) return;

          final cropHelper = CropEditorHelper();

          final Uint8List rawImage = Uint8List.fromList(
            kIsWeb
                ? (await cropHelper.cropImageDataWithDartLibrary(
                    state: editorState,
                  ))!
                : (await cropHelper.cropImageDataWithNativeLibrary(
                    state: editorState,
                  ))!,
          );

          final editedAvatar = await _editImageService.crop(rect, rawImage);
          if (editedAvatar != null) {
            final user = await _userRepository.avatar(editedAvatar);
            userNotifier.setUserData(user.toViewModel());
          }
        })
        .then((value) => rootNavigatorKey.currentState?.pop())
        .whenComplete(() {
          Timer(const Duration(milliseconds: 300), () {
            state?.currentState?.reset();
          });
        });
  }

  /// it may be failed, due to Cross-domain
  Future<Uint8List> _loadNetwork(ExtendedNetworkImageProvider key) async {
    try {
      final response = await HttpClientHelper.get(
        Uri.parse(key.url),
        headers: key.headers,
        timeLimit: key.timeLimit,
        timeRetry: key.timeRetry,
        retries: key.retries,
        cancelToken: key.cancelToken,
      );
      return response!.bodyBytes;
    } on OperationCanceledError catch (_) {
      return Future<Uint8List>.error(
        StateError('User cancel request ${key.url}.'),
      );
    } catch (e) {
      return Future<Uint8List>.error(
        StateError('failed load ${key.url}. \n $e'),
      );
    }
  }
}

final editAvatarProvider = AutoDisposeNotifierProvider<EditAvatarProvider,
    GlobalKey<ExtendedImageEditorState>?>(
  EditAvatarProvider.new,
);
