import 'package:flutter/material.dart';

import '../../../shared/presentation/utils/assets/app_assets_icons.dart';
import '../../../shared/presentation/utils/extensions/buildcontext_extensions.dart';
import '../../../shared/presentation/widgets/common/image_asset_widget.dart';
import '../../../shared/presentation/widgets/components/buttons/custom_elevated_button.dart';
import '../../../shared/presentation/widgets/components/buttons/custom_text_button.dart';
import '../../../shared/presentation/widgets/components/inputs/custom_text_field_widget.dart';
import '../../../shared/presentation/widgets/components/text/rm_text.dart';

class InitialSignupWidget extends StatelessWidget {
  const InitialSignupWidget({super.key, required this.onTapBack});
  final VoidCallback onTapBack;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              InkWell(
                onTap: onTapBack,
                child: const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: ImageAssetWidget(
                    path: AppAssetsIcons.arrowIosLeft,
                  ),
                ),
              ),
              Expanded(
                child: RMText.titleSmall(
                  context.cl.translate('pages.auth.signInEmail.title'),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(
                width: 32,
              ),
            ],
          ),
          const SizedBox(height: 20),
          RMText.bodyMedium(
            context.cl.translate('pages.auth.signInEmail.subtitle'),
          ),
          const SizedBox(height: 24),
          CustomTextFieldWidget(
            autoHideKeyboard: false,
            autofocus: true,
            onChanged: (value) {},
            labelText: context.cl.translate(
              'pages.auth.signInEmail.form.password',
            ),
          ),
          const SizedBox(height: 8),
          CustomTextButton.icon(
            onPressed: () {},
            label: context.cl.translate(
              'pages.auth.signInEmail.forgotPassword',
            ),
            iconPath: AppAssetsIcons.arrowRight,
          ),
          const Divider(),
          const SizedBox(height: 8),
          CustomElevatedButton.inverse(
            onPressed: onTapBack,
            padding: const EdgeInsets.symmetric(vertical: 16),
            label: context.cl.translate('pages.auth.signInEmail.form.button'),
          ),
        ],
      ),
    );
  }
}
