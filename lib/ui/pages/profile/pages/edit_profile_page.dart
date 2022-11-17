import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_base/ui/components/box_spacer.dart';

import 'package:flutter_base/ui/components/buttons/button_primary.dart';
import 'package:flutter_base/ui/components/views/column_scroll_view.dart';
import 'package:flutter_base/ui/i18n/locale_keys.g.dart';
import 'package:flutter_base/ui/pages/profile/providers/profile_provider.dart';
import 'package:flutter_base/ui/pages/profile/view_models/edit_profile_view_model.dart';
import 'package:flutter_base/ui/providers/user_provider.dart';
import 'package:flutter_base/ui/utils/scroll.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reactive_forms_annotations/reactive_forms_annotations.dart';

class EditProfilePage extends ConsumerWidget {
  const EditProfilePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userProvider.select((state) => state.userData));

    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        appBar: CupertinoNavigationBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          middle: Text(
            LocaleKeys.profile_edit_title.tr(),
            style: TextStyle(color: Theme.of(context).colorScheme.onPrimary),
          ),
        ),
        body: ColumnScrollView(
          padding: const EdgeInsets.all(16),
          children: [
            EditProfileModelFormBuilder(
              model: EditProfileViewModel(name: user!.name),
              builder: (context, formModel, child) {
                return Column(
                  children: [
                    BoxSpacer.v16(),
                    ReactiveTextField(
                      formControl: formModel.nameControl,
                      scrollPadding: textFieldScrollPadding(context: context),
                      decoration: InputDecoration(
                        labelText: LocaleKeys.profile_edit_form_name.tr(),
                      ),
                    ),
                    BoxSpacer.v32(),
                    ButtonPrimary(
                      text: LocaleKeys.profile_edit_form_submit.tr(),
                      onPressed: () => ref
                          .read(profileProvider.notifier)
                          .updateProfile(formModel),
                    ),
                  ],
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
