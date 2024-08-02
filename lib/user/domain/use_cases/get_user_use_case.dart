import 'package:flutter_base/user/domain/interfaces/i_user_repository.dart';
import 'package:flutter_base/user/domain/models/user.dart';
import 'package:injectable/injectable.dart';

@Injectable()
class GetUserUseCase {
  final IUserRepository _userRepository;

  GetUserUseCase(this._userRepository);

  Future<User> call() {
    return _userRepository.getLoggedUser();
  }
}
