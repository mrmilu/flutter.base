import 'package:flutter/material.dart';
import 'package:flutter_base/src/posts/presentation/states/post_page_provider.dart';
import 'package:flutter_base/src/shared/domain/types/button_size.dart';
import 'package:flutter_base/src/shared/presentation/states/ui_provider.dart';
import 'package:flutter_base/src/shared/presentation/utils/styles/border_radius.dart';
import 'package:flutter_base/src/shared/presentation/utils/styles/box_shadows.dart';
import 'package:flutter_base/src/shared/presentation/utils/styles/colors.dart';
import 'package:flutter_base/src/shared/presentation/utils/styles/insets.dart';
import 'package:flutter_base/src/shared/presentation/widgets/components/buttons/icon_button_primary.dart';
import 'package:flutter_base/src/shared/presentation/widgets/components/error_message.dart';
import 'package:flutter_base/src/shared/presentation/widgets/components/flutter_base_app_bar.dart';
import 'package:flutter_base/src/shared/presentation/widgets/components/text/high_text.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class PostPage extends ConsumerWidget {
  const PostPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final postsProvider = ref.watch(postPageProvider);
    final uiNotifier = ref.watch(uiProvider.notifier);

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if (postsProvider.isLoading) uiNotifier.showGlobalLoader();
    });
    ref.listen(postPageProvider, (previous, next) {
      if (previous?.isLoading == true && !next.isLoading) {
        uiNotifier.hideGlobalLoader();
      }
    });

    return Scaffold(
      appBar: FlutterBaseAppBar(
        title: HighText.m('Posts'),
      ),
      body: postsProvider.when(
        loading: () => const SizedBox.shrink(),
        error: (e, __) => ErrorMessage(error: e),
        data: (posts) => RefreshIndicator(
          onRefresh: () async {
            ref.invalidate(postPageProvider);
          },
          child: ListView.separated(
            padding: Insets.a16,
            itemCount: posts.length,
            itemBuilder: (context, idx) {
              final post = posts[idx];
              return DecoratedBox(
                decoration: BoxDecoration(
                  boxShadow: BoxShadows.bs1,
                  color: FlutterBaseColors.specificBasicWhite,
                  borderRadius: CircularBorderRadius.br8,
                ),
                child: ListTile(
                  title: Text(post.title),
                  subtitle: Text(
                    post.body,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    softWrap: false,
                  ),
                  onTap: () {
                    GoRouter.of(context).push('/home/${post.id}');
                  },
                  trailing: IconButtonPrimary(
                    icon: Icons.delete,
                    size: ButtonSize.small,
                    onPressed: () {
                      ref.read(postPageProvider.notifier).delete(idx);
                    },
                  ),
                ),
              );
            },
            separatorBuilder: (BuildContext context, int index) {
              return const Divider(
                height: 20,
                color: Colors.transparent,
              );
            },
          ),
        ),
      ),
    );
  }
}
