import 'dart:async';

import 'package:flutter_base/src/posts/application/post_page_provider.dart';
import 'package:flutter_base/src/posts/presentation/view_models/posts_view_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DetailPostNotifier
    extends AutoDisposeFamilyAsyncNotifier<PostsViewModel, int> {
  @override
  FutureOr<PostsViewModel> build(int arg) async {
    final list = await ref.watch(postPageProvider.notifier).future;
    return list.firstWhere((post) => post.id == arg);
  }
}

final detailPostProvider = AutoDisposeAsyncNotifierProviderFamily<
    DetailPostNotifier, PostsViewModel, int>(
  DetailPostNotifier.new,
  dependencies: [postPageProvider],
);
