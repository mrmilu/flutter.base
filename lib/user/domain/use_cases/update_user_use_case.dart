import 'package:flutter_base/user/domain/interfaces/i_user_repository.dart';
import 'package:flutter_base/user/domain/models/update_user_input_model.dart';
import 'package:flutter_base/user/domain/models/user.dart';
import 'package:injectable/injectable.dart';

class UpdateUserUseCaseInput {
  final String? name;

  const UpdateUserUseCaseInput({this.name});
}

@Injectable()
class UpdateUserUseCase {
  final IUserRepository _userRepository;

  UpdateUserUseCase(this._userRepository);

  Future<User> call(UpdateUserUseCaseInput input) {
    final repoInput = UpdateUserInputModel(name: input.name);
    return _userRepository.update(repoInput);
  }
}
