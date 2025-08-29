import 'package:flutter/material.dart';

import '../../shared/presentation/extensions/buildcontext_extensions.dart';
import '../../shared/presentation/extensions/color_extension.dart';
import '../../shared/presentation/router/app_router.dart';
import '../../shared/presentation/router/page_names.dart';
import '../../shared/presentation/utils/styles/colors/colors_context.dart';
import '../../shared/presentation/widgets/common/image_asset_widget.dart';
import '../../shared/presentation/widgets/components/buttons/custom_elevated_button.dart';
import '../../shared/presentation/widgets/components/buttons/custom_text_button.dart';
import '../../shared/presentation/widgets/components/text/rm_text.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<OnboardingData> _onboardingData = [
    OnboardingData(
      imagePath: 'assets/images/ente_partial.png',
      title: 'Bienvenido a Flutter Base',
      description:
          'Descubre todas las funcionalidades que tenemos preparadas para ti en esta increíble aplicación.',
    ),
    OnboardingData(
      imagePath: 'assets/images/ente_partial.png',
      title: 'Gestiona tus proyectos',
      description:
          'Organiza y administra todos tus proyectos de manera eficiente desde un solo lugar.',
    ),
    OnboardingData(
      imagePath: 'assets/images/ente_partial.png',
      title: 'Comienza tu experiencia',
      description:
          'Todo está listo para que comiences a disfrutar de una experiencia única y personalizada.',
    ),
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onPageChanged(int page) {
    setState(() {
      _currentPage = page;
    });
  }

  void _onSkip() {
    // Navegar directamente a la última página o cerrar onboarding
    _pageController.animateToPage(
      _onboardingData.length - 1,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  void _onContinue() {
    if (_currentPage < _onboardingData.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      // Finalizar onboarding
      _finishOnboarding();
    }
  }

  void _finishOnboarding() {
    routerApp.pushReplacementNamed(PageNames.initial);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Skip button en la parte superior derecha
            _buildSkipButton(),

            // Contenido principal expandido
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                onPageChanged: _onPageChanged,
                itemCount: _onboardingData.length,
                itemBuilder: (context, index) {
                  return _buildOnboardingSlide(_onboardingData[index]);
                },
              ),
            ),

            // Indicadores de página (dots)
            _buildPageIndicators(),

            const SizedBox(height: 32),

            // Botón Continue en la parte inferior
            _buildContinueButton(),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildSkipButton() {
    return Padding(
      padding: const EdgeInsets.only(top: 16, right: 16),
      child: Align(
        alignment: Alignment.topRight,
        child: CustomTextButton.secondary(
          onPressed: _onSkip,
          label: context.cl.translate('pages.onboarding.skip'),
        ),
      ),
    );
  }

  Widget _buildOnboardingSlide(OnboardingData data) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const SizedBox(height: 60),
          // Imagen
          Container(
            height: 250,
            width: 250,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: context.colors.specificSurfaceLow,
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: ImageAssetWidget(
                path: data.imagePath,
                fit: BoxFit.cover,
              ),
            ),
          ),

          const SizedBox(height: 48),

          // Título
          RMText.headlineMedium(
            data.title,
            textAlign: TextAlign.center,
            color: context.colors.onBackground,
          ),

          const SizedBox(height: 16),

          // Descripción
          RMText.bodyLarge(
            data.description,
            textAlign: TextAlign.center,
            color: context.colors.onBackground.wOpacity(0.7),
          ),
        ],
      ),
    );
  }

  Widget _buildPageIndicators() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        _onboardingData.length,
        (index) => AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          margin: const EdgeInsets.symmetric(horizontal: 4),
          height: 8,
          width: _currentPage == index ? 24 : 8,
          decoration: BoxDecoration(
            color: _currentPage == index
                ? context.colors.specificBasicBlack
                : context.colors.specificBasicBlack.wOpacity(0.2),
            borderRadius: BorderRadius.circular(4),
          ),
        ),
      ),
    );
  }

  Widget _buildContinueButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32),
      child: CustomElevatedButton.primary(
        onPressed: _onContinue,
        label: _currentPage == _onboardingData.length - 1
            ? context.cl.translate('pages.onboarding.finish')
            : context.cl.translate('pages.onboarding.continue'),
      ),
    );
  }
}

class OnboardingData {
  final String imagePath;
  final String title;
  final String description;

  OnboardingData({
    required this.imagePath,
    required this.title,
    required this.description,
  });
}
