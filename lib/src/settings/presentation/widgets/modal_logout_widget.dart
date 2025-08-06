import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../auth/presentation/pages/initial_page.dart';
import '../../../auth/presentation/providers/auth/auth_cubit.dart';
import '../../../shared/presentation/router/app_router.dart';
import '../../../shared/presentation/router/page_names.dart';
import '../../../shared/presentation/utils/extensions/buildcontext_extensions.dart';
import '../../../shared/presentation/widgets/components/buttons/custom_elevated_button.dart';
import '../../../shared/presentation/widgets/components/buttons/custom_outlined_button.dart';
import '../../../shared/presentation/widgets/components/text/rm_text.dart';

class ModalLogoutWidget extends StatelessWidget {
  const ModalLogoutWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const ModalLogoutWidgetContent();
  }
}

class ModalLogoutWidgetContent extends StatelessWidget {
  const ModalLogoutWidgetContent({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listenWhen: (previous, current) => previous.user != current.user,
      listener: (context, state) {
        if (state.user == null) {
          routerApp.goNamed(
            PageNames.initial,
            extra: InitialStep.signInEmail.index,
          );
        }
      },
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  RMText.bodyLarge(
                    context.cl.translate('modals.logout.subtitle'),
                    height: 1.5,
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
            const SizedBox(height: 12),
            const Divider(),
            const SizedBox(height: 12),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: CustomElevatedButton.inverse(
                padding: const EdgeInsets.symmetric(vertical: 16),
                onPressed: () => context.read<AuthCubit>().logout(),
                label: context.cl.translate('modals.logout.button.confirm'),
              ),
            ),
            const SizedBox(height: 12),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: CustomOutlinedButton.primary(
                padding: const EdgeInsets.symmetric(vertical: 16),
                onPressed: () => routerApp.pop(),
                label: context.cl.translate('modals.logout.button.cancel'),
              ),
            ),
            SizedBox(height: context.paddingBottomPlus),
          ],
        );
      },
    );
  }
}
