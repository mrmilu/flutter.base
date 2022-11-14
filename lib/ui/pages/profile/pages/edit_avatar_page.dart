import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_base/ui/components/editable_image_preview.dart';
import 'package:flutter_base/ui/i18n/locale_keys.g.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_base/ui/pages/profile/providers/profile_provider.dart';

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
    final editorKey =
        ref.watch(profileProvider.select((state) => state.avatarEditorKey));

    return Scaffold(
      appBar: CupertinoNavigationBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        middle: Text(
          LocaleKeys.profile_avatar_edit_title.tr(),
          style: TextStyle(color: Theme.of(context).colorScheme.onPrimary),
        ),
        trailing: TextButton(
          style: TextButton.styleFrom(
              foregroundColor: Theme.of(context).colorScheme.onPrimary),
          onPressed: ref.watch(profileProvider.notifier).cropAvatarPhotoAndSave,
          child: Text(
            LocaleKeys.profile_avatar_edit_save.tr(),
          ),
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
