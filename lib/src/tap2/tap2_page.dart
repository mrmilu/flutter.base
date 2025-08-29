import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../shared/presentation/extensions/buildcontext_extensions.dart';
import '../shared/presentation/utils/assets/app_assets_icons.dart';
import '../shared/presentation/utils/styles/colors/colors_context.dart';
import '../shared/presentation/widgets/common/button_scale_widget.dart';
import '../shared/presentation/widgets/components/buttons/custom_elevated_button.dart';
import '../shared/presentation/widgets/components/buttons/custom_icon_button.dart';
import '../shared/presentation/widgets/components/buttons/custom_outlined_button.dart';
import '../shared/presentation/widgets/components/buttons/custom_text_button.dart';
import '../shared/presentation/widgets/components/checkboxs/custom_checkbox_widget.dart';
import '../shared/presentation/widgets/components/inputs/custom_text_field_widget.dart';
import '../shared/presentation/widgets/components/radio_buttons/custom_radio_button_widget.dart';
import '../shared/presentation/widgets/components/sliders/custom_slider_widget.dart';
import '../shared/presentation/widgets/components/switchs/custom_switch_widget.dart';
import '../shared/presentation/widgets/components/tags/custom_tag_icon_widget.dart';
import '../shared/presentation/widgets/components/text/rm_text.dart';
import '../theme_mode/presentation/providers/theme_mode_cubit.dart';

class MainTap2Page extends StatelessWidget {
  const MainTap2Page({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const RMText.titleLarge('Design System'),
        actions: [
          BlocBuilder<ThemeModeCubit, ThemeModeState>(
            builder: (context, state) {
              return ButtonScaleWidget(
                onTap: () {
                  context.read<ThemeModeCubit>().toggleTheme();
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Icon(
                    state.isDarkMode ? Icons.dark_mode : Icons.light_mode,
                    size: 24,
                  ),
                ),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const RMText.titleMedium('Buttons'),
              const SizedBox(height: 8.0),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    children: [
                      CustomElevatedButton.primary(
                        label: context.cl.translate('pages.mainHome.title', {
                          'name': 'Tap',
                        }),
                        onPressed: () {},
                      ),
                      CustomElevatedButton.primary(
                        isDisabled: true,
                        label: 'Tap 2 Button',
                        onPressed: () {},
                      ),
                      CustomTextButton.primary(
                        label: 'Tap 2 Button',
                        onPressed: () {},
                      ),
                      CustomTextButton.primary(
                        enabled: false,
                        label: 'Tap 2 Button',
                        onPressed: () {},
                      ),
                      const SizedBox(height: 8.0),
                      CustomIconButton.primary(
                        iconPath: AppAssetsIcons.mail,
                        backgroundColor: context.colors.primary,
                        onPressed: () {},
                      ),
                      const SizedBox(height: 8.0),
                      CustomIconButton.primary(
                        iconPath: AppAssetsIcons.mail,
                        backgroundColor: context.colors.primary,
                        enabled: false,
                        onPressed: () {},
                      ),
                    ],
                  ),
                  const SizedBox(width: 16.0),
                  Column(
                    children: [
                      CustomOutlinedButton.primary(
                        label: 'Tap 2 Button',
                        onPressed: () {},
                      ),
                      CustomOutlinedButton.primary(
                        isDisabled: true,
                        label: 'Tap 2 Button',
                        onPressed: () {},
                      ),
                      CustomTextButton.icon(
                        key: const Key('tap2_text_button_icon'),
                        label: 'Tap 2 Button',
                        iconPath: AppAssetsIcons.mail,
                        onPressed: () {},
                      ),
                      CustomTextButton.icon(
                        enabled: false,
                        label: 'Tap 2 Button',
                        iconPath: AppAssetsIcons.mail,
                        onPressed: () {},
                      ),
                    ],
                  ),
                ],
              ),
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.add),
              ),
              IconButton.filled(
                onPressed: () {},
                icon: const Icon(Icons.add),
              ),
              IconButton.outlined(
                onPressed: () {},
                icon: const Icon(Icons.add),
              ),
              const SizedBox(height: 24.0),
              const RMText.titleMedium('Checkboxes'),
              const SizedBox(height: 8.0),
              CustomCheckboxWidget(
                textCheckbox: 'Tap 2 Checkbox',
                value: true,
                onChanged: (value) {},
              ),
              CustomCheckboxWidget(
                textCheckbox: 'Tap 2 Checkbox',
                value: false,
                onChanged: (value) {},
              ),
              CustomCheckboxWidget(
                textCheckbox: 'Tap 2 Checkbox',
                value: true,
                enabled: false,
                onChanged: (value) {},
              ),
              CustomCheckboxWidget(
                textCheckbox: 'Tap 2 Checkbox',
                value: false,
                enabled: false,
                onChanged: (value) {},
              ),
              const SizedBox(height: 8.0),
              CustomCheckboxWidget(
                textCheckbox: 'Tap 2 Checkbox',
                value: false,
                onChanged: (value) {},
                errorText: 'Error message',
                showError: true,
              ),
              const SizedBox(height: 8.0),
              CustomCheckboxWidget(
                textCheckbox: 'Tap 2 Checkbox',
                value: false,
                onChanged: (value) {},
                infoText: 'Info message',
              ),
              const SizedBox(height: 24.0),
              const RMText.titleMedium('Sliders'),
              const SizedBox(height: 8.0),
              CustomSliderWidget(
                initialValue: 2,
                min: 0.0,
                max: 5.0,
                divisions: 5,
                onChanged: (value) {},
              ),
              const SizedBox(height: 24.0),
              const RMText.titleMedium('Switches'),
              const SizedBox(height: 8.0),
              CustomSwitchWidget(
                text: 'Tap 2 Switch',
                value: true,
                onChanged: (value) {},
              ),
              const SizedBox(height: 8.0),
              CustomSwitchWidget(
                text: 'Tap 2 Switch',
                value: false,
                onChanged: (value) {},
              ),
              const SizedBox(height: 8.0),
              CustomSwitchWidget(
                text: 'Tap 2 Switch',
                value: true,
                enabled: false,
                onChanged: (value) {},
              ),
              const SizedBox(height: 8.0),
              CustomSwitchWidget(
                text: 'Tap 2 Switch',
                value: false,
                enabled: false,
                onChanged: (value) {},
              ),

              const SizedBox(height: 24.0),
              const RMText.titleMedium('Radio Buttons'),
              const SizedBox(height: 8.0),
              CustomRadioButtonWidget(
                text: 'Tap 2 Radio Button',
                value: true,
                onChanged: (value) {},
              ),
              const SizedBox(height: 8.0),
              CustomRadioButtonWidget(
                text: 'Tap 2 Radio Button',
                value: false,
                onChanged: (value) {},
              ),
              const SizedBox(height: 8.0),
              CustomRadioButtonWidget(
                text: 'Tap 2 Radio Button',
                value: false,
                enabled: false,
                onChanged: (value) {},
              ),
              const SizedBox(height: 8.0),
              CustomRadioButtonWidget(
                text: 'Tap 2 Radio Button',
                value: false,
                onChanged: (value) {},
                showError: true,
                errorText: 'Error message',
              ),
              const SizedBox(height: 8.0),
              CustomRadioButtonWidget(
                text: 'Tap 2 Radio Button',
                value: false,
                onChanged: (value) {},
                infoText: 'Info message',
              ),
              const SizedBox(height: 24.0),
              const RMText.titleMedium('Tags'),
              const SizedBox(height: 8.0),
              CustomTagIconWidget.fill(
                label: 'Tap 2 Tag',
                iconPath: AppAssetsIcons.mail,
              ),
              const SizedBox(height: 8.0),
              CustomTagIconWidget.outlined(
                label: 'Tap 2 Tag',
                iconPath: AppAssetsIcons.mail,
              ),
              const SizedBox(height: 24.0),
              const RMText.titleMedium('Inputs'),
              const SizedBox(height: 8.0),
              CustomTextFieldWidget(
                onChanged: (value) {},
                labelText: 'Tap 2 Input',
              ),
              const SizedBox(height: 40.0),
            ],
          ),
        ),
      ),
    );
  }
}
