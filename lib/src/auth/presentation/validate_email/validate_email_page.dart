import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../shared/presentation/extensions/buildcontext_extensions.dart';
import '../../../shared/presentation/extensions/color_extension.dart';
import '../../../shared/presentation/utils/launch_utils.dart';
import '../../../shared/presentation/utils/styles/colors/colors_context.dart';
import '../../../shared/presentation/widgets/components/buttons/custom_elevated_button.dart';
import '../../../shared/presentation/widgets/components/buttons/custom_text_button.dart';
import '../../../shared/presentation/widgets/components/text/rm_text.dart';
import '../providers/auth/auth_cubit.dart';
import '../widgets/resend_email_counter_widget.dart';

class ValidateEmailPage extends StatelessWidget {
  const ValidateEmailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: RMText.titleMedium(
          context.cl.translate(
            'pages.auth.validateEmail.title',
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 24),
                Center(
                  child: Container(
                    height: 80,
                    width: 80,
                    decoration: BoxDecoration(
                      color: context.colors.specificContentLow,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.mail,
                      size: 32,
                      color: Colors.white,
                    ),
                  ),
                ),

                const SizedBox(height: 12),
                Center(
                  child: RMText.titleLarge(
                    context.cl.translate(
                      'pages.auth.validateEmail.checkYourEmail',
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: 12),
                Center(
                  child: RMText.bodyMedium(
                    context.cl.translate(
                      'pages.auth.validateEmail.sentTo',
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: 8),
                BlocBuilder<AuthCubit, AuthState>(
                  builder: (context, state) {
                    final user = state.user;
                    return Center(
                      child: RMText.titleSmall(
                        user?.email ?? '___',
                        textAlign: TextAlign.center,
                      ),
                    );
                  },
                ),
                const SizedBox(height: 16),
                Center(
                  child: RMText.bodyMedium(
                    context.cl.translate(
                      'pages.auth.validateEmail.clickEmail',
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: 32),
                CustomElevatedButton.inverse(
                  onPressed: () => launchEmailApp(context),
                  padding: const EdgeInsets.symmetric(
                    vertical: 16,
                  ),
                  label: context.cl.translate(
                    'pages.auth.validateEmail.openEmailApp',
                  ),
                ),
                const SizedBox(height: 32),
                Container(
                  decoration: BoxDecoration(
                    color: context.colors.specificContentLow.wOpacity(0.2),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12.0,
                      vertical: 4,
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.access_time_filled, size: 20),
                        const SizedBox(width: 8),
                        ResendEmailCounterWidget(
                          text: context.cl.translate(
                            'pages.auth.validateEmail.resendEmail',
                          ),
                          textInTimer: context.cl.translate(
                            'pages.auth.validateEmail.resendAvailable',
                          ),
                          onTap: () {},
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 32),
                Center(
                  child: RMText.bodyMedium(
                    context.cl.translate(
                      'pages.auth.validateEmail.notReceived',
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                Center(
                  child: CustomTextButton.secondary(
                    label: context.cl.translate(
                      'pages.auth.validateEmail.contactSupport',
                    ),
                    textStyle: context.textTheme.bodyMedium?.copyWith(
                      decoration: TextDecoration.underline,
                    ),
                    onPressed: () {},
                  ),
                ),
                const SizedBox(height: 24),
                Container(
                  decoration: BoxDecoration(
                    color: context.colors.specificContentLow.wOpacity(0.2),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12.0,
                      vertical: 8,
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Icon(Icons.info, size: 20),
                        const SizedBox(width: 8),
                        Flexible(
                          child: RMText.bodyMedium(
                            context.cl.translate(
                              'pages.auth.validateEmail.info',
                            ),
                            height: 1.5,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
