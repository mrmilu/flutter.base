import 'package:flutter/material.dart';

import '../../../shared/presentation/extensions/buildcontext_extensions.dart';
import '../../../shared/presentation/extensions/color_extension.dart';
import '../../../shared/presentation/router/app_router.dart';
import '../../../shared/presentation/router/page_names.dart';
import '../../../shared/presentation/utils/styles/colors/colors_context.dart';
import '../../../shared/presentation/widgets/common/image_asset_widget.dart';
import '../../../shared/presentation/widgets/components/buttons/custom_elevated_button.dart';
import '../../../shared/presentation/widgets/components/buttons/custom_outlined_button.dart';
import '../../../shared/presentation/widgets/components/text/rm_text.dart';

class InitialPage extends StatelessWidget {
  const InitialPage({super.key, this.initialStep = 0});
  final int initialStep;

  @override
  Widget build(BuildContext context) {
    return const InitialView();
  }
}

class InitialView extends StatelessWidget {
  const InitialView({super.key});

  void _onCreateAccount(BuildContext context) {
    routerApp.pushReplacementNamed(PageNames.signUp);
  }

  void _onSignIn(BuildContext context) {
    routerApp.pushReplacementNamed(PageNames.signIn);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: const Key('initial_page'),
      backgroundColor: context.colors.background,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 40),

              // Imagen pequeña (logo)
              Center(
                child: Container(
                  height: 60,
                  width: 60,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: context.colors.primary.wOpacity(0.1),
                  ),
                  child: const Center(
                    child: ImageAssetWidget(
                      path: 'assets/images/ente_partial.png',
                      height: 40,
                      width: 40,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 16),

              // Texto welcome
              RMText.headlineMedium(
                context.cl.translate('pages.auth.initial.welcome'),
                textAlign: TextAlign.center,
                color: context.colors.onBackground,
              ),

              const SizedBox(height: 48),

              // Imagen ilustración (más grande)
              Expanded(
                flex: 2,
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: context.colors.specificSurfaceLow,
                  ),
                  child: const Padding(
                    padding: EdgeInsets.all(24),
                    child: ImageAssetWidget(
                      path: 'assets/images/ente_partial.png',
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 32),

              // Título
              RMText.titleLarge(
                context.cl.translate('pages.auth.initial.title'),
                textAlign: TextAlign.center,
                color: context.colors.onBackground,
              ),

              const SizedBox(height: 16),

              // Descripción
              RMText.bodyMedium(
                context.cl.translate('pages.auth.initial.description'),
                textAlign: TextAlign.center,
                color: context.colors.specificContentMid,
              ),

              const Spacer(),

              // Botones
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Botón Create Account
                  CustomElevatedButton.inverse(
                    onPressed: () => _onCreateAccount(context),
                    label: context.cl.translate(
                      'pages.auth.initial.createAccount',
                    ),
                  ),

                  const SizedBox(height: 12),

                  // Botón Sign In
                  CustomOutlinedButton.primary(
                    onPressed: () => _onSignIn(context),
                    label: context.cl.translate('pages.auth.initial.signIn'),
                  ),
                ],
              ),

              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }
}
