import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:flutter_base/src/shared/application/ui_provider.dart';
import 'package:flutter_base/src/user/application/user_provider.dart';
import 'package:flutter_base/src/user/domain/use_cases/update_user_use_case.dart';
import 'package:flutter_base/src/user/presentation/view_models/edit_profile_view_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';

class EditProfileNotifier extends AutoDisposeNotifier<EditProfileModelForm> {
  final _updateUserUseCase = GetIt.I.get<UpdateUserUseCase>();
  final _appRouter = GetIt.I.get<GoRouter>();

  @override
  EditProfileModelForm build() {
    final user = ref.watch(userProvider.select((state) => state.userData));
    return EditProfileViewModel(name: user?.name ?? '').generateFormModel;
  }

  Future<void> updateProfile() async {
    final userNotifier = ref.watch(userProvider.notifier);
    final uiNotifier = ref.watch(uiProvider.notifier);
    final formModel = state;
    formModel.form.markAllAsTouched();
    if (formModel.form.valid) {
      uiNotifier.tryAction(() async {
        FocusManager.instance.primaryFocus?.unfocus();
        final input = UpdateUserUseCaseInput(
          name: formModel.model.name.trim(),
        );
        final user = await _updateUserUseCase(input);
        userNotifier.setUserData(user);
        _appRouter.pop();
      });
    }
  }
}

final editProfileProvider =
    AutoDisposeNotifierProvider<EditProfileNotifier, EditProfileModelForm>(
  EditProfileNotifier.new,
);
