import 'dart:io' show Platform;

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../../helpers/toasts.dart';
import '../../../router/page_names.dart';
import '../../../utils/const.dart';
import '../../../utils/extensions/buildcontext_extensions.dart';
import '../../wrapper_bottom_sheet_with_button.dart';
import '../buttons/custom_elevated_button.dart';

Future<dynamic> showSelectImage(BuildContext context) {
  return showModalBottomSheet(
    context: context,
    useSafeArea: true,

    routeSettings: const RouteSettings(name: PageNames.modalSelectImage),
    builder: (context) => Padding(
      padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
      child: WrapperBottomSheetWithButton(
        title: context.cl.translate('modals.selectImage.title'),
        hasScroll: false,
        child: const ModalSelectImageWidget(),
      ),
    ),
  );
}

class ModalSelectImageWidget extends StatelessWidget {
  const ModalSelectImageWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const ModalSelectImageWidgetContent();
  }
}

class ModalSelectImageWidgetContent extends StatefulWidget {
  const ModalSelectImageWidgetContent({
    super.key,
  });

  @override
  State<ModalSelectImageWidgetContent> createState() =>
      _ModalSelectImageWidgetContentState();
}

class _ModalSelectImageWidgetContentState
    extends State<ModalSelectImageWidgetContent> {
  bool _isHandlingCameraSelection = false;
  bool _isHandlingGallerySelection = false;

  /// Verifica y solicita permiso para la cámara
  Future<bool> _requestCameraPermission() async {
    final status = await Permission.camera.status;
    if (status.isDenied) {
      final result = await Permission.camera.request();
      return result.isGranted;
    } else if (status.isPermanentlyDenied) {
      return false;
    }
    return status.isGranted;
  }

  /// Verifica y solicita permiso para la galería
  Future<bool> _requestGalleryPermission() async {
    Permission permission;

    // En Android 13+ (API 33+) se usa Permission.photos
    // En versiones anteriores de Android se usa Permission.storage
    // En iOS siempre se usa Permission.photos
    if (Platform.isIOS) {
      permission = Permission.photos;
    } else {
      // Para Android, intentamos primero con photos (Android 13+)
      // Si no está disponible, usamos storage (Android 12 y anteriores)
      permission = Permission.photos;
      final photosStatus = await permission.status;
      if (photosStatus == PermissionStatus.restricted) {
        // Si photos no está disponible, usar storage
        permission = Permission.storage;
      }
    }
    final status = await permission.status;
    if (status.isDenied) {
      final result = await permission.request();
      return result.isGranted;
    } else if (status.isPermanentlyDenied) {
      return false;
    }
    return status.isGranted;
  }

  Future<void> _handleCameraSelection(BuildContext context) async {
    if (_isHandlingCameraSelection) return;

    setState(() {
      _isHandlingCameraSelection = true;
    });

    try {
      final hasPermission = await _requestCameraPermission();

      if (hasPermission) {
        if (context.mounted) {
          context.pop(ImageSource.camera);
        }
      } else {
        if (context.mounted) {
          showInfoWithButton(
            context,
            message: context.cl.translate(
              'modals.selectImage.cameraPermission',
            ),
            onTap: () => openAppSettings(),
          );
        }
      }
    } finally {
      if (mounted) {
        setState(() {
          _isHandlingCameraSelection = false;
        });
      }
    }
  }

  Future<void> _handleGallerySelection(BuildContext context) async {
    if (_isHandlingGallerySelection) return;

    setState(() {
      _isHandlingGallerySelection = true;
    });

    try {
      final hasPermission = await _requestGalleryPermission();

      if (hasPermission) {
        if (context.mounted) {
          context.pop(ImageSource.gallery);
        }
      } else {
        if (context.mounted) {
          showInfoWithButton(
            context,
            message: context.cl.translate(
              'modals.selectImage.galleryPermission',
            ),
            onTap: () => openAppSettings(),
          );
        }
      }
    } finally {
      if (mounted) {
        setState(() {
          _isHandlingGallerySelection = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
      children: [
        const SizedBox(height: 12),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: CustomElevatedButton.inverse(
            padding: const EdgeInsets.symmetric(
              vertical: paddingHightButtons,
            ),
            onPressed: () => _handleGallerySelection(context),
            label: context.cl.translate('modals.selectImage.gallery'),
          ),
        ),
        const SizedBox(height: 12),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: CustomElevatedButton.inverse(
            padding: const EdgeInsets.symmetric(
              vertical: paddingHightButtons,
            ),
            onPressed: () => _handleCameraSelection(context),
            label: context.cl.translate('modals.selectImage.camera'),
          ),
        ),
        const SizedBox(height: 12),
      ],
    );
  }
}
