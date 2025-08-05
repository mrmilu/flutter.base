import 'package:flutter/material.dart';

import '../../../../../shared/domain/failures/password_failure.dart';
import '../../../../../shared/domain/failures_extensions/password_failure_extension.dart';
import '../../../../../shared/domain/vos/password_vos.dart';
import '../../../../../shared/presentation/utils/assets/app_assets_icons.dart';
import '../../../../../shared/presentation/utils/extensions/buildcontext_extensions.dart';
import '../../../../../shared/presentation/utils/styles/colors/colors_context.dart';
import '../../../../../shared/presentation/widgets/common/image_asset_widget.dart';

class InfoPasswordValidatorWidget extends StatelessWidget {
  const InfoPasswordValidatorWidget({
    super.key,
    required this.password,
    required this.showError,
  });
  final String password;
  final bool showError;

  Color getColorMinLength(BuildContext context) {
    if (showError) {
      return password.length < 8
          ? context.colors.specificSemanticError
          : context.colors.specificSemanticSuccess;
    }
    return context.colors.specificBasicBlack;
  }

  Color getColorIncludeUppercase(BuildContext context) {
    if (showError) {
      return !RegExp(r'^(?=.*[A-Z])').hasMatch(password)
          ? context.colors.specificSemanticError
          : context.colors.specificSemanticSuccess;
    }
    return context.colors.specificBasicBlack;
  }

  Color getColorIncludeLowercase(BuildContext context) {
    if (showError) {
      return !RegExp(r'^(?=.*[a-z])').hasMatch(password)
          ? context.colors.specificSemanticError
          : context.colors.specificSemanticSuccess;
    }
    return context.colors.specificBasicBlack;
  }

  Color getColorIncludeDigit(BuildContext context) {
    if (showError) {
      return !RegExp(r'^(?=.*[!@#$%^&*])').hasMatch(password)
          ? context.colors.specificSemanticError
          : context.colors.specificSemanticSuccess;
    }
    return context.colors.specificBasicBlack;
  }

  Color getIconColor(BuildContext context) {
    final passwordVos = PasswordVos(password);
    if (showError) {
      return passwordVos.isInvalid()
          ? context.colors.specificSemanticError
          : context.colors.specificSemanticSuccess;
    }
    return context.colors.specificBasicBlack;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 2.0),
          child: ImageAssetWidget(
            path: AppAssetsIcons.info,
            width: 16,
            height: 16,
            color: getIconColor(context),
          ),
        ),
        const SizedBox(width: 4),
        Flexible(
          child: RichText(
            text: TextSpan(
              text: '',
              children: [
                TextSpan(
                  text:
                      '${PasswordFailure.minLength(8).toTranslation(context)}\n',
                  style: context.textTheme.labelMedium?.copyWith(
                    color: getColorMinLength(context),
                    height: 1.5,
                  ),
                ),
                TextSpan(
                  text:
                      '${PasswordFailure.includeUppercase().toTranslation(context)}\n',
                  style: context.textTheme.labelMedium?.copyWith(
                    color: getColorIncludeUppercase(context),
                    height: 1.5,
                  ),
                ),
                TextSpan(
                  text:
                      '${PasswordFailure.includeLowercase().toTranslation(context)}\n',
                  style: context.textTheme.labelMedium?.copyWith(
                    color: getColorIncludeLowercase(context),
                    height: 1.5,
                  ),
                ),
                TextSpan(
                  text: PasswordFailure.includeDigit().toTranslation(context),
                  style: context.textTheme.labelMedium?.copyWith(
                    color: getColorIncludeDigit(context),
                    height: 1.5,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
