import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../shared/presentation/utils/const.dart';
import '../../../shared/presentation/utils/extensions/buildcontext_extensions.dart';
import '../../../shared/presentation/utils/styles/colors.dart';
import '../../../shared/presentation/widgets/components/buttons/custom_outlined_button.dart';
import '../../../shared/presentation/widgets/components/text/rm_text.dart';
import '../pages/initial_page.dart';
import '../providers/auth/auth_cubit.dart';
import '../providers/validate_email/validate_email_cubit.dart';
import 'resend_email_counter_widget.dart';

class InitialContentConfirmYourAccountWidget extends StatefulWidget {
  const InitialContentConfirmYourAccountWidget({
    super.key,
    required this.currentStep,
  });
  final ValueNotifier<int> currentStep;

  @override
  State<InitialContentConfirmYourAccountWidget> createState() =>
      _InitialContentConfirmYourAccountWidgetState();
}

class _InitialContentConfirmYourAccountWidgetState
    extends State<InitialContentConfirmYourAccountWidget> {
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
                  context.cl.translate('modals.confirmYourAccount.title'),
                ),
                const SizedBox(height: 24),
                RMText.bodyMedium(
                  context.cl.translate('modals.confirmYourAccount.subtitle'),
                  height: 1.5,
                ),
              ],
            ),
          ),
          const SizedBox(height: 32),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: ResendEmailCounterWidget(
              key: const Key('resdEmailCountridet'),
              text: context.cl.translate('pages.auth.resendEmail'),
              onTap: () => context.read<ValidateEmailCubit>().resendEmail(),
            ),
          ),
          const SizedBox(height: 32),
          const Divider(),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16),
            child: BlocConsumer<AuthCubit, AuthState>(
              listener: (context, state) {
                if (state.user == null) {
                  widget.currentStep.value = InitialStep.signInEmail.index;
                }
              },
              builder: (context, state) {
                return CustomOutlinedButton.primary(
                  onPressed: () => context.read<AuthCubit>().logout(),
                  padding: const EdgeInsets.symmetric(
                    vertical: paddingHightButtons,
                  ),
                  label: context.cl.translate(
                    'modals.confirmYourAccount.button.logout',
                  ),
                );
              },
            ),
          ),
          SizedBox(height: context.paddingBottomPlus),
        ],
      ),
    );
  }
}
