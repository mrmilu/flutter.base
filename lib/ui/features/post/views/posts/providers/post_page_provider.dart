import 'package:faker_dart/faker_dart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_base/ui/features/post/view_models/posts_view_model.dart';
import 'package:flutter_base/ui/providers/ui_provider.dart';
import 'package:riverpod/riverpod.dart';

class PostPageProvider extends AutoDisposeNotifier<List<PostsViewModel>> {
  @override
  List<PostsViewModel> build() {
    final uiNotifier = ref.watch(uiProvider.notifier);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      uiNotifier.showGlobalLoader();
    });
    final faker = Faker.instance;
    try {
      final posts = List.generate(
        50,
        (index) => PostsViewModel(
          title: faker.lorem.sentence(),
          body: faker.lorem.paragraph(sentenceCount: 5),
        ),
      );
      return posts;
    } finally {
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        uiNotifier.hideGlobalLoader();
      });
    }
  }

  void delete(int idx) {
    final cloneState = [...state];
    cloneState.removeAt(idx);
    state = cloneState;
  }
}

final postPageProvider =
    AutoDisposeNotifierProvider<PostPageProvider, List<PostsViewModel>>(
  PostPageProvider.new,
);
