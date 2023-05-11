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
        id: faker.datatype.number(max: 50),
        title: faker.lorem.sentence(),
        body: faker.lorem.paragraph(sentenceCount: 5),
      ),
    );
  }

  void delete(int idx) {
    update((previousPosts) {
      final posts = [...previousPosts];
      posts.removeAt(idx);
      return posts;
    });
  }
}

final postPageProvider =
    AutoDisposeAsyncNotifierProvider<PostPageProvider, List<PostsViewModel>>(
  PostPageProvider.new,
);
