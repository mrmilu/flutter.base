import 'package:flutter_base/src/auth/application/use_cases/logout_use_case.dart';
import 'package:flutter_base/src/shared/presentation/states/ui_provider.dart';
import 'package:flutter_base/src/user/domain/models/user.dart';
import 'package:flutter_base/src/user/domain/use_cases/get_user_use_case.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:get_it/get_it.dart';

part 'user_provider.freezed.dart';

@freezed
class UserState with _$UserState {
  factory UserState({
    User? userData,
  }) = _UserState;
}

class UserNotifier extends Notifier<UserState> {
  final _userUseCase = GetIt.I.get<GetUserUseCase>();
  final LogoutUseCase _logoutUseCase = GetIt.I.get<LogoutUseCase>();

  @override
  UserState build() {
    return UserState();
  }

  void setUserVerified() {
    state = state.copyWith(userData: state.userData?.copyWith(verified: true));
  }

  void setUserData(User data) {
    state = state.copyWith(userData: data);
  }

  void clearProvider() {
    state = UserState();
  }

  Future<void> getInitialUserData() async {
    final user = await _userUseCase();
    setUserData(user);
  }

  Future<void> logout() async {
    ref.read(uiProvider.notifier).tryAction(() async {
      await _logoutUseCase();
      clearProvider();
    });
  }
}

final userProvider =
    NotifierProvider<UserNotifier, UserState>(UserNotifier.new);

final userVerifiedComputedProvider = Provider.autoDispose<bool>(
  (ref) => ref
      .watch(userProvider.select((state) => state.userData?.verified == true)),
);
