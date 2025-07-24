import 'package:flutter/material.dart';

import '../../../../../shared/domain/failures/password_failure.dart';
import '../../../../../shared/domain/failures_extensions/password_failure_extension.dart';
import '../../../../../shared/domain/vos/password_vos.dart';
import '../../../../../shared/presentation/utils/styles/colors.dart';
import '../../../../../shared/presentation/utils/styles/text_styles.dart';
import '../../../../../shared/presentation/widgets/image_asset_widget.dart';

class InfoPasswordValidatorWidget extends StatelessWidget {
  const InfoPasswordValidatorWidget({
    super.key,
    required this.password,
    required this.showError,
  });
  final String password;
  final bool showError;

  Color getColorMinLength() {
    if (showError) {
      return password.length < 8
          ? AppColors.specificSemanticError
          : AppColors.specificSemanticSuccess;
    }
    return AppColors.specificBasicBlack;
  }

  Color getColorIncludeUppercase() {
    if (showError) {
      return !RegExp(r'^(?=.*[A-Z])').hasMatch(password)
          ? AppColors.specificSemanticError
          : AppColors.specificSemanticSuccess;
    }
    return AppColors.specificBasicBlack;
  }

  Color getColorIncludeLowercase() {
    if (showError) {
      return !RegExp(r'^(?=.*[a-z])').hasMatch(password)
          ? AppColors.specificSemanticError
          : AppColors.specificSemanticSuccess;
    }
    return AppColors.specificBasicBlack;
  }

  Color getColorIncludeDigit() {
    if (showError) {
      return !RegExp(r'^(?=.*[!@#$%^&*])').hasMatch(password)
          ? AppColors.specificSemanticError
          : AppColors.specificSemanticSuccess;
    }
    return AppColors.specificBasicBlack;
  }

  Color getIconColor() {
    final passwordVos = PasswordVos(password);
    if (showError) {
      return passwordVos.isInvalid()
          ? AppColors.specificSemanticError
          : AppColors.specificSemanticSuccess;
    }
    return AppColors.specificBasicBlack;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 2.0),
          child: ImageAssetWidget(
            path: 'assets/icons/top_bar_info.svg',
            width: 16,
            height: 16,
            color: getIconColor(),
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
                  style: TextStyles.caption1.copyWith(
                    color: getColorMinLength(),
                    height: 1.5,
                  ),
                ),
                TextSpan(
                  text:
                      '${PasswordFailure.includeUppercase().toTranslation(context)}\n',
                  style: TextStyles.caption1.copyWith(
                    color: getColorIncludeUppercase(),
                    height: 1.5,
                  ),
                ),
                TextSpan(
                  text:
                      '${PasswordFailure.includeLowercase().toTranslation(context)}\n',
                  style: TextStyles.caption1.copyWith(
                    color: getColorIncludeLowercase(),
                    height: 1.5,
                  ),
                ),
                TextSpan(
                  text: PasswordFailure.includeDigit().toTranslation(context),
                  style: TextStyles.caption1.copyWith(
                    color: getColorIncludeDigit(),
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
