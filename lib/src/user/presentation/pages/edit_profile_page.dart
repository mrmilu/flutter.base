import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_base/src/shared/presentation/i18n/locale_keys.g.dart';
import 'package:flutter_base/src/shared/presentation/utils/extensions/media_query.dart';
import 'package:flutter_base/src/shared/presentation/utils/styles/insets.dart';
import 'package:flutter_base/src/shared/presentation/widgets/components/box_spacer.dart';
import 'package:flutter_base/src/shared/presentation/widgets/components/buttons/button_primary.dart';
import 'package:flutter_base/src/shared/presentation/widgets/components/flutter_base_app_bar.dart';
import 'package:flutter_base/src/shared/presentation/widgets/components/form_scaffold.dart';
import 'package:flutter_base/src/shared/presentation/widgets/components/views/column_scroll_view.dart';
import 'package:flutter_base/src/user/application/profile_provider.dart';
import 'package:flutter_base/src/user/presentation/view_models/edit_profile_view_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reactive_forms_annotations/reactive_forms_annotations.dart';

class EditProfilePage extends ConsumerWidget {
  const EditProfilePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formModel = ref.watch(editProfileProvider);

    return FormScaffold(
      appBar: FlutterBaseAppBar(),
      body: ColumnScrollView(
        padding: Insets.a16,
        children: [
          ReactiveEditProfileModelForm(
            form: formModel,
            child: ReactiveFormBuilder(
              form: () => formModel.form,
              builder: (context, formGroup, child) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    BoxSpacer.v16(),
                    ReactiveTextField(
                      key: const Key('profile-name-text-field'),
                      formControl: formModel.nameControl,
                      scrollPadding:
                          MediaQuery.of(context).textFieldScrollPadding,
                      decoration: InputDecoration(
                        labelText: LocaleKeys.profile_edit_form_name.tr(),
                      ),
                    ),
                    BoxSpacer.v32(),
                    ButtonPrimary(
                      key: const Key('profile-save-button'),
                      text: LocaleKeys.profile_edit_form_submit.tr(),
                      onPressed: () => ref
                          .read(editProfileProvider.notifier)
                          .updateProfile(),
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
