import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_base/ui/components/box_spacer.dart';
import 'package:flutter_base/ui/components/buttons/button_tertiary.dart';
import 'package:flutter_base/ui/components/loaders/circular_progress.dart';
import 'package:flutter_base/ui/components/text/high_text.dart';
import 'package:flutter_base/ui/features/auth/containers/info_app/info_app_provider.dart';
import 'package:flutter_base/ui/i18n/locale_keys.g.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class InfoAppButton extends StatelessWidget {
  const InfoAppButton({super.key});

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(maxHeight: 56),
      child: Consumer(
        builder: (context, ref, child) {
          final watcher = ref.watch(infoAppProvider);
          return watcher.when(
            data: (platformInfo) => ButtonTertiary(
              text: platformInfo.version,
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) => SimpleDialog(
                    contentPadding: const EdgeInsets.all(24),
                    title: HighText.m(LocaleKeys.platform_info_title.tr()),
                    children: [
                      HighText.m(
                        LocaleKeys.platform_info_app_name
                            .tr(args: [platformInfo.appName]),
                      ),
                      BoxSpacer.v12(),
                      HighText.m(
                        LocaleKeys.platform_info_package_name
                            .tr(args: [platformInfo.packageName]),
                      ),
                      BoxSpacer.v12(),
                      HighText.m(
                        LocaleKeys.platform_info_version
                            .tr(args: [platformInfo.version]),
                      ),
                      BoxSpacer.v12(),
                      HighText.m(
                        LocaleKeys.platform_info_build_number
                            .tr(args: [platformInfo.buildNumber]),
                      ),
                      BoxSpacer.v12(),
                    ],
                  ),
                );
              },
            ),
            error: (error, stackTrace) => const SizedBox.shrink(),
            loading: () => const CircularProgress(radius: 12),
          );
        },
      ),
    );
  }
}
