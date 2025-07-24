import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../auth/domain/interfaces/i_token_repository.dart';
import '../../../auth/presentation/pages/initial_page.dart';
import '../../../auth/presentation/providers/auth/auth_cubit.dart';
import '../../../shared/presentation/l10n/generated/l10n.dart';
import '../../../shared/presentation/router/app_router.dart';
import '../../../shared/presentation/router/page_names.dart';
import '../../../shared/presentation/utils/styles/colors.dart';
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
        PageNames.initial,
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
    // final size = MediaQuery.sizeOf(context);
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
          if (state.errorLoading) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Huebo un error al cargar la app'),
                backgroundColor: AppColors.specificSemanticError,
              ),
            );
          }
        },
        builder: (context, stateSplash) {
          final size = MediaQuery.sizeOf(context);
          return Scaffold(
            backgroundColor: AppColors.specificBasicWhite,
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
                                  size: 200,
                                ),
                              );
                            },
                          ),
                          stateSplash.canUpdate
                              ? Column(
                                  children: [
                                    const SizedBox(height: 70),
                                    Text(
                                      S.of(context).pageSplashUpdateAvailable,
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 24,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(height: 20),
                                    SizedBox(
                                      width: size.width * 0.65,
                                      child: Text(
                                        S
                                            .of(context)
                                            .pageSplashUpdateAvailableDesc,
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 18,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                    SizedBox(height: size.height * 0.2),
                                  ],
                                )
                              : const SizedBox.shrink(),
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
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                padding: const EdgeInsets.all(20.0),
                                backgroundColor: AppColors.secondary,
                              ),
                              onPressed: context
                                  .read<SplashCubit>()
                                  .onTapUpdateApp,
                              child: Text(
                                S.of(context).pageSplashUpdate,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                ),
                              ),
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
                                backgroundColor: AppColors.secondary,
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
                        bottom: 43,
                        left: 33,
                        right: 33,
                        child: Column(
                          children: [
                            Text(
                              _getProgressTextByValue(
                                stateSplash.progressValue,
                              ),
                              style: const TextStyle(color: Colors.white),
                            ),
                            const SizedBox(height: 16),
                            ClipRRect(
                              borderRadius: const BorderRadius.all(
                                Radius.circular(10),
                              ),
                              child: Container(
                                height: 8,
                                width: size.width - 66,
                                color: AppColors.tertiary,
                                alignment: Alignment.centerLeft,
                                child: ClipRRect(
                                  borderRadius: const BorderRadius.all(
                                    Radius.circular(10),
                                  ),
                                  child: AnimatedContainer(
                                    duration: const Duration(
                                      milliseconds: 300,
                                    ),
                                    curve: Curves.easeInOut,
                                    color: Colors.white,
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
    if (value == (1 / 4)) {
      return S.of(context).pageSplash_progress1;
    }
    if (value == (2 / 4)) {
      return S.of(context).pageSplash_progress2;
    } else if (value == (3 / 4)) {
      return S.of(context).pageSplash_progress3;
    } else if (value == (4 / 4)) {
      return S.of(context).pageSplash_progress4;
    } else {
      return '';
    }
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
            color: AppColors.primary,
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
