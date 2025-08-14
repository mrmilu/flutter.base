import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../src/shared/presentation/providers/theme_mode/theme_mode_cubit.dart';
import '../src/shared/presentation/utils/assets/app_assets_icons.dart';
import '../src/shared/presentation/widgets/common/button_scale_widget.dart';
import '../src/shared/presentation/widgets/components/buttons/custom_elevated_button.dart';
import '../src/shared/presentation/widgets/components/buttons/custom_icon_button.dart';
import '../src/shared/presentation/widgets/components/buttons/custom_outlined_button.dart';
import '../src/shared/presentation/widgets/components/buttons/custom_text_button.dart';
import '../src/shared/presentation/widgets/components/checkboxs/custom_checkbox_widget.dart';
import '../src/shared/presentation/widgets/components/inputs/custom_code_field_widget.dart';
import '../src/shared/presentation/widgets/components/inputs/custom_dropdown_field_package_widget.dart';
import '../src/shared/presentation/widgets/components/inputs/custom_states_text_field_widget.dart';
import '../src/shared/presentation/widgets/components/inputs/custom_text_field_widget.dart';
import '../src/shared/presentation/widgets/components/inputs/imput_formatters/iban_input_formatter.dart';
import '../src/shared/presentation/widgets/components/sliders/custom_slider_widget.dart';
import '../src/shared/presentation/widgets/components/switchs/custom_switch_widget.dart';
import '../src/shared/presentation/widgets/components/tags/custom_tag_icon_widget.dart';
import '../src/shared/presentation/widgets/components/text/rm_text.dart';

class WebPage extends StatelessWidget {
  const WebPage({super.key});

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
              const RMText.titleLarge('Buttons'),
              const SizedBox(height: 8.0),
              const RMText.titleSmall('Primary'),
              const SizedBox(height: 8.0),
              Row(
                children: [
                  CustomElevatedButton.primary(
                    label: 'Tap 2 Button',
                    onPressed: () {},
                  ),
                  const SizedBox(width: 8.0),
                  CustomElevatedButton.primary(
                    isDisabled: true,
                    label: 'Tap 2 Button',
                    onPressed: () {},
                  ),
                ],
              ),
              const SizedBox(height: 8.0),
              const RMText.titleSmall('Secondary'),
              const SizedBox(height: 8.0),
              Row(
                children: [
                  CustomOutlinedButton.primary(
                    label: 'Tap 2 Button',
                    onPressed: () {},
                  ),
                  const SizedBox(width: 8.0),
                  CustomOutlinedButton.primary(
                    isDisabled: true,
                    label: 'Tap 2 Button',
                    onPressed: () {},
                  ),
                ],
              ),
              const SizedBox(height: 8.0),
              const RMText.titleSmall('Text Button'),
              const SizedBox(height: 8.0),
              Row(
                children: [
                  CustomTextButton.primary(
                    label: 'Tap 2 Button',
                    onPressed: () {},
                  ),
                  const SizedBox(width: 8.0),
                  CustomTextButton.primary(
                    enabled: false,
                    label: 'Tap 2 Button',
                    onPressed: () {},
                  ),
                  const SizedBox(width: 12.0),
                  CustomTextButton.icon(
                    label: 'Tap 2 Button',
                    onPressed: () {},
                    iconPath: AppAssetsIcons.mail,
                  ),
                  const SizedBox(width: 8.0),
                  CustomTextButton.icon(
                    enabled: false,
                    label: 'Tap 2 Button',
                    onPressed: () {},
                    iconPath: AppAssetsIcons.mail,
                  ),
                ],
              ),
              const SizedBox(height: 8.0),
              const RMText.titleSmall('Icon Button'),
              const SizedBox(height: 8.0),
              Row(
                children: [
                  CustomIconButton.primary(
                    iconPath: AppAssetsIcons.mail,
                    onPressed: () {},
                  ),
                  const SizedBox(width: 8.0),
                  CustomIconButton.primary(
                    isLoading: true,
                    iconPath: AppAssetsIcons.mail,
                    onPressed: () {},
                  ),
                  const SizedBox(width: 8.0),
                  CustomIconButton.primary(
                    enabled: false,
                    iconPath: AppAssetsIcons.mail,
                    onPressed: () {},
                  ),
                ],
              ),
              const SizedBox(height: 24.0),
              const RMText.titleLarge('Checkboxes'),
              const SizedBox(height: 8.0),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Flexible(
                    child: CustomCheckboxWidget(
                      textCheckbox: 'Tap 2 Checkbox',
                      value: true,
                      onChanged: (value) {},
                    ),
                  ),
                  Flexible(
                    child: CustomCheckboxWidget(
                      textCheckbox: 'Tap 2 Checkbox',
                      value: false,
                      onChanged: (value) {},
                    ),
                  ),
                  Flexible(
                    child: CustomCheckboxWidget(
                      textCheckbox: 'Tap 2 Checkbox',
                      value: true,
                      enabled: false,
                      onChanged: (value) {},
                    ),
                  ),
                  Flexible(
                    child: CustomCheckboxWidget(
                      textCheckbox: 'Tap 2 Checkbox',
                      value: false,
                      enabled: false,
                      onChanged: (value) {},
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8.0),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Flexible(
                    child: CustomCheckboxWidget(
                      textCheckbox: 'Tap 2 Checkbox',
                      value: false,
                      onChanged: (value) {},
                      errorText: 'Error message',
                      showError: true,
                    ),
                  ),
                  Flexible(
                    child: CustomCheckboxWidget(
                      textCheckbox: 'Tap 2 Checkbox',
                      value: false,
                      onChanged: (value) {},
                      infoText: 'Info message',
                    ),
                  ),
                  const Flexible(
                    child: SizedBox(),
                  ),
                  const Flexible(
                    child: SizedBox(),
                  ),
                ],
              ),
              const SizedBox(height: 24.0),
              const RMText.titleLarge('Sliders'),
              const SizedBox(height: 8.0),
              CustomSliderWidget(
                initialValue: 2,
                min: 0.0,
                max: 5.0,
                divisions: 5,
                onChanged: (value) {},
              ),
              const SizedBox(height: 12.0),
              const RMText.titleLarge('Switches'),
              const SizedBox(height: 8.0),
              Row(
                children: [
                  Flexible(
                    child: CustomSwitchWidget(
                      text: 'Tap 2 Switch',
                      value: true,
                      onChanged: (value) {},
                    ),
                  ),
                  Flexible(
                    child: CustomSwitchWidget(
                      text: 'Tap 2 Switch',
                      value: false,
                      onChanged: (value) {},
                    ),
                  ),
                  Flexible(
                    child: CustomSwitchWidget(
                      text: 'Tap 2 Switch',
                      value: true,
                      enabled: false,
                      onChanged: (value) {},
                    ),
                  ),
                  Flexible(
                    child: CustomSwitchWidget(
                      text: 'Tap 2 Switch',
                      value: false,
                      enabled: false,
                      onChanged: (value) {},
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24.0),
              const RMText.titleLarge('Tags'),
              const SizedBox(height: 8.0),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CustomTagIconWidget.fill(
                    label: 'Tap 2 Tag',
                    iconPath: AppAssetsIcons.mail,
                  ),
                  const SizedBox(width: 8.0),
                  CustomTagIconWidget.outlined(
                    label: 'Tap 2 Tag',
                    iconPath: AppAssetsIcons.mail,
                  ),
                ],
              ),
              const SizedBox(height: 24.0),
              const RMText.titleLarge('Inputs'),
              const SizedBox(height: 8.0),
              CustomTextFieldWidget(
                onChanged: (value) {},
                labelText: 'Label',
                initialValue: 'Test',
              ),
              const SizedBox(height: 8.0),
              CustomTextFieldWidget(
                enabled: false,
                onChanged: (value) {},
                labelText: 'Label',
                initialValue: 'Test',
              ),
              const SizedBox(height: 8.0),
              CustomTextFieldWidget(
                readOnly: true,
                onChanged: (value) {},
                labelText: 'Label',
                initialValue: 'Test',
              ),
              const SizedBox(height: 8.0),
              CustomTextFieldWidget(
                showError: true,
                errorText: 'Error message',
                onChanged: (value) {},
                labelText: 'Label',
                initialValue: 'Test',
              ),
              const SizedBox(height: 8.0),
              CustomTextFieldWidget(
                onChanged: (value) {},
                labelText: 'Label',
                infoText: 'Info message',
                initialValue: 'Test',
              ),
              const SizedBox(height: 8.0),
              CustomStatesTextFieldWidget(
                onChanged: (value) {},
                labelText: 'Label',
                initialValue: 'Test',
                onCompleted: (_) {},
                inputFormatters: [
                  IbanInputFormatter(),
                  LengthLimitingTextInputFormatter(28),
                ],
              ),
              const SizedBox(height: 8.0),
              CustomStatesTextFieldWidget(
                onChanged: (value) {},
                labelText: 'Label',
                initialValue: 'Test',
                onCompleted: (_) {},
                isLoading: true,
                inputFormatters: [
                  IbanInputFormatter(),
                  LengthLimitingTextInputFormatter(28),
                ],
              ),
              const SizedBox(height: 8.0),
              CustomStatesTextFieldWidget(
                onChanged: (value) {},
                labelText: 'Label',
                initialValue: 'Test',
                onCompleted: (_) {},
                isAccepted: true,
                inputFormatters: [
                  IbanInputFormatter(),
                  LengthLimitingTextInputFormatter(28),
                ],
              ),
              const SizedBox(height: 8.0),
              CustomDropdownFieldPackageWidget<String>(
                title: 'Select Language',
                items: [
                  const DropdownMenuItem(
                    value: 'en',
                    child: RMText.bodyMedium('English'),
                  ),
                  const DropdownMenuItem(
                    value: 'es',
                    child: RMText.bodyMedium('Spanish'),
                  ),
                ],
                onChanged: (value) {},
                initialValue: 'es',
                value: 'es',
              ),
              const SizedBox(height: 8.0),
              CustomCodeFieldWidget(onCompleted: (p0) {}),
              const SizedBox(height: 40.0),
            ],
          ),
        ),
      ),
    );
  }
}
