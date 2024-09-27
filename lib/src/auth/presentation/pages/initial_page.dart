import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_base/src/auth/presentation/states/initial_page_provider.dart';
import 'package:flutter_base/src/shared/presentation/i18n/locale_keys.g.dart';
import 'package:flutter_base/src/shared/presentation/utils/styles/insets.dart';
import 'package:flutter_base/src/shared/presentation/widgets/components/box_spacer.dart';
import 'package:flutter_base/src/shared/presentation/widgets/components/buttons/button_primary.dart';
import 'package:flutter_base/src/shared/presentation/widgets/components/buttons/button_tertiary.dart';
import 'package:flutter_base/src/shared/presentation/widgets/components/loaders/circular_progress.dart';
import 'package:flutter_base/src/shared/presentation/widgets/components/text/high_text.dart';
import 'package:flutter_base/src/shared/presentation/widgets/components/text/small_text.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:video_player/video_player.dart';

class InitialPage extends StatelessWidget {
  const InitialPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      extendBodyBehindAppBar: true,
      bottomSheet: const _BottomSheet(),
      body: Stack(
        children: [
          Consumer(
            builder: (context, ref, _) {
              return ref.watch(initialPageProvider).when(
                    data: (controller) => Positioned.fill(
                      child: FittedBox(
                        fit: BoxFit.cover,
                        child: SizedBox(
                          width: controller.value.size.width,
                          height: controller.value.size.height,
                          child: VideoPlayer(controller),
                        ),
                      ),
                    ),
                    error: (_, __) => const SizedBox.shrink(),
                    loading: () => const CircularProgress(),
                  );
            },
          ),
          Positioned.fill(
            child: Padding(
              padding: Insets.h16,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  BoxSpacer.v40(),
                  BoxSpacer.v56(),
                  HighText.xl(LocaleKeys.initialPage_title.tr()),
                  BoxSpacer.v12(),
                  SmallText.l(LocaleKeys.initialPage_claim.tr()),
                  BoxSpacer.v24(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _BottomSheet extends StatelessWidget {
  const _BottomSheet();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: Insets.h16 + Insets.v24,
      child: IntrinsicHeight(
        child: SizedBox(
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ButtonPrimary(
                onPressed: () {
                  GoRouter.of(context).push('/sign-up');
                },
                text: LocaleKeys.initialPage_getStartedBtn.tr(),
              ),
              BoxSpacer.v8(),
              ButtonTertiary(
                onPressed: () {
                  GoRouter.of(context).push('/login');
                },
                text: LocaleKeys.initialPage_loginBtn.tr(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
