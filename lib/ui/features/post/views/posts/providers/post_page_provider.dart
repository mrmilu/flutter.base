import 'package:faker_dart/faker_dart.dart';
import 'package:flutter_base/ui/features/post/view_models/posts_view_model.dart';
import 'package:flutter_base/ui/providers/ui_provider.dart';
import 'package:riverpod/riverpod.dart';

class PostPageProvider extends AutoDisposeNotifier<List<PostsViewModel>> {
  @override
  List<PostsViewModel> build() => [];

  Future<void> loadPosts() async {
    final uiNotifier = ref.watch(uiProvider.notifier);
    uiNotifier.showGlobalLoader();
    final faker = Faker.instance;
    try {
      await Future.delayed(const Duration(seconds: 1));
      state = List.generate(
        50,
        (index) => PostsViewModel(
          title: faker.lorem.sentence(),
          body: faker.lorem.paragraph(sentenceCount: 5),
        ),
      );
    } finally {
      uiNotifier.hideGlobalLoader();
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
