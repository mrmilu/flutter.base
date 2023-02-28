import 'package:flutter/material.dart';
import 'package:flutter_base/ui/components/buttons/icon_button_primary.dart';
import 'package:flutter_base/ui/components/flutter_base_app_bar.dart';
import 'package:flutter_base/ui/features/post/views/posts/providers/post_page_provider.dart';
import 'package:flutter_base/ui/styles/border_radius.dart';
import 'package:flutter_base/ui/styles/box_shadows.dart';
import 'package:flutter_base/ui/styles/colors.dart';
import 'package:flutter_base/ui/styles/spacing.dart';
import 'package:flutter_base/ui/view_models/button_size.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PostPage extends ConsumerStatefulWidget {
  const PostPage({super.key});

  @override
  ConsumerState createState() => _PostPageState();
}

class _PostPageState extends ConsumerState<PostPage> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      ref.read(postPageProvider.notifier).loadPosts();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final posts = ref.watch(postPageProvider);
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: FlutterBaseAppBar(),
      body: RefreshIndicator(
        onRefresh: () => ref.read(postPageProvider.notifier).loadPosts(),
        child: Builder(
          builder: (context) {
            final basePadding = MediaQuery.of(context).padding;
            return ListView.separated(
              padding: basePadding.copyWith(
                left: Spacing.sp16,
                right: Spacing.sp16,
                top: basePadding.top + Spacing.sp16,
                bottom: 100,
              ),
              itemCount: posts.length,
              itemBuilder: (context, idx) {
                dynamic post = posts[idx];
                final tileWidget = DecoratedBox(
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
                    trailing: IconButtonPrimary(
                      icon: Icons.delete,
                      size: ButtonSize.small,
                      onPressed: () {
                        ref.read(postPageProvider.notifier).delete(idx);
                      },
                    ),
                  ),
                );
                return tileWidget;
              },
              separatorBuilder: (BuildContext context, int index) {
                return const Divider(
                  height: 20,
                  color: Colors.transparent,
                );
              },
            );
          },
        ),
      ),
    );
  }
}
