import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../auth/presentation/providers/auth/auth_cubit.dart';
import '../../../../shared/domain/types/user_auth_provider_type.dart';
import '../../../../shared/presentation/extensions/buildcontext_extensions.dart';
import '../../../../shared/presentation/router/app_router.dart';
import '../../../../shared/presentation/router/page_names.dart';
import '../../../../shared/presentation/widgets/components/text/rm_text.dart';
import '../../../../shared/presentation/widgets/wrapper_bottom_sheet_with_button.dart';
import '../../widgets/settings_item_widget.dart';
import 'required_password/modal_requiered_password_widget.dart';

class ProfileInfoAccessDataPage extends StatelessWidget {
  const ProfileInfoAccessDataPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: RMText.titleMedium(
          context.cl.translate('pages.profileInfoAccessData.title'),
        ),
      ),
      body: SingleChildScrollView(
        child: ConstrainedBox(
          constraints: BoxConstraints(
            minHeight:
                MediaQuery.of(context).size.height -
                MediaQuery.of(context).padding.top -
                kToolbarHeight,
          ),
          child: IntrinsicHeight(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 32),
                  BlocBuilder<AuthCubit, AuthState>(
                    builder: (context, stateAuth) {
                      final userEmail = stateAuth.user?.email ?? '';
                      return SettingsItemWidget(
                        isActive: false,
                        title: context.cl.translate(
                          'pages.profileInfoAccessData.email.title',
                        ),
                        subtitle: userEmail,
                        onTap: () => goToChangeEmail(context),
                      );
                    },
                  ),
                  const SizedBox(height: 20),
                  BlocBuilder<AuthCubit, AuthState>(
                    builder: (context, stateAuth) {
                      final userProvider = stateAuth.user?.authProvider;
                      return SettingsItemWidget(
                        title: context.cl.translate(
                          'pages.profileInfoAccessData.password.title',
                        ),
                        subtitle: '************',
                        isActive: userProvider == UserAuthProviderType.email,
                        onTap: () => goToChangePassword(context),
                      );
                    },
                  ),
                  const SizedBox(height: 20),
                ].animate(interval: 40.milliseconds).slideY().fadeIn(),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> goToChangeEmail(BuildContext context) async {
    final result = await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => WrapperBottomSheetWithButton(
        hasScroll: false,
        title: context.cl.translate('modals.changeEmail.title'),
        child: ModalRequiredPassword(
          title: context.cl.translate('modals.changeEmail.subtitle'),
          textButton: context.cl.translate('modals.changeEmail.form.button'),
        ),
      ),
    );
    if (result == true) {
      routerApp.pushNamed(PageNames.profileInfoAccessDataChangeEmail);
    }
  }

  Future<void> goToChangePassword(BuildContext context) async {
    routerApp.pushNamed(PageNames.profileInfoAccessDataChangePassword);
    // final result = await showModalBottomSheet(
    //   context: context,
    //   isScrollControlled: true,
    //   builder: (context) => WrapperBottomSheetWithButton(
    //     hasScroll: false,
    //     title: context.cl.translate('modals.changePassword.title'),
    //     child: ModalRequiredPassword(
    //       title: context.cl.translate('modals.changePassword.subtitle'),
    //       textButton: context.cl.translate('modals.changePassword.form.button'),
    //     ),
    //   ),
    // );
    // if (result == true) {
    //   routerApp.pushNamed(PageNames.profileInfoAccessDataChangePassword);
    // }
  }
}
