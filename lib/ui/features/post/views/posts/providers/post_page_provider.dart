import 'package:faker_dart/faker_dart.dart';
import 'package:flutter_base/ui/features/post/view_models/posts_view_model.dart';
import 'package:riverpod/riverpod.dart';

class PostPageProvider extends AutoDisposeAsyncNotifier<List<PostsViewModel>> {
  @override
  Future<List<PostsViewModel>> build() async {
    await Future.delayed(const Duration(seconds: 2));
    final faker = Faker.instance;
    return List.generate(
      50,
      (index) => PostsViewModel(
        title: faker.lorem.sentence(),
        body: faker.lorem.paragraph(sentenceCount: 5),
      ),
    );
  }

  void delete(int idx) {
    final clonePosts = [...state.value!];
    clonePosts.removeAt(idx);
    state = AsyncData(clonePosts);
  }
}

final postPageProvider =
AutoDisposeAsyncNotifierProvider<PostPageProvider, List<PostsViewModel>>(
  PostPageProvider.new,
);
