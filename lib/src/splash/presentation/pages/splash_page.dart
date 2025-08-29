import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../auth/domain/interfaces/i_token_repository.dart';
import '../../../auth/presentation/pages/initial_page.dart';
import '../../../auth/presentation/providers/auth/auth_cubit.dart';
import '../../../shared/presentation/extensions/buildcontext_extensions.dart';
import '../../../shared/presentation/helpers/toasts.dart';
import '../../../shared/presentation/l10n/generated/l10n.dart';
import '../../../shared/presentation/router/app_router.dart';
import '../../../shared/presentation/router/page_names.dart';
import '../../../shared/presentation/utils/styles/colors/colors_context.dart';
import '../../../shared/presentation/widgets/components/buttons/custom_elevated_button.dart';
import '../../../shared/presentation/widgets/components/text/rm_text.dart';
import '../extensions/splash_failure_extension.dart';
import '../providers/app_settings_cubit.dart';
import '../providers/splash_cubit.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SplashCubit(
        settingsCubit: context.read<AppSettingsCubit>(),
        authCubit: context.read<AuthCubit>(),

        tokenRepository: context.read<ITokenRepository>(),
      )..check(),
      child: const SplashView(),
    );
  }
}

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> opacity;

  @override
  void initState() {
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );
    opacity =
        TweenSequence(<TweenSequenceItem<double>>[
          TweenSequenceItem(
            tween: Tween(begin: 1.0, end: 0.0),
            weight: 50,
          ),
          TweenSequenceItem(
            tween: Tween(begin: 0.0, end: 1.0),
            weight: 50,
          ),
        ]).animate(
          CurvedAnimation(
            parent: _controller,
            curve: const Interval(
              0.0,
              1.0,
              curve: Curves.ease,
            ),
          ),
        );
    super.initState();

    // Set the system UI overlay style
    if (Platform.isAndroid) {
      SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarBrightness: Brightness.dark,
          statusBarIconBrightness: Brightness.dark,
        ),
      );
    }

    _controller.repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void redirectToPage(BuildContext context) {
    final user = context.read<AuthCubit>().state.user;

    if (user == null) {
      routerApp.pushReplacementNamed(
        PageNames.onboarding,
        extra: InitialStep.signUpEmail.index,
      );
      return;
    }

    if (!user.isValidated) {
      routerApp.pushReplacementNamed(
        PageNames.initial,
        extra: InitialStep.confirmYourAccount.index,
      );
      return;
    }

    if (user.document == null) {
      routerApp.pushReplacementNamed(
        PageNames.initial,
        extra: InitialStep.updateDocument.index,
      );
      return;
    }

    routerApp.pushReplacementNamed(PageNames.mainHome);
    return;
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<SplashCubit, SplashState>(
      listenWhen: (previous, current) =>
          previous.splashIsLoaded != current.splashIsLoaded,
      listener: (context, state) async {
        context.read<SplashCubit>().changeReadyToNavigate(true);
      },
      child: BlocConsumer<SplashCubit, SplashState>(
        listener: (context, state) {
          if (state.readyToNavigate) {
            redirectToPage(context);
          }
          state.resultOrLoad.whenIsFailure(
            (failure) =>
                showError(context, message: failure.toTranslate(context)),
          );
        },
        builder: (context, stateSplash) {
          final size = MediaQuery.sizeOf(context);
          return Scaffold(
            body: Stack(
              children: [
                SizedBox(
                  height: size.height,
                  width: size.width,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Column(
                        children: [
                          AnimatedBuilder(
                            animation: _controller,
                            builder: (context, child) {
                              return Opacity(
                                opacity: opacity.value,
                                child: const FlutterLogo(
                                  size: 120,
                                ),
                              );
                            },
                          ),

                          stateSplash.canUpdate
                              ? Column(
                                  children: [
                                    const SizedBox(height: 24),
                                    RMText.headlineLarge(
                                      S.of(context).pageSplashUpdateAvailable,
                                    ),
                                    const SizedBox(height: 20),
                                    SizedBox(
                                      width: size.width * 0.65,
                                      child: RMText.bodyLarge(
                                        S
                                            .of(context)
                                            .pageSplashUpdateAvailableDesc,
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  ],
                                )
                              : Column(
                                  children: [
                                    const SizedBox(height: 24),
                                    RMText.headlineLarge(
                                      context.cl.translate(
                                        'pages.splash.title',
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                    const SizedBox(height: 4),
                                    RMText.bodyLarge(
                                      context.cl.translate(
                                        'pages.splash.subtitle',
                                      ),

                                      textAlign: TextAlign.center,
                                    ),
                                    const SizedBox(height: 32),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Container(
                                          width: 4,
                                          height: 4,
                                          decoration: BoxDecoration(
                                            color: context
                                                .colors
                                                .specificContentLow,
                                            shape: BoxShape.circle,
                                          ),
                                        ),
                                        const SizedBox(width: 4),
                                        Container(
                                          width: 4,
                                          height: 4,
                                          decoration: BoxDecoration(
                                            color: context
                                                .colors
                                                .specificContentLow,
                                            shape: BoxShape.circle,
                                          ),
                                        ),
                                        const SizedBox(width: 4),
                                        Container(
                                          width: 4,
                                          height: 4,
                                          decoration: BoxDecoration(
                                            color: context
                                                .colors
                                                .specificContentLow,
                                            shape: BoxShape.circle,
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 24),
                                    if (appVersion.isNotEmpty)
                                      RMText.bodySmall(
                                        context.cl.translate(
                                          'pages.splash.version',
                                          {
                                            'value': appVersion,
                                          },
                                        ),
                                        color:
                                            context.colors.specificContentLow,
                                        textAlign: TextAlign.center,
                                      ),
                                  ],
                                ),
                        ],
                      ),
                    ],
                  ),
                ),
                stateSplash.canUpdate
                    ? Positioned(
                        bottom: 32,
                        left: 25,
                        right: 25,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            CustomElevatedButton.inverse(
                              onPressed: context
                                  .read<SplashCubit>()
                                  .onTapUpdateApp,
                              label: S.of(context).pageSplashUpdate,
                            ),
                          ],
                        ),
                      )
                    : stateSplash.errorLoading
                    ? Positioned(
                        bottom: 32,
                        left: 25,
                        right: 25,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                padding: const EdgeInsets.all(20.0),
                                backgroundColor: context.colors.secondary,
                              ),
                              onPressed: context.read<SplashCubit>().loadData,
                              child: Text(
                                S.of(context).pageSplashReload,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    : Positioned(
                        bottom: 60,
                        left: 33,
                        right: 33,
                        child: Column(
                          children: [
                            Text(
                              _getProgressTextByValue(
                                stateSplash.progressValue,
                              ),
                              style: TextStyle(
                                color: context.colors.specificContentLow,
                              ),
                            ),
                            const SizedBox(height: 16),
                            ClipRRect(
                              borderRadius: const BorderRadius.all(
                                Radius.circular(10),
                              ),
                              child: Container(
                                height: 6,
                                width: size.width - 66,
                                color: context.colors.specificBasicGrey,
                                alignment: Alignment.centerLeft,
                                child: ClipRRect(
                                  borderRadius: const BorderRadius.all(
                                    Radius.circular(10),
                                  ),
                                  child: AnimatedContainer(
                                    duration: const Duration(
                                      milliseconds: 1300,
                                    ),
                                    curve: Curves.easeInOut,
                                    color: context.isDarkMode
                                        ? Colors.white
                                        : Colors.black,
                                    width:
                                        (stateSplash.progressValue *
                                        (size.width - 66)),
                                    height: 8,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
              ],
            ),
          );
        },
      ),
    );
  }

  String _getProgressTextByValue(double value) {
    // if (value == (1 / 4)) {
    //   return S.of(context).pageSplash_progress1;
    // }
    // if (value == (2 / 4)) {
    //   return S.of(context).pageSplash_progress2;
    // } else if (value == (3 / 4)) {
    //   return S.of(context).pageSplash_progress3;
    // } else if (value == (4 / 4)) {
    //   return S.of(context).pageSplash_progress4;
    // } else {
    //   return '';
    // }
    return context.cl.translate('pages.splash.progressBar');
  }
}

class SplashDialog extends StatelessWidget {
  const SplashDialog({super.key, required this.description});
  final String description;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return Center(
      child: Material(
        borderRadius: BorderRadius.circular(32),
        child: Container(
          height: 120,
          width: size.width - 40,
          padding: const EdgeInsets.symmetric(horizontal: 20),
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(
            color: context.colors.primary,
            borderRadius: BorderRadius.circular(32),
            border: Border.all(
              color: Colors.black,
              width: 1,
            ),
          ),
          child: Column(
            children: [
              const SizedBox(height: 20),
              RichText(
                text: const TextSpan(
                  text: 'Error',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Text(
                description,
                style: const TextStyle(fontSize: 14),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
