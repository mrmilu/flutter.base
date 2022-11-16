import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_base/ui/pages/post/providers/post_page_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PostPage extends ConsumerWidget {
  const PostPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final posts = ref.watch(postPageProvider.select((state) => state.posts));

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: CupertinoNavigationBar(
        backgroundColor:
            Theme.of(context).colorScheme.inversePrimary.withOpacity(0.86),
        middle: Text(
          "Posts",
          style: TextStyle(
            color: Theme.of(context).colorScheme.onPrimary,
          ),
        ),
      ),
      body: Builder(
        builder: (context) {
          return ListView.builder(
            itemCount: posts.length,
            padding: const EdgeInsets.all(16),
            itemBuilder: (context, idx) {
              dynamic post = posts[idx];
              final tileWidget = ListTile(
                title: Text(post.title),
                subtitle: Text(
                  post.body.replaceAll("\n", " "),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  softWrap: false,
                ),
              );
              if (idx == 0) {
                return Column(
                  children: [
                    SizedBox(height: Scaffold.of(context).appBarMaxHeight ?? 0),
                    tileWidget,
                  ],
                );
              } else {
                return tileWidget;
              }
            },
          );
        },
      ),
    );
  }
}
