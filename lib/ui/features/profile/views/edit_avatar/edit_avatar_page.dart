import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_base/ui/components/buttons/button_tertiary.dart';
import 'package:flutter_base/ui/components/flutter_base_app_bar.dart';
import 'package:flutter_base/ui/components/images/editable_image_preview.dart';
import 'package:flutter_base/ui/features/profile/views/edit_avatar/providers/edit_avatar_provider.dart';
import 'package:flutter_base/ui/i18n/locale_keys.g.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class EditAvatarPageData {
  final File avatar;

  const EditAvatarPageData({
    required this.avatar,
  });
}

class EditAvatarPage extends ConsumerWidget {
  final File avatar;

  const EditAvatarPage({
    super.key,
    required this.avatar,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final editorKey = ref.watch(editAvatarProvider);

    return Scaffold(
      appBar: FlutterBaseAppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        trailing: ButtonTertiary(
          onPressed: () =>
              ref.watch(editAvatarProvider.notifier).cropAvatarPhotoAndSave(),
          text: LocaleKeys.profile_avatar_edit_save.tr(),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ClipRect(
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.width,
              child: EditableImagePreview(
                image: avatar,
                editorKey: editorKey!,
                circleMask: true,
              ),
            ),
          ),
        ],
      ),
    );
  }
}