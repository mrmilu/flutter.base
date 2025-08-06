import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../../../shared/presentation/utils/extensions/buildcontext_extensions.dart';
import '../../../../shared/presentation/utils/open_web_view_utils.dart';
import '../../../../shared/presentation/widgets/components/text/rm_text.dart';
import '../../../../splash/presentation/providers/splash_cubit.dart';
import '../../widgets/settings_item_widget.dart';

class InfoExtraPage extends StatelessWidget {
  const InfoExtraPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: RMText.titleMedium(
          context.cl.translate('pages.profileInfoInfoExtra.title'),
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
                      'pages.profileInfoInfoExtra.privacy.title',
                    ),
                    subtitle: context.cl.translate(
                      'pages.profileInfoInfoExtra.privacy.subtitle',
                    ),
                    onTap: () {
                      openWebView(
                        context: context,
                        title: context.cl.translate(
                          'pages.profileInfoInfoExtra.privacy.title',
                        ),
                        url: context.cl.translate('urls.privacyPolicy'),
                      );
                    },
                  ),
                  const SizedBox(height: 20),
                  SettingsItemWidget(
                    showIcon: false,
                    title: context.cl.translate(
                      'pages.profileInfoInfoExtra.terms.title',
                    ),
                    subtitle: context.cl.translate(
                      'pages.profileInfoInfoExtra.terms.subtitle',
                    ),
                    onTap: () {
                      openWebView(
                        context: context,
                        title: context.cl.translate(
                          'pages.profileInfoInfoExtra.terms.title',
                        ),
                        url: context.cl.translate(
                          'urls.termsAndConditions',
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 20),
                  SettingsItemWidget(
                    showIcon: false,
                    title: context.cl.translate(
                      'pages.profileInfoInfoExtra.legalNotice.title',
                    ),
                    subtitle: context.cl.translate(
                      'pages.profileInfoInfoExtra.legalNotice.subtitle',
                    ),
                    onTap: () {
                      openWebView(
                        context: context,
                        title: context.cl.translate(
                          'pages.profileInfoInfoExtra.legalNotice.title',
                        ),
                        url: context.cl.translate('urls.legalNotice'),
                      );
                    },
                  ),
                  const SizedBox(height: 20),
                  SettingsItemWidget(
                    showIcon: false,
                    showButton: false,
                    title: context.cl.translate(
                      'pages.profileInfoInfoExtra.appVersion.title',
                    ),
                    subtitle: appVersion,
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
