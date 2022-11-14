import 'package:injectable/injectable.dart';
import 'package:flutter_base/core/auth/domain/interfaces/auth_repository.dart';
import 'package:flutter_base/core/auth/domain/models/change_password_input_model.dart';

class ChangePasswordUseCaseInput {
  final String uid;
  final String token;
  final String password;
  final String repeatPassword;

  const ChangePasswordUseCaseInput({
    required this.uid,
    required this.token,
    required this.password,
    required this.repeatPassword,
  });
}

@Injectable()
class ChangePasswordUseCase {
  final IAuthRepository _authRepository;

  ChangePasswordUseCase(this._authRepository);

  call(ChangePasswordUseCaseInput input) {
    final repositoryInput = ChangePasswordInputModel(
      uid: input.uid,
      token: input.token,
      password: input.password,
      repeatPassword: input.repeatPassword,
    );
    return _authRepository.changePassword(repositoryInput);
  }
}
