import 'package:cross_file/cross_file.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_base/ui/components/buttons/button_tertiary.dart';
import 'package:flutter_base/ui/components/flutter_base_app_bar.dart';
import 'package:flutter_base/ui/components/images/editable_image_preview.dart';
import 'package:flutter_base/ui/features/profile/views/edit_avatar/providers/edit_avatar_provider.dart';
import 'package:flutter_base/ui/i18n/locale_keys.g.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class EditAvatarPageData {
  final XFile avatar;

  const EditAvatarPageData({
    required this.avatar,
  });
}

class EditAvatarPage extends StatelessWidget {
  final XFile avatar;

  const EditAvatarPage({
    super.key,
    required this.avatar,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: FlutterBaseAppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        trailing: Consumer(
          builder: (context, ref, child) {
            return ButtonTertiary(
              onPressed: () => ref
                  .watch(editAvatarProvider.notifier)
                  .cropAvatarPhotoAndSave(),
              text: LocaleKeys.profile_avatar_edit_save.tr(),
            );
          },
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ClipRect(
            child: SizedBox.square(
              dimension: MediaQuery.of(context).size.width,
              child: Consumer(
                builder: (context, ref, child) {
                  final editorKey = ref.watch(editAvatarProvider);
                  return EditableImagePreview(
                    image: avatar,
                    editorKey: editorKey!,
                    circleMask: true,
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
