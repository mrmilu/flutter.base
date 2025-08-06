import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../../../shared/presentation/router/app_router.dart';
import '../../../../shared/presentation/router/page_names.dart';
import '../../../../shared/presentation/utils/extensions/buildcontext_extensions.dart';
import '../../../../shared/presentation/widgets/components/text/rm_text.dart';
import '../../widgets/settings_item_widget.dart';

class SettingsConfigPage extends StatelessWidget {
  const SettingsConfigPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: RMText.titleMedium(
          context.cl.translate('pages.profileInfoConfig.title'),
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
                  SettingsItemWidget(
                    showIcon: false,
                    title: context.cl.translate(
                      'pages.profileInfoConfig.languages.title',
                    ),
                    subtitle: context.cl.translate(
                      'pages.profileInfoConfig.languages.subtitle',
                    ),
                    onTap: () {
                      routerApp.pushNamed(PageNames.settingsChangeLanguage);
                    },
                  ),
                  const SizedBox(height: 20),
                  SettingsItemWidget(
                    isActive: false,
                    showIcon: false,
                    title: context.cl.translate(
                      'pages.profileInfoConfig.notifications.title',
                    ),
                    subtitle: context.cl.translate(
                      'pages.profileInfoConfig.notifications.subtitle',
                    ),
                    onTap: () {},
                  ),
                ].animate(interval: 40.milliseconds).slideY().fadeIn(),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
