import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_base/ui/i18n/locale_keys.g.dart';
import 'package:flutter_base/ui/providers/user_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class ProfilePage extends ConsumerWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userProvider.select((state) => state.userData));
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          CupertinoSliverNavigationBar(
            backgroundColor:
                Theme.of(context).colorScheme.inversePrimary.withOpacity(0.87),
            largeTitle: Text(
              LocaleKeys.profile_title.tr(),
              style: TextStyle(color: Theme.of(context).colorScheme.onPrimary),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.all(16),
            sliver: SliverToBoxAdapter(
              child: Row(
                children: [
                  // ProfileAvatar(
                  //   user: user,
                  //   onTap: () => _showActionSheet(context),
                  // ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          user?.name ?? "---",
                          style: Theme.of(context).textTheme.headline5,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            sliver: SliverList(
              delegate: SliverChildListDelegate(
                [
                  ListTile(
                    leading: const Icon(CupertinoIcons.pencil),
                    title: Text(LocaleKeys.profile_options_edit.tr()),
                    onTap: () {
                      GoRouter.of(context).push("/profile/edit");
                    },
                  ),
                  const Divider(),
                  ListTile(
                    leading: const Icon(CupertinoIcons.power),
                    onTap: () {
                      ref.read(userProvider.notifier).logout();
                    },
                    title: Text(
                      LocaleKeys.profile_options_logout.tr(),
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  // _showActionSheet(BuildContext context) {
  //   showCupertinoModalPopup(
  //     context: context,
  //     builder: (context) => const ProfilePhotoActionSheet(),
  //   );
  // }
}
