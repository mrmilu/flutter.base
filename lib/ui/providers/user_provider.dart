import 'package:flutter_base/core/auth/domain/use_cases/logout_use_case.dart';
import 'package:flutter_base/core/user/domain/use_cases/user_and_cats_use_case.dart';
import 'package:flutter_base/ui/providers/ui_provider.dart';
import 'package:flutter_base/ui/view_models/user_view_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';

part 'user_provider.freezed.dart';

@freezed
class UserState with _$UserState {
  factory UserState({
    UserViewModel? userData,
  }) = _UserState;
}

class UserProvider extends StateNotifier<UserState> {
  final _userAndCatsUseCase = GetIt.I.get<GetUserUseCase>();
  final LogoutUseCase _logoutUseCase = GetIt.I.get<LogoutUseCase>();
  late final UiProvider _uiProvider;

  UserProvider(StateNotifierProviderRef ref) : super(UserState()) {
    _uiProvider = ref.watch(uiProvider.notifier);
  }

  setUserVerified() {
    state = state.copyWith(userData: state.userData?.copyWith(verified: true));
  }

  setUserData(UserViewModel data) {
    state = state.copyWith(userData: data);
  }

  clearProvider() {
    state = UserState();
  }

  getInitialUserData() async {
    final user = await _userAndCatsUseCase();
    setUserData(user.toViewModel());
  }

  logout() async {
    _uiProvider.tryAction(() async {
      await _logoutUseCase();
      GetIt.I.get<GoRouter>().go("/");
      clearProvider();
    });
  }
}

final userProvider =
    StateNotifierProvider<UserProvider, UserState>((ref) => UserProvider(ref));

final userVerifiedComputedProvider = Provider.autoDispose<bool>((ref) => ref
    .watch(userProvider.select((state) => state.userData?.verified == true)));
