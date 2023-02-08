import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_base/ui/components/flutter_base_app_bar.dart';
import 'package:flutter_base/ui/components/images/network_image.dart';
import 'package:flutter_base/ui/components/text/high_text.dart';
import 'package:flutter_base/ui/components/views/column_scroll_view.dart';
import 'package:flutter_base/ui/features/profile/views/edit_avatar/containers/profile_photo_action_sheet.dart';
import 'package:flutter_base/ui/i18n/locale_keys.g.dart';
import 'package:flutter_base/ui/providers/user_provider.dart';
import 'package:flutter_base/ui/styles/spacing.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class ProfilePage extends ConsumerWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userProvider.select((state) => state.userData));
    return Scaffold(
      appBar: FlutterBaseAppBar(),
      body: ColumnScrollView(
        padding: const EdgeInsets.symmetric(horizontal: Spacing.sp16),
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              HighTextXl(
                user?.name ?? '---',
              ),
              GestureDetector(
                onTap: Feedback.wrapForTap(
                  () => _showActionSheet(context),
                  context,
                ),
                child: const CircleAvatar(
                  radius: 25,
                  child: ClipOval(
                    child: FlutterBaseNetworkImage(
                      'https://pbs.twimg.com/media/FKNlhKZUcAEd7FY?format=jpg&name=4096x4096',
                      fit: BoxFit.cover,
                      height: 25 * 2,
                    ),
                  ),
                ),
              ),
            ],
          ),
          ListTile(
            leading: const Icon(Icons.edit),
            title: Text(LocaleKeys.profile_options_edit.tr()),
            onTap: () {
              GoRouter.of(context).push('/profile/edit');
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.power_settings_new),
            onTap: () {
              ref.read(userProvider.notifier).logout();
            },
            title: Text(
              LocaleKeys.profile_options_logout.tr(),
            ),
          )
        ],
      ),
    );
  }

  void _showActionSheet(BuildContext context) {
    showCupertinoModalPopup(
      context: context,
      builder: (context) => const ProfilePhotoActionSheet(),
    );
  }
}