import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../auth/presentation/providers/auth/auth_cubit.dart';
import '../../../shared/presentation/extensions/buildcontext_extensions.dart';
import '../../../shared/presentation/router/app_router.dart';
import '../../../shared/presentation/router/page_names.dart';
import '../../../shared/presentation/utils/assets/app_assets_icons.dart';
import '../../../shared/presentation/utils/styles/colors/colors_context.dart';
import '../../../shared/presentation/widgets/common/image_asset_widget.dart';
import '../../../shared/presentation/widgets/components/buttons/custom_text_button.dart';
import '../../../shared/presentation/widgets/components/text/rm_text.dart';
import '../../../shared/presentation/widgets/wrapper_bottom_sheet_with_button.dart';
import '../settings_delete_account/modal_delete_account_widget.dart';
import '../widgets/modal_logout_widget.dart';
import '../widgets/settings_item_widget.dart';

class ProfileInfoPage extends StatelessWidget {
  const ProfileInfoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children:
                    [
                          BlocBuilder<AuthCubit, AuthState>(
                            builder: (context, stateAuth) {
                              final userName = stateAuth.user?.name ?? '';
                              return Row(
                                children: [
                                  const ImageAssetWidget(
                                    path: AppAssetsIcons.topBarProfile,
                                    width: 24,
                                    height: 24,
                                  ),
                                  const SizedBox(width: 12),
                                  Flexible(
                                    child: RMText.titleSmall(userName),
                                  ),
                                ],
                              );
                            },
                          ),
                          const SizedBox(height: 32),
                          SettingsItemWidget(
                            title: context.cl.translate(
                              'pages.profileInfo.personalData.title',
                            ),
                            subtitle: context.cl.translate(
                              'pages.profileInfo.personalData.subtitle',
                            ),
                            onTap: () => routerApp.pushNamed(
                              PageNames.profileInfoPersonalData,
                            ),
                          ),
                          const SizedBox(height: 20),
                          SettingsItemWidget(
                            title: context.cl.translate(
                              'pages.profileInfo.accessData.title',
                            ),
                            subtitle: context.cl.translate(
                              'pages.profileInfo.accessData.subtitle',
                            ),
                            onTap: () => routerApp.pushNamed(
                              PageNames.profileInfoAccessData,
                            ),
                          ),
                          const SizedBox(height: 52),
                          SettingsItemWidget(
                            title: context.cl.translate(
                              'pages.profileInfo.settings.title',
                            ),
                            subtitle: context.cl.translate(
                              'pages.profileInfo.settings.subtitle',
                            ),
                            onTap: () => routerApp.pushNamed(
                              PageNames.profileInfoSettingsConfig,
                            ),
                          ),
                          const SizedBox(height: 20),
                          SettingsItemWidget(
                            title: context.cl.translate(
                              'pages.profileInfo.infoExtra.title',
                            ),
                            subtitle: context.cl.translate(
                              'pages.profileInfo.infoExtra.subtitle',
                            ),
                            onTap: () => routerApp.pushNamed(
                              PageNames.profileInfoInfoExtra,
                            ),
                          ),
                          const SizedBox(height: 52),
                          CustomTextButton.iconSecondary(
                            onPressed: () async => showModalBottomSheet(
                              context: context,
                              isScrollControlled: true,
                              routeSettings: const RouteSettings(
                                name: PageNames.modalLogout,
                              ),
                              builder: (context) =>
                                  WrapperBottomSheetWithButton(
                                    hasScroll: false,
                                    title: context.cl.translate(
                                      'modals.logout.title',
                                    ),
                                    child: const ModalLogoutWidget(),
                                  ),
                            ),
                            label: context.cl.translate(
                              'pages.profileInfo.logout',
                            ),
                            iconPath: AppAssetsIcons.arrowRight,
                          ),
                          CustomTextButton.icon(
                            onPressed: () => showModalDeleteAccount(context),
                            label: context.cl.translate(
                              'pages.profileInfo.deleteAccount',
                            ),
                            iconPath: AppAssetsIcons.arrowRight,
                            colorText: context.colors.specificSemanticError,
                          ),
                          SizedBox(height: context.paddingBottomPlus),
                        ]
                        .animate(
                          delay: 200.milliseconds,
                          interval: 40.milliseconds,
                        )
                        .slideY()
                        .fadeIn(),
              ),
              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }
}
