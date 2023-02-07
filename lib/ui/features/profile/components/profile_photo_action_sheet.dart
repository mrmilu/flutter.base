import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_base/ui/features/profile/providers/profile_provider.dart';
import 'package:flutter_base/ui/i18n/locale_keys.g.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProfilePhotoActionSheet extends ConsumerWidget {
  const ProfilePhotoActionSheet({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return CupertinoActionSheet(
      cancelButton: CupertinoActionSheetAction(
        onPressed: () {
          Navigator.pop(context);
        },
        child: Text(LocaleKeys.profile_avatar_options_cancel.tr()),
      ),
      actions: <CupertinoActionSheetAction>[
        CupertinoActionSheetAction(
          isDefaultAction: true,
          onPressed: () => _photoFromCamera(context, ref),
          child: Text(LocaleKeys.profile_avatar_options_take.tr()),
        ),
        CupertinoActionSheetAction(
          onPressed: () => _photoFromGallery(context, ref),
          child: Text(LocaleKeys.profile_avatar_options_gallery.tr()),
        ),
        CupertinoActionSheetAction(
          isDestructiveAction: true,
          onPressed: () => _deleteAvatar(context, ref),
          child: Text(
            LocaleKeys.profile_avatar_options_delete.tr(),
          ),
        )
      ],
    );
  }

  void _photoFromGallery(BuildContext context, WidgetRef ref) {
    Navigator.pop(context);
    ref.read(profileProvider.notifier).chosePhotoFromGallery();
  }

  void _photoFromCamera(BuildContext context, WidgetRef ref) {
    Navigator.pop(context);
    ref.read(profileProvider.notifier).takePhoto();
  }

  void _deleteAvatar(BuildContext context, WidgetRef ref) {
    Navigator.pop(context);
    ref.read(profileProvider.notifier).deleteAvatar();
  }
}
