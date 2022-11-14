import 'package:flutter_base/ui/providers/ui_provider.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod/riverpod.dart';

part 'post_page_provider.freezed.dart';

@freezed
class PostPageState with _$PostPageState {
  factory PostPageState({
    @Default([]) List<dynamic> posts,
    @Default(false) refreshing,
  }) = _PostPageState;
}

class PostPageProvider extends StateNotifier<PostPageState> {
  late final UiProvider _uiProvider;

  PostPageProvider(AutoDisposeStateNotifierProviderRef ref)
      : super(PostPageState()) {
    _uiProvider = ref.watch(uiProvider.notifier);
    Future.delayed(Duration.zero, () => _init());
  }

  _init() async {
    _uiProvider.showGlobalLoader();
    try {
      final posts = [];
      state = state.copyWith(posts: posts);
    } finally {
      _uiProvider.hideGlobalLoader();
    }
  }
}

final postPageProvider =
    AutoDisposeStateNotifierProvider<PostPageProvider, PostPageState>(
        (ref) => PostPageProvider(ref));
