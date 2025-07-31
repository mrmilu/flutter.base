import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../shared/presentation/utils/const.dart';
import '../../../shared/presentation/utils/extensions/buildcontext_extensions.dart';
import '../../../shared/presentation/utils/styles/colors.dart';
import '../../../shared/presentation/widgets/components/buttons/custom_outlined_button.dart';
import '../../../shared/presentation/widgets/components/text/rm_text.dart';
import '../pages/initial_page.dart';
import '../providers/forgot_password/forgot_password_cubit.dart';
import 'resend_email_counter_widget.dart';

class InitialContentCheckEmailToPasswordWidget extends StatefulWidget {
  const InitialContentCheckEmailToPasswordWidget({
    super.key,
    required this.currentStep,
  });
  final ValueNotifier<int> currentStep;

  @override
  State<InitialContentCheckEmailToPasswordWidget> createState() =>
      _InitialContentCheckEmailToPasswordWidgetState();
}

class _InitialContentCheckEmailToPasswordWidgetState
    extends State<InitialContentCheckEmailToPasswordWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        border: Border(
          top: BorderSide(
            color: AppColors.specificBasicGrey,
            width: 1,
          ),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 40),
                RMText.titleMedium(
                  context.cl.translate('modals.verifyResetPassword.title'),
                ),
                const SizedBox(height: 24),
                RMText.bodyMedium(
                  context.cl.translate('modals.verifyResetPassword.subtitle'),
                  height: 1.5,
                ),
              ],
            ),
          ),
          const SizedBox(height: 32),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: ResendEmailCounterWidget(
              key: const Key('resdEmailCountridetPassword'),
              text: context.cl.translate('pages.auth.resendEmail'),
              onTap: () => context.read<ForgotPasswordCubit>().forgotPassword(),
            ),
          ),
          const SizedBox(height: 32),
          const Divider(),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16),
            child: CustomOutlinedButton.primary(
              onPressed: () {
                widget.currentStep.value =
                    InitialStep.signInEmailPassword.index;
              },
              padding: const EdgeInsets.symmetric(
                vertical: paddingHightButtons,
              ),
              label: context.cl.translate(
                'modals.verifyResetPassword.button.login',
              ),
            ),
          ),
          SizedBox(height: context.paddingBottomPlus),
        ],
      ),
    );
  }
}
